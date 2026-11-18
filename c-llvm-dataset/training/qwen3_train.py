"""Frozen 1100-pair corpus: Qwen3 instruct NF4 QLoRA, no test-set use."""
from pathlib import Path
import hashlib
import json
import os
import time

os.environ['CUDA_VISIBLE_DEVICES'] = '0'
os.environ['HF_HOME'] = '/kaggle/temp/qwen3-hf-cache'
os.environ['HF_HUB_DISABLE_XET'] = '1'
os.environ['TOKENIZERS_PARALLELISM'] = 'false'
os.environ['WANDB_DISABLED'] = 'true'

import torch
from peft import LoraConfig, get_peft_model, prepare_model_for_kbit_training
from transformers import AutoTokenizer, AutoModelForCausalLM, BitsAndBytesConfig, GenerationConfig, Trainer, TrainingArguments, TrainerCallback, set_seed

SOURCE = Path(__file__).parent
RUN = Path('/kaggle/working/qwen3-4b-corpus1100-001')
RUN.mkdir(parents=True, exist_ok=True)
SEED = 20261113
SYSTEM = 'Translate the provided C function to a complete LLVM IR module for the specified target. Return only LLVM IR, without Markdown fences or explanations.'


def save(name, value):
    (RUN / name).write_text(json.dumps(value, indent=2) + '\n')


def prefix_ids(tokenizer, row):
    return tokenizer.apply_chat_template([{'role': 'system', 'content': SYSTEM}, {'role': 'user', 'content': row['prompt']}], tokenize=True, add_generation_prompt=True)


def encode(tokenizer, row):
    prefix = prefix_ids(tokenizer, row)
    target = tokenizer.encode(row['completion'], add_special_tokens=False) + [tokenizer.eos_token_id]
    return {'input_ids': prefix + target, 'labels': [-100] * len(prefix) + target}


def collate(features):
    n = max(len(f['input_ids']) for f in features)
    ids = torch.full((len(features), n), TOKENIZER.pad_token_id, dtype=torch.long)
    labels = torch.full_like(ids, -100)
    mask = torch.zeros_like(ids)
    for i, f in enumerate(features):
        length = len(f['input_ids'])
        ids[i, :length] = torch.tensor(f['input_ids'])
        labels[i, :length] = torch.tensor(f['labels'])
        mask[i, :length] = 1
    return {'input_ids': ids, 'attention_mask': mask, 'labels': labels}


class Progress(TrainerCallback):
    def on_log(self, args, state, control, logs=None, **kwargs):
        save('metrics.json', state.log_history)
        print(json.dumps({'phase': 'training', 'step': state.global_step, **(logs or {})}), flush=True)


def predict(model, rows, label):
    model.eval()
    model.gradient_checkpointing_disable()
    model.config.use_cache = True
    completed = 0
    with (RUN / f'{label}-predictions.jsonl').open('w') as stream:
        for row in rows:
            prefix = prefix_ids(TOKENIZER, row)
            ids = torch.tensor([prefix], device='cuda:0')
            started = time.monotonic()
            with torch.inference_mode():
                output = model.generate(input_ids=ids, attention_mask=torch.ones_like(ids), generation_config=GenerationConfig(do_sample=False, num_beams=1, max_new_tokens=3072, max_time=300, use_cache=True, eos_token_id=TOKENIZER.eos_token_id, pad_token_id=TOKENIZER.pad_token_id))
            tokens = output[0, len(prefix):].tolist()
            ended = bool(tokens and tokens[-1] == TOKENIZER.eos_token_id)
            completed += ended
            record = {'id': row['id'], 'category': row['category'], 'model': label, 'prompt_sha256': hashlib.sha256(row['prompt'].encode()).hexdigest(), 'generated_ir': TOKENIZER.decode(tokens[:-1] if ended else tokens, skip_special_tokens=False), 'generated_tokens': len(tokens), 'ended_with_eos': ended, 'limit_reached': not ended, 'generation_seconds': time.monotonic() - started, 'generation_budget': 3072}
            stream.write(json.dumps(record) + '\n'); stream.flush()
            print(json.dumps({'phase': label, 'id': row['id'], 'tokens': len(tokens), 'eos': ended, 'seconds': record['generation_seconds']}), flush=True)
    model.config.use_cache = False
    torch.cuda.empty_cache()
    return completed


def main():
    global TOKENIZER
    set_seed(SEED)
    torch.set_num_threads(4)
    assert torch.cuda.is_available() and torch.cuda.device_count() == 1
    lock = json.loads((SOURCE / 'qwen3-model-lock.json').read_text())
    expected = json.loads((SOURCE / 'corpus-metadata.json').read_text())
    raw = (SOURCE / 'dataset.jsonl').read_bytes()
    assert hashlib.sha256(raw).hexdigest() == expected['dataset_sha256']
    rows = [json.loads(line) for line in raw.splitlines()]
    splits = json.loads((SOURCE / 'splits.json').read_text())
    assert len(rows) == 1100 and {k: len(v) for k, v in splits.items()} == {'train': 880, 'validation': 110, 'test': 110}
    listed = [i for ids in splits.values() for i in ids]
    assert len(listed) == len(set(listed)) == len(rows) and set(listed) == {r['id'] for r in rows}
    lookup = {r['id']: r for r in rows}
    for key in ('structure_id', 'source_sha256', 'ir_sha256'):
        owner = {}
        for partition, ids in splits.items():
            for ident in ids:
                assert owner.setdefault(lookup[ident][key], partition) == partition
    train_rows = [lookup[i] for i in splits['train']]
    val_rows = [lookup[i] for i in splits['validation']]
    TOKENIZER = AutoTokenizer.from_pretrained(lock['model_id'], revision=lock['revision'], token=False, trust_remote_code=False)
    TOKENIZER.pad_token = TOKENIZER.eos_token
    TOKENIZER.padding_side = 'right'
    train = [encode(TOKENIZER, r) for r in train_rows]
    val = [encode(TOKENIZER, r) for r in val_rows]
    maximum = max(len(x['input_ids']) for x in train + val)
    if maximum > 4096:
        raise ValueError(f'no truncation allowed: {maximum} tokens exceeds 4096')
    # Original ten validation functions preserve comparability; two new examples per category broaden the probe.
    probe = [r for r in val_rows if r['source_dataset'] == 'base']
    for category in sorted({r['category'] for r in val_rows}):
        probe.extend([r for r in val_rows if r['source_dataset'] == 'extension' and r['category'] == category][:2])
    save('splits.json', splits)
    save('probe-splits.json', {'validation': [r['id'] for r in probe]})
    spec = {**lock, **expected, 'system_prompt': SYSTEM, 'seed': SEED, 'epochs': 1, 'max_steps': 220, 'micro_batch': 1, 'gradient_accumulation': 4, 'learning_rate': 1e-4, 'lora_rank': 8, 'lora_alpha': 16, 'lora_dropout': 0.05, 'quantization': 'NF4 double quantization FP16 compute', 'max_tokens': maximum, 'truncation': False, 'split_counts': {k: len(v) for k, v in splits.items()}, 'probe_ids': [r['id'] for r in probe], 'test_set_evaluated': False, 'prompt_format': 'official chat template, system+user; assistant LLVM IR plus EOS; labels only assistant', 'gpu': torch.cuda.get_device_name(0), 'torch': torch.__version__, 'generation': 'raw greedy single candidate; 3072 tokens; 300 seconds maximum per function'}
    save('run-spec.json', spec)
    print(json.dumps({'phase': 'load_model', 'max_tokens': maximum, 'train': len(train), 'validation': len(val)}), flush=True)
    model = AutoModelForCausalLM.from_pretrained(lock['model_id'], revision=lock['revision'], token=False, trust_remote_code=False, quantization_config=BitsAndBytesConfig(load_in_4bit=True, bnb_4bit_quant_type='nf4', bnb_4bit_use_double_quant=True, bnb_4bit_compute_dtype=torch.float16), torch_dtype=torch.float16, device_map={'': 0}, attn_implementation='sdpa')
    model.config.use_cache = False
    model = prepare_model_for_kbit_training(model, use_gradient_checkpointing=True, gradient_checkpointing_kwargs={'use_reentrant': False})
    model = get_peft_model(model, LoraConfig(r=8, lora_alpha=16, lora_dropout=0.05, target_modules='all-linear', bias='none', task_type='CAUSAL_LM'))
    trainable = sum(p.numel() for p in model.parameters() if p.requires_grad)
    # Stress the longest supervised example before starting the complete run. Do not mutate weights.
    torch.cuda.reset_peak_memory_stats()
    started = time.monotonic()
    longest = max(train + val, key=lambda f: len(f['input_ids']))
    model.train()
    batch = {k: v.to('cuda:0') for k, v in collate([longest]).items()}
    loss = model(**batch).loss
    if not torch.isfinite(loss): raise ValueError('nonfinite memory-smoke loss')
    loss.backward()
    model.zero_grad(set_to_none=True)
    smoke = {'status': 'passed', 'tokens': maximum, 'loss': loss.item(), 'seconds': time.monotonic() - started, 'peak_allocated_gib': torch.cuda.max_memory_allocated()/2**30, 'gpu_total_gib': torch.cuda.get_device_properties(0).total_memory/2**30, 'weights_updated': False}
    save('memory-smoke.json', smoke)
    print(json.dumps({'phase': 'memory_smoke', **smoke}), flush=True)
    del loss, batch
    torch.cuda.empty_cache()
    args = TrainingArguments(output_dir=str(RUN / 'checkpoints'), max_steps=220, per_device_train_batch_size=1, per_device_eval_batch_size=1, gradient_accumulation_steps=4, learning_rate=1e-4, warmup_steps=11, lr_scheduler_type='cosine', fp16=True, bf16=False, gradient_checkpointing=True, gradient_checkpointing_kwargs={'use_reentrant': False}, eval_strategy='steps', eval_steps=55, save_strategy='steps', save_steps=55, save_total_limit=2, load_best_model_at_end=True, metric_for_best_model='eval_loss', greater_is_better=False, logging_steps=5, optim='adamw_torch', report_to='none', seed=SEED, data_seed=SEED, remove_unused_columns=False, label_names=['labels'], dataloader_num_workers=0)
    trainer = Trainer(model=model, args=args, train_dataset=train, eval_dataset=val, data_collator=collate, processing_class=TOKENIZER, callbacks=[Progress()])
    assert trainer.args.n_gpu == 1
    initial = trainer.evaluate()['eval_loss']
    save('initial-validation.json', {'eval_loss': initial})
    started = time.monotonic()
    result = trainer.train()
    seconds = time.monotonic() - started
    trainer.save_model(str(RUN / 'adapter-best'))
    TOKENIZER.save_pretrained(RUN / 'adapter-best')
    save('metrics.json', trainer.state.log_history)
    save('training-summary.json', {'status': 'training_complete', **lock, 'steps': trainer.state.global_step, 'training_seconds': seconds, 'trainable_parameters': trainable, 'initial_validation_loss': initial, 'best_validation_loss': trainer.state.best_metric, 'best_checkpoint': trainer.state.best_model_checkpoint, 'peak_gpu_allocated_gib': torch.cuda.max_memory_allocated()/2**30, 'train_metrics': result.metrics, 'test_set_evaluated': False})
    # Remove optimizer checkpoints after exporting the selected adapter; only useful inference weights persist.
    import shutil
    shutil.rmtree(RUN / 'checkpoints')
    complete = predict(model, probe, 'qwen3-4b-qlora')
    save('summary.json', {'status': 'passed', 'training_steps': trainer.state.global_step, 'probe_count': len(probe), 'complete_outputs': complete, 'test_set_evaluated': False, 'native_accuracy': 'pending local LLVM and stored-input evaluation'})
    print('QWEN3_TRAINING_COMPLETE', flush=True)


if __name__ == '__main__':
    try: main()
    except BaseException:
        import traceback
        (RUN / 'failure.txt').write_text(traceback.format_exc())
        raise
