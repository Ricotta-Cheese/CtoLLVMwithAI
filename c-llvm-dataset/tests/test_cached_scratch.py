import importlib.util
from pathlib import Path
import sys
import unittest

if importlib.util.find_spec('torch') is None:
    raise unittest.SkipTest('PyTorch required')
import torch
sys.path.insert(0,str(Path(__file__).resolve().parents[1]/'training'))
from scratch import ScratchCausalLM, make_batch
from scratch_cached_generation import CachedScratch


class CachedInferenceTests(unittest.TestCase):
    def test_incremental_logits_match_full_causal_forward(self):
        torch.set_num_threads(1)
        torch.manual_seed(23)
        model=ScratchCausalLM(64,context_length=16,d_model=32,n_heads=4,n_layers=2).eval()
        ids=torch.tensor([[4,6,7,8,9,10]])
        cached=CachedScratch(model)
        with torch.no_grad():
            full=model(ids,torch.ones_like(ids,dtype=torch.bool))
            torch.testing.assert_close(cached.forward(ids[:,:3]),full[:,:3],atol=2e-6,rtol=2e-5)
            for index in range(3,6):
                torch.testing.assert_close(cached.forward(ids[:,index:index+1])[:,0],full[:,index],atol=2e-6,rtol=2e-5)

    def test_eos_remains_supervised_when_pad_id_equals_eos_id(self):
        features=[{'input_ids':[2,3,1],'labels':[-100,3,1]}, {'input_ids':[2,1],'labels':[-100,1]}]
        batch=make_batch(features,pad_id=1,device='cpu')
        self.assertEqual(int(batch['labels'][0,2]),1)
        self.assertEqual(int(batch['labels'][1,1]),1)
        self.assertEqual(int(batch['labels'][1,2]),-100)
        self.assertFalse(bool(batch['attention_mask'][1,2]))


if __name__=='__main__':
    unittest.main()
