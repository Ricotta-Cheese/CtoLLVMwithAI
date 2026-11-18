"""Optional training-stack checks; dataset generation still has no Python dependencies."""
from pathlib import Path
import tempfile
import unittest
import sys

try:
    import torch
    import tokenizers
except ImportError as error:
    raise unittest.SkipTest('training checks require PyTorch and tokenizers') from error

sys.path.insert(0, str(Path(__file__).resolve().parents[1] / 'training'))
import scratch

ROOT = Path(__file__).resolve().parents[1]
DATASET_SHA = 'eee59320108906a40ea3027b42bcc699428d137f9ba11c74140dc23efddda832'


class ScratchTrainingTests(unittest.TestCase):
    @classmethod
    def setUpClass(cls):
        torch.set_num_threads(1)
        cls.rows = scratch.load_rows(ROOT / 'artifacts/dataset.jsonl', DATASET_SHA)
        cls.splits = scratch.split_rows(cls.rows, 20261113)
        cls.tokenizer = scratch.train_tokenizer(cls.splits['train'], 512)

    def small_model(self):
        return scratch.ScratchCausalLM(self.tokenizer.get_vocab_size(), context_length=64,
                                       d_model=32, n_heads=4, n_layers=2, dropout=0.1)

    def features(self):
        # Artificial short training examples exercise the actual optimizer/checkpoint loop cheaply.
        return [{'id': str(i), 'input_ids': [10, 11, 3, 20 + i, 21, 1],
                 'labels': [-100, -100, -100, 20 + i, 21, 1], 'prefix_length': 3} for i in range(4)]

    def test_dataset_hash_and_stratified_nonoverlapping_split(self):
        self.assertEqual({key: len(value) for key, value in self.splits.items()}, {'train': 80, 'validation': 10, 'test': 10})
        groups = [{row['structure_id'] for row in self.splits[key]} for key in ('train', 'validation', 'test')]
        self.assertFalse(groups[0] & groups[1] or groups[0] & groups[2] or groups[1] & groups[2])
        self.assertEqual(self.splits, scratch.split_rows(list(reversed(self.rows)), 20261113))
        with self.assertRaisesRegex(ValueError, 'SHA-256'):
            scratch.load_rows(ROOT / 'artifacts/dataset.jsonl', 'wrong')

    def test_roundtrip_prompt_mask_eos_supervision_and_no_truncation(self):
        rows = self.splits['validation'][:2]
        features = scratch.encode_rows(rows, self.tokenizer, 10000)
        for row, feature in zip(rows, features):
            split = feature['prefix_length']
            self.assertTrue(all(label == -100 for label in feature['labels'][:split]))
            self.assertEqual(feature['labels'][-1], self.tokenizer.token_to_id('<|eos|>'))
            self.assertEqual(self.tokenizer.decode(feature['input_ids'][split:-1]), row['completion'])
        batch = scratch.make_batch(features, self.tokenizer.token_to_id('<|pad|>'), 'cpu')
        self.assertTrue(torch.all(batch['labels'][~batch['attention_mask']] == -100))
        with self.assertRaisesRegex(ValueError, 'do not truncate'):
            scratch.encode_rows(rows, self.tokenizer, 10)

    def test_causal_attention_and_independent_layer_initialization(self):
        torch.manual_seed(99)
        model = self.small_model().eval()
        one = torch.tensor([[10, 11, 12, 13, 14]])
        two = torch.tensor([[10, 11, 90, 91, 92]])
        with torch.no_grad():
            left = model(one, torch.ones_like(one, dtype=torch.bool))
            right = model(two, torch.ones_like(two, dtype=torch.bool))
        torch.testing.assert_close(left[:, :2], right[:, :2], atol=1e-6, rtol=1e-6)
        self.assertFalse(torch.equal(model.blocks.layers[0].self_attn.in_proj_weight, model.blocks.layers[1].self_attn.in_proj_weight))
        self.assertEqual(model.lm_head.weight.data_ptr(), model.token_embedding.weight.data_ptr())

    def test_completion_loss_ignores_prompt_labels(self):
        class FixedLogits(torch.nn.Module):
            def forward(self, ids, mask):
                output = torch.zeros(ids.shape[0], ids.shape[1], 8)
                # Predict supervised token 4 from position 2 and token 1 from position 3.
                output[0, 2, 4] = 20
                output[0, 3, 1] = 20
                return output
        batch = {'input_ids': torch.tensor([[2, 6, 3, 4, 1]]),
                 'attention_mask': torch.ones(1, 5, dtype=torch.bool),
                 'labels': torch.tensor([[-100, -100, -100, 4, 1]])}
        loss, count = scratch.loss_sum(FixedLogits(), batch)
        self.assertEqual(count, 2)
        self.assertLess(loss.item(), 1e-5)

    def test_interruption_resume_matches_uninterrupted_training(self):
        config = {'seed': 73, 'learning_rate': 0.001, 'warmup_steps': 1, 'max_steps': 2,
                  'batch_size': 1, 'gradient_accumulation_steps': 2, 'eval_every': 1, 'save_every': 1}
        spec = {'config': config, 'test': True}
        with tempfile.TemporaryDirectory() as directory:
            full = Path(directory) / 'full'
            interrupted = Path(directory) / 'interrupted'
            full.mkdir()
            interrupted.mkdir()
            torch.manual_seed(17)
            model_full = self.small_model()
            scratch.train(model_full, self.features(), self.features()[:1], self.tokenizer, config, full, spec, 'cpu')
            torch.manual_seed(17)
            first_model = self.small_model()
            original = scratch.save_checkpoint
            def stop_after_first(*args, **kwargs):
                original(*args, **kwargs)
                if args[5] == 1:
                    raise RuntimeError('simulated interruption')
            scratch.save_checkpoint = stop_after_first
            try:
                with self.assertRaisesRegex(RuntimeError, 'simulated interruption'):
                    scratch.train(first_model, self.features(), self.features()[:1], self.tokenizer,
                                  config, interrupted, spec, 'cpu')
            finally:
                scratch.save_checkpoint = original
            resumed = self.small_model()
            metrics = scratch.train(resumed, self.features(), self.features()[:1], self.tokenizer,
                                    config, interrupted, spec, 'cpu')
            self.assertEqual([row['step'] for row in metrics], [0, 1, 2])
            for key, value in model_full.state_dict().items():
                torch.testing.assert_close(value, resumed.state_dict()[key], atol=0, rtol=0)
            with self.assertRaisesRegex(ValueError, 'differ'):
                rng = torch.Generator().manual_seed(1)
                optimizer = scratch.make_optimizer(resumed, config)
                scheduler = scratch.make_scheduler(optimizer, config)
                scaler = torch.amp.GradScaler('cuda', enabled=False)
                scratch.restore_checkpoint(interrupted / 'checkpoint-latest.pt', resumed, optimizer, scheduler,
                                           scaler, rng, {'changed': True}, 'cpu')


if __name__ == '__main__':
    unittest.main()
