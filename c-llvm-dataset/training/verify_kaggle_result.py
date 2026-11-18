"""Verify downloaded smoke-run weights and checkpoint against the run report."""
import hashlib
import json
from pathlib import Path
import sys

import torch

sys.path.insert(0, str(Path(__file__).resolve().parent))
from scratch import ScratchCausalLM


def main():
    root = Path(sys.argv[1])
    report = json.loads((root / 'summary.json').read_text())
    spec = json.loads((root / 'run-spec.json').read_text())
    assert report['status'] == 'passed' and report['actual_optimizer_steps'] == 20
    assert report['resumed_from_step'] == 10 and report['weights_changed']
    assert report['test_set_evaluated'] is False
    assert report['environment']['pretrained_weights_used'] is False
    config = spec['config']
    model = ScratchCausalLM(report['vocabulary_size'], context_length=config['context_length'],
                            d_model=config['d_model'], n_heads=config['n_heads'],
                            n_layers=config['n_layers'], dropout=config['dropout'])
    weights = torch.load(root / 'model.pt', map_location='cpu', weights_only=True)
    model.load_state_dict(weights, strict=True)
    assert sum(p.numel() for p in model.parameters()) == report['parameter_count']
    assert all(torch.isfinite(value).all() for value in weights.values())
    checkpoint = torch.load(root / 'checkpoint-latest.pt', map_location='cpu', weights_only=True)
    assert checkpoint['step'] == 20 and checkpoint['run_spec'] == spec
    assert set(weights) == set(checkpoint['model'])
    assert all(torch.equal(value, checkpoint['model'][name]) for name, value in weights.items())
    assert max(float(value['step']) for value in checkpoint['optimizer']['state'].values()) == 20
    files = {path.name: {'bytes': path.stat().st_size, 'sha256': hashlib.sha256(path.read_bytes()).hexdigest()}
             for path in sorted(root.iterdir()) if path.is_file()}
    verification = {'status': 'passed', 'strict_weight_load': True, 'all_weights_finite': True,
                    'model_matches_checkpoint': True, 'optimizer_step': 20,
                    'parameter_count': report['parameter_count'], 'files': files}
    (root.parent / 'download-verification.json').write_text(json.dumps(verification, indent=2, sort_keys=True) + '\n')
    print(json.dumps({key: value for key, value in verification.items() if key != 'files'}, indent=2))


if __name__ == '__main__':
    torch.set_num_threads(2)
    main()
