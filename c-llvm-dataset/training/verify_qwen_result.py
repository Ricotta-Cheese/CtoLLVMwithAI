"""Inspect downloaded QLoRA adapter and frozen validation prediction provenance."""
from pathlib import Path
import hashlib
import json
import math
import sys
import torch
from safetensors.torch import load_file


def main():
    root = Path(sys.argv[1])
    read = lambda name: json.loads((root / name).read_text())
    report, spec = read('summary.json'), read('run-spec.json')
    assert report['status'] == 'passed' and report['training_steps'] == 60
    assert not report['test_set_evaluated'] and not spec['test_set_evaluated']
    assert spec['model_id'] == report['model_id'] == 'Qwen/Qwen2.5-Coder-1.5B'
    assert spec['revision'] == report['revision']
    assert math.isfinite(report['best_validation_loss'])
    settings = read('trainer-effective-settings.json')
    assert settings['visible_gpus'] == settings['trainer_n_gpu'] == settings['train_batch_size'] == 1
    assert settings['gradient_accumulation_steps'] == 4
    config = read('adapter-best/adapter_config.json')
    assert config['r'] == 8 and config['lora_alpha'] == 16
    weights = load_file(root / 'adapter-best/adapter_model.safetensors')
    assert sum(value.numel() for value in weights.values()) == report['trainable_parameters']
    assert all(torch.isfinite(value).all() for value in weights.values())
    assert any(bool(torch.any(value != 0)) for key,value in weights.items() if 'lora_B' in key)
    expected = set(spec['splits']['validation'])
    for name in ('scratch-pilot','qwen-base-4bit','qwen-qlora'):
        rows=[json.loads(line) for line in (root / f'{name}-predictions.jsonl').read_text().splitlines()]
        assert len(rows)==10 and {row['id'] for row in rows}==expected
        assert not ({row['id'] for row in rows} & set(spec['splits']['test']))
    files={str(path.relative_to(root)): {'bytes':path.stat().st_size,
              'sha256':hashlib.file_digest(path.open('rb'),'sha256').hexdigest()}
           for path in sorted(root.rglob('*')) if path.is_file()}
    result={'status':'passed','finite_adapter_weights':True,'adapter_parameter_count':report['trainable_parameters'],
            'lora_B_updated':True,'single_gpu_training_verified':True,'test_set_evaluated':False,'files':files}
    (root.parent / 'download-verification.json').write_text(json.dumps(result,indent=2,sort_keys=True)+'\n')
    print(json.dumps({key:value for key,value in result.items() if key!='files'},indent=2))


if __name__=='__main__':
    torch.set_num_threads(2)
    main()
