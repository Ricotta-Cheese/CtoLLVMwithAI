"""Verify the first training's downloaded best model, checkpoint and metrics."""
from pathlib import Path
import hashlib
import json
import math
import sys

import torch
from scratch import ScratchCausalLM


def main():
    root = Path(sys.argv[1])
    read = lambda name: json.loads((root / name).read_text())
    report, spec, metrics = read('summary.json'), read('run-spec.json'), read('metrics.json')
    config = spec['config']
    assert report['status'] == 'passed' and config['max_steps'] == 200
    assert report['optimizer_step_attempts'] == 200 and report['actual_optimizer_steps'] > 0
    assert report['started_from_random_weights'] is True and report['test_set_evaluated'] is False
    assert [m['step'] for m in metrics] == list(range(201))
    assert all(math.isfinite(m[key]) for m in metrics for key in ('training_loss', 'validation_loss') if key in m)
    validation = [m for m in metrics if 'validation_loss' in m]
    best = min(validation, key=lambda m: m['validation_loss'])
    assert best['step'] == report['best_validation']['step']
    assert best['validation_loss'] == report['best_validation']['validation_loss']
    weights = torch.load(root / 'model-best.pt', map_location='cpu', weights_only=True)
    model = ScratchCausalLM(report['vocabulary_size'], context_length=config['context_length'],
                            d_model=config['d_model'], n_heads=config['n_heads'], n_layers=config['n_layers'], dropout=config['dropout'])
    model.load_state_dict(weights, strict=True)
    assert sum(p.numel() for p in model.parameters()) == report['parameter_count']
    assert all(torch.isfinite(value).all() for value in weights.values())
    checkpoint = torch.load(root / 'checkpoint-latest.pt', map_location='cpu', weights_only=True)
    assert checkpoint['step'] == 200 and checkpoint['run_spec'] == spec
    assert checkpoint['metrics'] == metrics
    assert all(torch.isfinite(value).all() for value in checkpoint['model'].values())
    optimizer_step = max(float(value['step']) for value in checkpoint['optimizer']['state'].values())
    assert optimizer_step == report['actual_optimizer_steps']
    matches_final = all(torch.equal(value, checkpoint['model'][key]) for key, value in weights.items())
    if best['step'] == 200:
        assert matches_final
    files = {path.name: {'bytes': path.stat().st_size, 'sha256': hashlib.sha256(path.read_bytes()).hexdigest()}
             for path in sorted(root.iterdir()) if path.is_file()}
    result = {'status': 'passed', 'parameter_count': report['parameter_count'], 'step': 200,
              'actual_optimizer_steps': optimizer_step, 'best_step': best['step'], 'best_model_strict_load': True,
              'all_weights_finite': True, 'best_matches_final': matches_final, 'metrics_match_checkpoint': True, 'files': files}
    (root.parent / 'download-verification.json').write_text(json.dumps(result, indent=2, sort_keys=True) + '\n')
    print(json.dumps({key: value for key, value in result.items() if key != 'files'}, indent=2))


if __name__ == '__main__':
    torch.set_num_threads(2)
    main()
