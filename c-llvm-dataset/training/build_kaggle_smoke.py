"""Build a private Kaggle GPU smoke run with a self-contained pilot bundle."""
from pathlib import Path
import base64
import json
import hashlib

ROOT = Path(__file__).resolve().parents[1]
DEST = ROOT / 'training/kaggle-smoke'
bundle = (ROOT / 'training/scratch_colab_bundle.zip').read_bytes()
payload = base64.b64encode(bundle).decode('ascii')
header = f'''BUNDLE_BASE64 = {payload!r}\nBUNDLE_SHA256 = {hashlib.sha256(bundle).hexdigest()!r}\n'''
body = '''
import hashlib
import importlib.metadata
import io
import json
from pathlib import Path
import subprocess
import sys
import time
import zipfile

WORK = Path('/kaggle/working')
RUN = WORK / 'scratch-smoke'
RUN.mkdir(parents=True, exist_ok=True)
started = time.monotonic()


def main():
    try:
        installed = importlib.metadata.version('tokenizers')
    except importlib.metadata.PackageNotFoundError:
        installed = None
    if installed != '0.22.2':
        subprocess.check_call([sys.executable, '-m', 'pip', 'install', 'tokenizers==0.22.2'])
    import base64
    blob = base64.b64decode(BUNDLE_BASE64)
    if hashlib.sha256(blob).hexdigest() != BUNDLE_SHA256:
        raise ValueError('embedded bundle digest mismatch')
    SOURCE = WORK / 'source'
    SOURCE.mkdir(exist_ok=True)
    names = {'scratch.py', 'dataset.jsonl', 'dataset_metadata.json', 'requirements.txt'}
    with zipfile.ZipFile(io.BytesIO(blob)) as archive:
        if set(archive.namelist()) != names:
            raise ValueError('unexpected bundle contents')
        for name in sorted(names):
            (SOURCE / name).write_bytes(archive.read(name))
    sys.path.insert(0, str(SOURCE))
    import torch
    import tokenizers
    import scratch
    if not torch.cuda.is_available():
        raise RuntimeError('Kaggle did not allocate a CUDA GPU')
    device = 'cuda:0'
    torch.set_num_threads(4)
    torch.manual_seed(20261113)
    torch.cuda.manual_seed_all(20261113)
    environment = {
        'torch_version': str(torch.__version__), 'cuda_version': torch.version.cuda,
        'tokenizers_version': tokenizers.__version__, 'gpu_count': torch.cuda.device_count(),
        'gpu_name': torch.cuda.get_device_name(0),
        'gpu_memory_gib': torch.cuda.get_device_properties(0).total_memory / 2**30,
        'used_device': device, 'pretrained_weights_used': False,
    }
    scratch.write_json(RUN / 'environment.json', environment)
    print(json.dumps(environment), flush=True)
    metadata = json.loads((SOURCE / 'dataset_metadata.json').read_text())
    rows = scratch.load_rows(SOURCE / 'dataset.jsonl', metadata['dataset_sha256'])
    splits = scratch.split_rows(rows, 20261113)
    tokenizer = scratch.train_tokenizer(splits['train'], 2048)
    tokenizer.save(str(RUN / 'tokenizer.json'))
    config = {'seed': 20261113, 'vocab_size': 2048, 'context_length': 3072,
              'd_model': 512, 'n_heads': 8, 'n_layers': 8, 'dropout': 0.1,
              'batch_size': 1, 'gradient_accumulation_steps': 2,
              'learning_rate': 3e-4, 'precision': 'fp16', 'max_steps': 20,
              'warmup_steps': 4, 'eval_every': 10, 'save_every': 10}
    train_features = scratch.encode_rows(splits['train'], tokenizer, config['context_length'])
    validation_features = scratch.encode_rows(splits['validation'], tokenizer, config['context_length'])
    split_ids = {key: [row['id'] for row in value] for key, value in splits.items()}
    spec = {'config': config, 'dataset_sha256': metadata['dataset_sha256'],
            'training_code_sha256': metadata['training_code_sha256'],
            'tokenizer_sha256': hashlib.sha256((RUN / 'tokenizer.json').read_bytes()).hexdigest(),
            'splits': split_ids, 'torch_version': str(torch.__version__)}
    scratch.write_json(RUN / 'run-spec.json', spec)
    scratch.write_json(RUN / 'splits.json', split_ids)

    def new_model():
        return scratch.ScratchCausalLM(vocab_size=tokenizer.get_vocab_size(), context_length=3072,
                                       d_model=512, n_heads=8, n_layers=8, dropout=0.1).to(device)
    model = new_model()
    initial_embedding = model.token_embedding.weight.detach().cpu().clone()
    parameter_count = sum(parameter.numel() for parameter in model.parameters())
    print(f'Random model parameters: {parameter_count}', flush=True)

    class ControlledPause(Exception):
        pass
    original_save = scratch.save_checkpoint
    def pause_at_ten(*args, **kwargs):
        original_save(*args, **kwargs)
        if args[5] == 10:
            raise ControlledPause()
    scratch.save_checkpoint = pause_at_ten
    try:
        scratch.train(model, train_features, validation_features, tokenizer, config, RUN, spec, device)
    except ControlledPause:
        print('Checkpoint 10 saved. Recreating the model and resuming.', flush=True)
    finally:
        scratch.save_checkpoint = original_save
    del model
    torch.cuda.empty_cache()
    model = new_model()
    metrics = scratch.train(model, train_features, validation_features, tokenizer, config, RUN, spec, device)
    changed = not torch.equal(initial_embedding, model.token_embedding.weight.detach().cpu())
    if not changed:
        raise RuntimeError('model weights did not change')
    final = torch.load(RUN / 'checkpoint-latest.pt', map_location='cpu', weights_only=True)
    optimizer_steps = max(float(value['step']) for value in final['optimizer']['state'].values())
    if final['step'] != 20 or optimizer_steps <= 0:
        raise RuntimeError('training did not perform optimizer updates')
    summary = {
        'status': 'passed', 'scope': 'GPU training, checkpoint save and resume smoke test; not compilation accuracy',
        'environment': environment, 'parameter_count': parameter_count,
        'vocabulary_size': tokenizer.get_vocab_size(),
        'split_sizes': {key: len(value) for key, value in splits.items()},
        'optimizer_step_attempts': final['step'], 'actual_optimizer_steps': optimizer_steps,
        'resumed_from_step': 10, 'weights_changed': changed,
        'initial_validation_loss': metrics[0]['validation_loss'],
        'final_validation_loss': metrics[-1]['validation_loss'],
        'peak_gpu_memory_gib': torch.cuda.max_memory_allocated(0) / 2**30,
        'elapsed_seconds': time.monotonic() - started,
        'test_set_evaluated': False,
    }
    scratch.write_json(RUN / 'summary.json', summary)
    print('SMOKE_TEST_COMPLETE ' + json.dumps(summary), flush=True)

try:
    main()
except BaseException as error:
    import traceback
    (RUN / 'failure.txt').write_text(traceback.format_exc())
    (RUN / 'failure.json').write_text(json.dumps({'status': 'failed', 'type': type(error).__name__, 'message': str(error)}))
    raise
'''
DEST.mkdir(exist_ok=True)
(DEST / 'run.py').write_text(header + body)
metadata_path = DEST / 'kernel-metadata.json'
metadata = json.loads(metadata_path.read_text())
owner = metadata['id'].split('/')[0]
metadata.update({'id': owner + '/magicompile-scratch-smoke-20261113',
                 'title': 'MAGICompile scratch smoke 20261113', 'code_file': 'run.py',
                 'language': 'python', 'kernel_type': 'script', 'is_private': 'true',
                 'enable_gpu': 'true', 'enable_tpu': 'false', 'enable_internet': 'true',
                 'machine_shape': 'NvidiaTeslaT4'})
metadata_path.write_text(json.dumps(metadata, indent=2) + '\n')
compile((DEST / 'run.py').read_text(), str(DEST / 'run.py'), 'exec')
print(metadata['id'])
