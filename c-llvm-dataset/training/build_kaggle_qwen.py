"""Build a self-contained private Kaggle Qwen trial with an isolated Python environment."""
from pathlib import Path
import base64
import hashlib
import io
import json
import zipfile

ROOT = Path(__file__).resolve().parents[1]
DEST = ROOT / 'training/kaggle-qwen-001'
with zipfile.ZipFile(ROOT / 'training/scratch_colab_bundle.zip') as archive:
    files = {name: archive.read(name) for name in archive.namelist()}
files.update({
    'qwen_train.py': (ROOT / 'training/qwen_train.py').read_bytes(),
    'scratch_cached_generation.py': (ROOT / 'training/scratch_cached_generation.py').read_bytes(),
    'qwen_requirements.txt': (ROOT / 'training/qwen_requirements.txt').read_bytes(),
    'frozen-splits.json': (ROOT / 'training/kaggle-results/pilot-001/scratch-pilot-001/splits.json').read_bytes(),
})
cached_root = ROOT / 'training/kaggle-results/qwen-attempt2/qwen-pilot-001'
if (cached_root / 'qwen-base-4bit-predictions.jsonl').exists():
    files['qwen-base-4bit-cached.jsonl'] = (cached_root / 'qwen-base-4bit-predictions.jsonl').read_bytes()
    files['cached-baseline-spec.json'] = (cached_root / 'run-spec.json').read_bytes()

old_model = ROOT / 'training/kaggle-results/pilot-001/scratch-pilot-001/model-best.pt'
with old_model.open('rb') as stream:
    model_sha = hashlib.file_digest(stream, 'sha256').hexdigest()
files['comparison-metadata.json'] = (json.dumps({'scratch_model_sha256': model_sha,
    'scratch_step': 175, 'scratch_kernel': 'ritaainsworth/magicompile-scratch-pilot-001',
    'scope': 'validation-only exploratory comparison; test set untouched'}) + '\n').encode()
blob = io.BytesIO()
with zipfile.ZipFile(blob, 'w', compression=zipfile.ZIP_DEFLATED) as archive:
    for name, value in sorted(files.items()):
        archive.writestr(name, value)
header = f'PAYLOAD = {base64.b64encode(blob.getvalue()).decode()!r}\nPAYLOAD_SHA = {hashlib.sha256(blob.getvalue()).hexdigest()!r}\n'
bootstrap = '''
import base64
import hashlib
import io
import json
from pathlib import Path
import subprocess
import sys
import traceback
import venv
import zipfile

root = Path('/kaggle/working/qwen-pilot-001')
root.mkdir(parents=True, exist_ok=True)
try:
    blob = base64.b64decode(PAYLOAD)
    assert hashlib.sha256(blob).hexdigest() == PAYLOAD_SHA
    source = Path('/kaggle/temp/qwen-source')
    source.mkdir(parents=True, exist_ok=True)
    with zipfile.ZipFile(io.BytesIO(blob)) as archive:
        for name in archive.namelist():
            if Path(name).name != name:
                raise ValueError('invalid bundle path')
            (source / name).write_bytes(archive.read(name))
    environment = Path('/kaggle/temp/qwen-venv')
    venv.EnvBuilder(system_site_packages=True, with_pip=False).create(environment)
    python = environment / 'bin/python'
    subprocess.check_call([sys.executable, '-m', 'pip', '--python', str(python), 'install', '--no-cache-dir', '-r', str(source / 'qwen_requirements.txt')])
    subprocess.check_call([str(python), str(source / 'qwen_train.py')])
except BaseException as error:
    (root / 'bootstrap-failure.txt').write_text(traceback.format_exc())
    raise
'''
DEST.mkdir(exist_ok=True)
(DEST / 'run.py').write_text(header + bootstrap)
metadata = json.loads((ROOT / 'training/kaggle-pilot-001/kernel-metadata.json').read_text())
metadata.update(id='ritaainsworth/magicompile-qwen-pilot-001', title='MAGICompile Qwen pilot 001',
                kernel_sources=['ritaainsworth/magicompile-scratch-pilot-001'])
(DEST / 'kernel-metadata.json').write_text(json.dumps(metadata, indent=2) + '\n')
for name in ('qwen_train.py','scratch_cached_generation.py'):
    compile(files[name].decode(), name, 'exec')
compile(header + bootstrap, 'kaggle-qwen-run.py', 'exec')
(ROOT / 'training/qwen-comparison-plan.json').write_text(json.dumps({
    'validation_ids': json.loads(files['frozen-splits.json'])['validation'],
    'comparison': ['scratch-pilot-step175','qwen-base-nf4','qwen-qlora-best-of-20-40-60'],
    'test_set_evaluated': False, 'context_length': 3072, 'max_generated_tokens': 2560,
    'max_seconds_per_function': {'scratch': 120, 'qwen': 300}, 'samples_per_function': 1, 'decoding': 'greedy',
    'raw_output_no_repairs': True, 'qwen_steps': 60, 'qwen_effective_batch': 4,
    'scratch_model_sha256': model_sha,
    'decision': 'provisional validation comparison only; confirm later with expanded data and frozen test',
}, indent=2) + '\n')
print(metadata['id'])
