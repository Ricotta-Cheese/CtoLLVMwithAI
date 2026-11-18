"""Merge the verified adapter into its exact, unquantized Qwen3 base for Ollama."""
from pathlib import Path
import argparse
import hashlib
import json
import os
import shutil
import time
import subprocess
import sys
os.environ.setdefault('HF_HUB_DISABLE_XET', '0')

ROOT = Path(__file__).resolve().parents[2]
ADAPTER = ROOT / 'training/kaggle-results/qwen3-001/qwen3-4b-corpus1100-001/adapter-best'


def sha(path):
    digest = hashlib.sha256()
    with path.open('rb') as stream:
        for chunk in iter(lambda: stream.read(8 * 1024 * 1024), b''):
            digest.update(chunk)
    return digest.hexdigest()


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument('--work', type=Path, default=Path('/private/tmp/magicompile-ollama-build'))
    parser.add_argument('--offline', action='store_true', help='Use already verified local base weights')
    args = parser.parse_args()
    work = args.work
    lock = json.loads((ROOT / 'training/qwen3-model-lock.json').read_text())
    verified = json.loads((ADAPTER.parent / 'local-adapter-verification.json').read_text())
    assert sha(ADAPTER / 'adapter_model.safetensors') == verified['adapter_sha256']
    assert lock['revision'] == verified['revision'] and lock['model_id'] == verified['model_id']
    if not args.offline:
        subprocess.check_call([sys.executable, str(Path(__file__).with_name('download_base.py')), '--work', str(work)])
    base_path = work / 'base'
    base_record = json.loads((ROOT / 'local/ollama/base-download-manifest.json').read_text())
    assert base_record['revision'] == lock['revision'] and base_record['status'] == 'passed'
    for file in base_record['files']:
        assert sha(base_path / file['file']) == file['sha256']
    import torch
    from peft import PeftModel
    from transformers import AutoModelForCausalLM
    torch.set_num_threads(4)
    started = time.monotonic()
    print('Loading FP16 base on CPU; no training', flush=True)
    model = AutoModelForCausalLM.from_pretrained(base_path, torch_dtype=torch.float16, device_map={'': 'cpu'},
        low_cpu_mem_usage=True, trust_remote_code=False, local_files_only=True)
    tuned = PeftModel.from_pretrained(model, str(ADAPTER), is_trainable=False, local_files_only=True, device_map={'': 'cpu'}, low_cpu_mem_usage=True)
    print('Merging LoRA weights', flush=True)
    merged = tuned.merge_and_unload(safe_merge=True)
    output = work / 'merged'
    merged.save_pretrained(output, safe_serialization=True, max_shard_size='2GB')
    # Preserve the training tokenizer and its non-thinking chat template byte for byte.
    for p in ADAPTER.iterdir():
        if p.name in ('tokenizer.json','tokenizer_config.json','special_tokens_map.json','added_tokens.json','vocab.json','merges.txt','chat_template.jinja'):
            shutil.copyfile(p, output / p.name)
    license_file = Path(base_path) / 'LICENSE'
    if license_file.exists(): shutil.copyfile(license_file, output / 'LICENSE')
    record = {**lock, 'adapter_sha256': verified['adapter_sha256'], 'merge': 'PEFT safe_merge into FP16 unquantized CPU base',
        'training_performed': False, 'seconds': time.monotonic()-started,
        'files': {p.name: {'bytes': p.stat().st_size, 'sha256': sha(p)} for p in sorted(output.iterdir()) if p.is_file()},
        'caveat': 'Kaggle evaluated an NF4 base plus adapter. FP16 merge/Ollama inference is a different numerical execution and requires separate accuracy evaluation.'}
    (ROOT / 'local/ollama/merge-manifest.json').write_text(json.dumps(record, indent=2)+'\n')
    print('MERGE_COMPLETE', str(output), flush=True)


if __name__ == '__main__': main()
