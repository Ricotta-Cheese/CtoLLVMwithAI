"""Resume the pinned public base in bounded HTTP ranges and verify official SHA-256."""
from concurrent.futures import ThreadPoolExecutor, as_completed
from pathlib import Path
import argparse
import hashlib
import json
import os
import shutil
import threading
import time
os.environ['HF_HUB_DISABLE_XET'] = '1'
import requests
from huggingface_hub import get_hf_file_metadata, hf_hub_url, snapshot_download

ROOT = Path(__file__).resolve().parents[2]
BLOCK = 64 * 1024 * 1024


def sha(path):
    h = hashlib.sha256()
    with path.open('rb') as f:
        for data in iter(lambda: f.read(8*1024*1024), b''): h.update(data)
    return h.hexdigest()


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument('--work',type=Path,default=Path('/private/tmp/magicompile-ollama-build'))
    args = parser.parse_args()
    base = args.work / 'base'
    lock = json.loads((ROOT/'training/qwen3-model-lock.json').read_text())
    snapshot_download(lock['model_id'],revision=lock['revision'],token=False,local_dir=base,
        allow_patterns=['*.json','*.txt','*.jinja','LICENSE'])
    index=json.loads((base/'model.safetensors.index.json').read_text())
    records=[]
    for name in sorted(set(index['weight_map'].values())):
        meta=get_hf_file_metadata(hf_hub_url(lock['model_id'],name,revision=lock['revision']),token=False)
        if not meta.etag or len(meta.etag)!=64: raise RuntimeError('Expected SHA-256 LFS ETag')
        records.append((name,meta))
    completed=0
    total=sum(m.size for _,m in records)
    mutex=threading.Lock()
    last=[0.0]
    def advance(n):
        nonlocal completed
        with mutex:
            completed += n
            now=time.monotonic()
            if now-last[0]>=5:
                last[0]=now
                state={'downloaded_bytes':completed,'total_bytes':total,'percent':round(completed/total*100,1)}
                (ROOT/'local/ollama/download-status.json').write_text(json.dumps(state,indent=2)+'\n')
                print(f"DOWNLOAD {state['percent']}% ({completed/1e9:.2f}/{total/1e9:.2f} GB)",flush=True)
    def fetch(meta,start,end,destination):
        length=end-start+1
        if destination.exists() and destination.stat().st_size==length:
            advance(length); return
        partial=destination.with_suffix('.partial')
        for attempt in range(4):
            wrote=0
            try:
                with requests.get(meta.location,headers={'Range':f'bytes={start}-{end}'},stream=True,timeout=(15,60)) as r:
                    if r.status_code!=206 or r.headers.get('Content-Range')!=f'bytes {start}-{end}/{meta.size}':
                        raise RuntimeError(f'Unexpected range response: HTTP {r.status_code}, {r.headers.get("Content-Range")}')
                    with partial.open('wb') as f:
                        for chunk in r.iter_content(1024*1024):
                            if chunk:
                                f.write(chunk);wrote+=len(chunk);advance(len(chunk))
                if wrote!=length: raise RuntimeError('Incomplete range')
                partial.replace(destination);return
            except Exception:
                advance(-wrote)
                if attempt==3:raise
                time.sleep(2**attempt)
    manifest=[]
    for name,meta in records:
        output=base/name
        if output.exists() and output.stat().st_size==meta.size and sha(output)==meta.etag:
            advance(meta.size);manifest.append({'file':name,'bytes':meta.size,'sha256':meta.etag});continue
        parts=args.work/'download-parts'/name;parts.mkdir(parents=True,exist_ok=True)
        old=list((base/'.cache/huggingface/download').glob(f'*.{meta.etag}.incomplete'))
        prefix=old[0] if old and 0<old[0].stat().st_size<meta.size else None
        offset=prefix.stat().st_size if prefix else 0
        for pass_number in range(2):
            chunks=[]
            if offset: advance(offset)
            with ThreadPoolExecutor(max_workers=8) as pool:
                futures=[]
                for start in range(offset,meta.size,BLOCK):
                    end=min(meta.size-1,start+BLOCK-1)
                    part=parts/f'{start:012d}-{end:012d}.part'
                    chunks.append(part);futures.append(pool.submit(fetch,meta,start,end,part))
                for future in as_completed(futures):future.result()
            assembled=output.with_suffix('.assembling')
            with assembled.open('wb') as target:
                for source in ([prefix] if offset else [])+chunks:
                    with source.open('rb') as src:shutil.copyfileobj(src,target,8*1024*1024)
            if assembled.stat().st_size==meta.size and sha(assembled)==meta.etag:
                assembled.replace(output)
                if prefix:prefix.unlink(missing_ok=True)
                shutil.rmtree(parts)
                print('SHA256_OK',name,flush=True)
                break
            assembled.unlink(missing_ok=True)
            if pass_number:raise RuntimeError('Base shard checksum mismatch')
            # Never trust a prior prefix or unverified chunk after a checksum failure.
            advance(-meta.size);offset=0;prefix=None
            shutil.rmtree(parts);parts.mkdir()
        manifest.append({'file':name,'bytes':meta.size,'sha256':meta.etag})
    (ROOT/'local/ollama/base-download-manifest.json').write_text(json.dumps({**lock,'status':'passed','files':manifest},indent=2)+'\n')
    print('BASE_DOWNLOAD_COMPLETE',flush=True)


if __name__=='__main__': main()
