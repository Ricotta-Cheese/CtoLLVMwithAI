"""Build a private Kaggle job, pinning corpus, model, dependencies and source hashes."""
from pathlib import Path
import base64
import hashlib
import io
import json
import zipfile
import sys
ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(ROOT / 'src'))
from c_llvm_dataset.corpus import verify_corpus
CORPUS = ROOT / 'corpus-1100-v001'
print(verify_corpus(CORPUS))
DEST = ROOT / 'training/kaggle-qwen3-001'
DEST.mkdir(exist_ok=True)
files = {name: (CORPUS / name).read_bytes() for name in ('dataset.jsonl', 'splits.json')}
for name in ('qwen3_train.py', 'qwen_requirements.txt', 'qwen3-model-lock.json'):
    files[name] = (ROOT / 'training' / name).read_bytes()
meta = {'dataset_sha256': hashlib.sha256(files['dataset.jsonl']).hexdigest(), 'corpus_manifest_sha256': hashlib.sha256((CORPUS / 'manifest.json').read_bytes()).hexdigest(), 'splits_sha256': hashlib.sha256(files['splits.json']).hexdigest(), 'training_source_sha256': hashlib.sha256(files['qwen3_train.py']).hexdigest(), 'requirements_sha256': hashlib.sha256(files['qwen_requirements.txt']).hexdigest()}
files['corpus-metadata.json'] = json.dumps(meta).encode()
blob = io.BytesIO()
with zipfile.ZipFile(blob, 'w', compression=zipfile.ZIP_DEFLATED) as archive:
    for name, value in sorted(files.items()):
        info = zipfile.ZipInfo(name, date_time=(2026, 11, 13, 0, 0, 0))
        info.compress_type = zipfile.ZIP_DEFLATED
        archive.writestr(info, value)
payload = blob.getvalue()
header = f'PAYLOAD = {base64.b64encode(payload).decode()!r}\nPAYLOAD_SHA = {hashlib.sha256(payload).hexdigest()!r}\n'
bootstrap = '''
from pathlib import Path
import base64, hashlib, io, subprocess, sys, traceback, venv, zipfile
out = Path('/kaggle/working/qwen3-4b-corpus1100-001')
out.mkdir(parents=True, exist_ok=True)
try:
    blob = base64.b64decode(PAYLOAD)
    assert hashlib.sha256(blob).hexdigest() == PAYLOAD_SHA
    source = Path('/kaggle/temp/qwen3-source')
    source.mkdir(parents=True, exist_ok=True)
    with zipfile.ZipFile(io.BytesIO(blob)) as archive:
        for name in archive.namelist():
            assert Path(name).name == name
            (source / name).write_bytes(archive.read(name))
    environment = Path('/kaggle/temp/qwen3-venv')
    venv.EnvBuilder(system_site_packages=True, with_pip=False).create(environment)
    python = environment / 'bin/python'
    subprocess.check_call([sys.executable, '-m', 'pip', '--python', str(python), 'install', '--no-cache-dir', '-r', str(source / 'qwen_requirements.txt')])
    subprocess.check_call([str(python), '-u', str(source / 'qwen3_train.py')])
except BaseException:
    (out / 'bootstrap-failure.txt').write_text(traceback.format_exc())
    raise
'''
compile(files['qwen3_train.py'].decode(), 'qwen3_train.py', 'exec')
compile(header + bootstrap, 'run.py', 'exec')
(DEST / 'run.py').write_text(header + bootstrap)
metadata = {'id': 'ritaainsworth/magicompile-qwen3-4b-corpus1100-001', 'title': 'MAGICompile Qwen3 4B corpus1100 001', 'code_file': 'run.py', 'language': 'python', 'kernel_type': 'script', 'is_private': 'true', 'enable_gpu': 'true', 'enable_tpu': 'false', 'enable_internet': 'true', 'machine_shape': 'NvidiaTeslaT4', 'dataset_sources': [], 'competition_sources': [], 'kernel_sources': [], 'model_sources': []}
(DEST / 'kernel-metadata.json').write_text(json.dumps(metadata, indent=2)+'\n')
(DEST / 'build-manifest.json').write_text(json.dumps({**meta, 'payload_sha256': hashlib.sha256(payload).hexdigest(), 'run_py_bytes': (DEST/'run.py').stat().st_size}, indent=2)+'\n')
print({'kernel': metadata['id'], 'source_bytes': (DEST/'run.py').stat().st_size})
