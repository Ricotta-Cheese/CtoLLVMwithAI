"""Build the first 200-step private Kaggle training run from the tested runner."""
import ast
import base64
import hashlib
import json
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
DEST = ROOT / 'training/kaggle-pilot-001'
source = ast.parse((ROOT / 'training/build_kaggle_smoke.py').read_text())
body = next(ast.literal_eval(node.value) for node in source.body
            if isinstance(node, ast.Assign) and any(isinstance(target, ast.Name) and target.id == 'body' for target in node.targets))
body = body.replace("WORK / 'scratch-smoke'", "WORK / 'scratch-pilot-001'")
body = body.replace("'gradient_accumulation_steps': 2", "'gradient_accumulation_steps': 8")
body = body.replace("'max_steps': 20", "'max_steps': 200")
body = body.replace("'warmup_steps': 4, 'eval_every': 10, 'save_every': 10", "'warmup_steps': 20, 'eval_every': 25, 'save_every': 50")
start = body.index('    class ControlledPause(Exception):')
end = body.index('    changed = not torch.equal', start)
body = body[:start] + '''    original_evaluate = scratch.evaluate_loss
    validation_call = 0
    best = {'step': None, 'validation_loss': float('inf')}
    def save_best(current_model, *args, **kwargs):
        nonlocal validation_call
        value = original_evaluate(current_model, *args, **kwargs)
        step = validation_call * config['eval_every']
        validation_call += 1
        if value < best['validation_loss']:
            best.update(step=step, validation_loss=value)
            torch.save(current_model.state_dict(), RUN / 'model-best.pt')
            scratch.write_json(RUN / 'best-validation.json', best)
        return value
    scratch.evaluate_loss = save_best
    train_started = time.monotonic()
    try:
        metrics = scratch.train(model, train_features, validation_features, tokenizer, config, RUN, spec, device)
    finally:
        scratch.evaluate_loss = original_evaluate
    training_seconds = time.monotonic() - train_started
''' + body[end:]
body = body.replace("final['step'] != 20", "final['step'] != 200")
body = body.replace("'scope': 'GPU training, checkpoint save and resume smoke test; not compilation accuracy'", "'scope': 'First 200-step scratch training on the 100-pair pilot; not compilation accuracy'")
body = body.replace("'resumed_from_step': 10, 'weights_changed': changed,", "'started_from_random_weights': True, 'weights_changed': changed,\n        'best_validation': best, 'training_seconds': training_seconds,")
point = body.index("    scratch.write_json(RUN / 'summary.json', summary)")
body = body[:point] + '''    # Preview a validation prompt; keep the held-out test set untouched.
    model.load_state_dict(torch.load(RUN / 'model-best.pt', map_location=device, weights_only=True))
    row = splits['validation'][0]
    preview = scratch.generate_ir(model, tokenizer, row['prompt'], device, max_new_tokens=128)
    scratch.write_json(RUN / 'validation-preview.json', {'id': row['id'], 'checkpoint_step': best['step'], **preview})
    import matplotlib
    matplotlib.use('Agg')
    import matplotlib.pyplot as plt
    train_points = [p for p in metrics if 'training_loss' in p]
    valid_points = [p for p in metrics if 'validation_loss' in p]
    fig, ax = plt.subplots(figsize=(9, 4.5))
    ax.plot([p['step'] for p in train_points], [p['training_loss'] for p in train_points], label='Training', alpha=0.75)
    ax.plot([p['step'] for p in valid_points], [p['validation_loss'] for p in valid_points], marker='o', label='Validation')
    ax.set(xlabel='Optimizer step attempt', ylabel='Completion token cross-entropy', title='Scratch C to LLVM IR: 100-pair pilot')
    ax.legend()
    ax.grid(alpha=0.2)
    fig.tight_layout()
    fig.savefig(RUN / 'learning-curve.png', dpi=160)
    plt.close(fig)
''' + body[point:]
body = body.replace('SMOKE_TEST_COMPLETE ', 'FIRST_TRAINING_COMPLETE ')
bundle = (ROOT / 'training/scratch_colab_bundle.zip').read_bytes()
header = f'BUNDLE_BASE64 = {base64.b64encode(bundle).decode()!r}\nBUNDLE_SHA256 = {hashlib.sha256(bundle).hexdigest()!r}\n'
DEST.mkdir(exist_ok=True)
(DEST / 'run.py').write_text(header + body)
metadata = json.loads((ROOT / 'training/kaggle-smoke/kernel-metadata.json').read_text())
owner = metadata['id'].split('/')[0]
metadata.update(id=owner + '/magicompile-scratch-pilot-001', title='MAGICompile scratch pilot 001')
(DEST / 'kernel-metadata.json').write_text(json.dumps(metadata, indent=2) + '\n')
compile(header + body, str(DEST / 'run.py'), 'exec')
assert "'max_steps': 200" in body and 'ControlledPause' not in body
print(metadata['id'])
