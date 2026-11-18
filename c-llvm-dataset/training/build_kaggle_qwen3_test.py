"""Freeze test inputs and decoding policy before the first held-out run."""
from pathlib import Path
import base64, hashlib, io, json, zipfile
ROOT = Path(__file__).resolve().parents[1]
corpus = ROOT / 'corpus-1100-v001'
result = ROOT / 'training/kaggle-results/qwen3-001/qwen3-4b-corpus1100-001'
splits = json.loads((corpus / 'splits.json').read_text())
rows = {r['id']: r for r in map(json.loads, (corpus / 'dataset.jsonl').read_text().splitlines())}
# Only inputs travel to the inference job: no reference IR, source code, or expected outputs.
inputs = ''.join(json.dumps({k: rows[i][k] for k in ('id', 'category', 'prompt')})+'\n' for i in splits['test']).encode()
assert len(splits['test']) == 110 and not set(splits['test']) & set(splits['train'] + splits['validation'])
train = json.loads((result / 'run-spec.json').read_text())
verified = json.loads((result / 'local-adapter-verification.json').read_text())
spec = {k: train[k] for k in ('model_id', 'revision', 'system_prompt', 'dataset_sha256', 'corpus_manifest_sha256', 'splits_sha256')}
spec.update(adapter_sha256=verified['adapter_sha256'], max_new_tokens=4096, max_seconds_per_function=600, decoding='one greedy raw candidate; no repair or retries',
    mode='inference_only', use_model_defaults=False, do_sample=False, test_inputs_sha256=hashlib.sha256(inputs).hexdigest(), test_count=110,
    training_kernel='ritaainsworth/magicompile-qwen3-4b-corpus1100-001', training_kernel_version=1,
    native_execution_plan='locked native Apple Clang evaluation locally; Kaggle performs inference only')
files = {'test-inputs.jsonl': inputs, 'test-spec.json': json.dumps(spec, indent=2).encode(), 'splits.json': (corpus/'splits.json').read_bytes(),
    'qwen3_test.py': (ROOT/'training/qwen3_test.py').read_bytes(), 'qwen_requirements.txt': (ROOT/'training/qwen_requirements.txt').read_bytes()}
spec['evaluation_source_sha256'] = hashlib.sha256(files['qwen3_test.py']).hexdigest()
files['test-spec.json'] = json.dumps(spec, indent=2).encode()
blob = io.BytesIO()
with zipfile.ZipFile(blob,'w',compression=zipfile.ZIP_DEFLATED) as z:
    for k,v in sorted(files.items()):z.writestr(k,v)
payload=blob.getvalue()
bootstrap = '''
from pathlib import Path
import base64,hashlib,io,zipfile,subprocess,sys,venv,traceback
out=Path('/kaggle/working/qwen3-test110-002');out.mkdir(parents=True,exist_ok=True)
try:
    blob=base64.b64decode(PAYLOAD);assert hashlib.sha256(blob).hexdigest()==PAYLOAD_SHA
    source=Path('/kaggle/temp/qwen3-test-source');source.mkdir(parents=True,exist_ok=True)
    with zipfile.ZipFile(io.BytesIO(blob)) as z:
        for n in z.namelist():
            assert Path(n).name==n
            (source/n).write_bytes(z.read(n))
    env=Path('/kaggle/temp/qwen3-test-venv');venv.EnvBuilder(system_site_packages=True,with_pip=False).create(env)
    python=env/'bin/python'
    subprocess.check_call([sys.executable,'-m','pip','--python',str(python),'install','--no-cache-dir','-r',str(source/'qwen_requirements.txt')])
    subprocess.check_call([str(python),'-u',str(source/'qwen3_test.py')])
except BaseException:
    (out/'bootstrap-failure.txt').write_text(traceback.format_exc());raise
'''
script=f'PAYLOAD={base64.b64encode(payload).decode()!r}\nPAYLOAD_SHA={hashlib.sha256(payload).hexdigest()!r}\n'+bootstrap
compile(script,'run.py','exec');compile(files['qwen3_test.py'].decode(),'qwen3_test.py','exec')
dest=ROOT/'training/kaggle-qwen3-test-001';dest.mkdir(exist_ok=True)
(dest/'run.py').write_text(script)
metadata=json.loads((ROOT/'training/kaggle-qwen3-001/kernel-metadata.json').read_text())
metadata.update(id='ritaainsworth/magicompile-qwen3-test110-002',title='MAGICompile Qwen3 test110 002',kernel_sources=[spec['training_kernel']])
(dest/'kernel-metadata.json').write_text(json.dumps(metadata,indent=2)+'\n')
(dest/'test-spec.json').write_text(json.dumps(spec,indent=2)+'\n')
print({'kernel':metadata['id'],'test_count':110,'reference_outputs_in_payload':False,'run_bytes':len(script)})
