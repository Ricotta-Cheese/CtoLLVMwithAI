"""Inference-only evaluation on the frozen test split; independent workers per GPU."""
from pathlib import Path
import hashlib
import json
import os
import subprocess
import sys
import time

SOURCE = Path(__file__).parent
RUN = Path('/kaggle/working/qwen3-test110-002')
RUN.mkdir(parents=True, exist_ok=True)


def save(path, value):
    path.write_text(json.dumps(value, indent=2) + '\n')


def worker(index, count):
    # Each child sees its assigned GPU as cuda:0. No model splitting or DataParallel.
    os.environ.update(CUDA_VISIBLE_DEVICES=str(index), HF_HOME='/kaggle/temp/qwen3-test-hf', HF_HUB_DISABLE_XET='1', TOKENIZERS_PARALLELISM='false')
    import torch
    from peft import PeftModel
    from transformers import AutoTokenizer, AutoModelForCausalLM, BitsAndBytesConfig, GenerationConfig, set_seed
    set_seed(20261113)
    torch.set_num_threads(2)
    spec = json.loads((SOURCE / 'test-spec.json').read_text())
    raw = (SOURCE / 'test-inputs.jsonl').read_bytes()
    assert hashlib.sha256(raw).hexdigest() == spec['test_inputs_sha256']
    rows = [json.loads(line) for line in raw.splitlines()][index::count]
    weights = [p for p in Path('/kaggle/input').rglob('adapter_model.safetensors')
               if hashlib.sha256(p.read_bytes()).hexdigest() == spec['adapter_sha256']]
    if len(weights) != 1: raise ValueError(f'expected one frozen adapter, found {len(weights)}')
    adapter = weights[0].parent
    tokenizer = AutoTokenizer.from_pretrained(adapter, local_files_only=True)
    tokenizer.pad_token = tokenizer.eos_token
    base = AutoModelForCausalLM.from_pretrained(spec['model_id'], revision=spec['revision'], token=False, trust_remote_code=False,
        quantization_config=BitsAndBytesConfig(load_in_4bit=True, bnb_4bit_quant_type='nf4', bnb_4bit_use_double_quant=True, bnb_4bit_compute_dtype=torch.float16),
        torch_dtype=torch.float16, device_map={'': 0}, attn_implementation='sdpa')
    model = PeftModel.from_pretrained(base, adapter, is_trainable=False)
    model.eval()
    model.config.use_cache = True
    with (RUN / f'predictions-part-{index}.jsonl').open('w') as stream:
        for row in rows:
            ids = tokenizer.apply_chat_template([{'role': 'system', 'content': spec['system_prompt']}, {'role': 'user', 'content': row['prompt']}], tokenize=True, add_generation_prompt=True)
            inputs = torch.tensor([ids], device='cuda:0')
            started = time.monotonic()
            with torch.inference_mode():
                output = model.generate(use_model_defaults=False, do_sample=False, input_ids=inputs, attention_mask=torch.ones_like(inputs), generation_config=GenerationConfig(
                    do_sample=False, num_beams=1, max_new_tokens=spec['max_new_tokens'], max_time=spec['max_seconds_per_function'],
                    eos_token_id=tokenizer.eos_token_id, pad_token_id=tokenizer.pad_token_id, use_cache=True))
            tokens = output[0, len(ids):].tolist()
            ended = bool(tokens and tokens[-1] == tokenizer.eos_token_id)
            seconds = time.monotonic() - started
            result = {'id': row['id'], 'category': row['category'], 'model': 'qwen3-4b-qlora-test',
                'prompt_sha256': hashlib.sha256(row['prompt'].encode()).hexdigest(),
                'generated_ir': tokenizer.decode(tokens[:-1] if ended else tokens, skip_special_tokens=False),
                'generated_tokens': len(tokens), 'ended_with_eos': ended, 'limit_reached': not ended,
                'generation_seconds': seconds, 'generation_budget': spec['max_new_tokens'],
                'limit_reason': None if ended else ('token_limit' if len(tokens) >= spec['max_new_tokens'] else 'time_limit')}
            stream.write(json.dumps(result) + '\n'); stream.flush()
            print(json.dumps({'worker': index, 'id': row['id'], 'tokens': len(tokens), 'complete': ended, 'seconds': seconds}), flush=True)
            del output, inputs
    save(RUN / f'worker-{index}.json', {'status': 'passed', 'functions': len(rows), 'peak_gpu_allocated_gib': torch.cuda.max_memory_allocated()/2**30})


def main():
    spec = json.loads((SOURCE / 'test-spec.json').read_text())
    save(RUN / 'test-spec.json', spec)
    splits = json.loads((SOURCE / 'splits.json').read_text())
    save(RUN / 'splits.json', splits)
    # Kaggle T4 allocation provides two independent 16GB GPUs. Fall back to one if necessary.
    import torch
    count = min(2, torch.cuda.device_count())
    if not count: raise RuntimeError('CUDA required')
    children = [subprocess.Popen([sys.executable, '-u', str(Path(__file__)), '--worker', str(i), str(count)]) for i in range(count)]
    codes = [p.wait() for p in children]
    if any(codes): raise RuntimeError(f'inference worker failed: {codes}')
    predictions = [json.loads(line) for i in range(count) for line in (RUN / f'predictions-part-{i}.jsonl').read_text().splitlines()]
    lookup = {r['id']: r for r in predictions}
    if len(predictions) != len(lookup) or set(lookup) != set(splits['test']):
        raise ValueError('test coverage mismatch')
    ordered = [lookup[i] for i in splits['test']]
    (RUN / 'test-predictions.jsonl').write_text(''.join(json.dumps(r)+'\n' for r in ordered))
    save(RUN / 'summary.json', {'status': 'passed', 'mode': 'inference_only', 'test_functions': len(ordered),
        'completed': sum(r['ended_with_eos'] for r in ordered), 'gpu_workers': count,
        'native_execution_evaluated': False, 'native_execution_plan': 'locked Apple Clang local evaluation of raw IR; no retargeting or repair'})
    print('QWEN3_TEST_GENERATION_COMPLETE', flush=True)


if __name__ == '__main__':
    try:
        if len(sys.argv) > 1 and sys.argv[1] == '--worker': worker(int(sys.argv[2]), int(sys.argv[3]))
        else: main()
    except BaseException:
        import traceback
        (RUN / ('failure-' + str(os.getpid()) + '.txt')).write_text(traceback.format_exc())
        raise
