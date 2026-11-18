"""Check the selected Qwen3 adapter and run provenance without downloading base weights."""
from pathlib import Path
import argparse
import hashlib
import json
import math
import numpy as np
from safetensors import safe_open

ROOT = Path(__file__).resolve().parents[1]


def verify(result):
    spec = json.loads((result / 'run-spec.json').read_text())
    summary = json.loads((result / 'training-summary.json').read_text())
    lock = json.loads((ROOT / 'training/qwen3-model-lock.json').read_text())
    build = json.loads((ROOT / 'training/kaggle-qwen3-001/build-manifest.json').read_text())
    for key in ('model_id', 'revision'):
        if spec[key] != lock[key] or summary[key] != lock[key]:
            raise ValueError('unexpected base model or revision')
    for key in ('dataset_sha256', 'corpus_manifest_sha256', 'splits_sha256', 'training_source_sha256', 'requirements_sha256'):
        if spec[key] != build[key]:
            raise ValueError(f'provenance mismatch: {key}')
    if hashlib.sha256((result / 'splits.json').read_bytes()).hexdigest() != build['splits_sha256']:
        # Kaggle JSON indentation may differ; compare the actual frozen ID lists instead.
        if json.loads((result / 'splits.json').read_text()) != json.loads((ROOT / 'corpus-1100-v001/splits.json').read_text()):
            raise ValueError('split partition changed')
    if summary['steps'] != 220 or summary['test_set_evaluated'] or spec['truncation']:
        raise ValueError('training incomplete, test leakage or truncation')
    if not all(math.isfinite(summary[k]) for k in ('initial_validation_loss', 'best_validation_loss')):
        raise ValueError('nonfinite validation loss')
    config = json.loads((result / 'adapter-best/adapter_config.json').read_text())
    if config['base_model_name_or_path'] != lock['model_id'] or config['r'] != 8 or config['lora_alpha'] != 16:
        raise ValueError('unexpected adapter configuration')
    weights = result / 'adapter-best/adapter_model.safetensors'
    count = tensors = nonzero_b = 0
    with safe_open(weights, framework='np') as handle:
        for key in handle.keys():
            array = handle.get_tensor(key)
            if not np.isfinite(array).all(): raise ValueError('nonfinite adapter weights')
            count += array.size; tensors += 1
            if 'lora_B' in key and np.any(array != 0): nonzero_b += 1
    if count != summary['trainable_parameters'] or nonzero_b == 0:
        raise ValueError('adapter count mismatch or no learned updates')
    report = {'status': 'passed', 'model_id': lock['model_id'], 'revision': lock['revision'], 'steps': summary['steps'], 'parameters': count, 'tensors': tensors, 'nonzero_lora_B_tensors': nonzero_b, 'adapter_sha256': hashlib.sha256(weights.read_bytes()).hexdigest(), 'initial_validation_loss': summary['initial_validation_loss'], 'best_validation_loss': summary['best_validation_loss'], 'test_set_evaluated': False, 'native_accuracy': 'separate LLVM and execution evaluation required'}
    (result / 'local-adapter-verification.json').write_text(json.dumps(report, indent=2)+'\n')
    return report


if __name__ == '__main__':
    parser = argparse.ArgumentParser()
    parser.add_argument('result', type=Path)
    print(json.dumps(verify(parser.parse_args().result), indent=2))
