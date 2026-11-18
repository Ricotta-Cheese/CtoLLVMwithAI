"""Paired pre/post QLoRA trial on the frozen pilot validation split."""
from pathlib import Path
import hashlib
import json
import os
import sys
import time

# Keep public base-model downloads outside Kaggle's published working outputs.
os.environ['CUDA_VISIBLE_DEVICES'] = '0'
os.environ['HF_HOME'] = '/kaggle/temp/qwen-hf-cache'
os.environ['HF_HUB_DISABLE_XET'] = '1'
os.environ['TOKENIZERS_PARALLELISM'] = 'false'
os.environ['WANDB_DISABLED'] = 'true'

import torch
from huggingface_hub import HfApi
from peft import LoraConfig, get_peft_model, prepare_model_for_kbit_training
from transformers import (AutoTokenizer, AutoModelForCausalLM, BitsAndBytesConfig,
                          GenerationConfig, Trainer, TrainingArguments, set_seed)
import scratch

RUN = Path('/kaggle/working/qwen-pilot-001')
RUN.mkdir(parents=True, exist_ok=True)
SOURCE = Path(__file__).parent
MODEL_ID = 'Qwen/Qwen2.5-Coder-1.5B'
CONTEXT = 3072
GENERATION_CAP = 2560
SEED = 20261113


def save(name, value):
    scratch.write_json(RUN / name, value)


def encode(rows, tokenizer):
    features = []
    for row in rows:
        prefix = tokenizer.encode(row['prompt'], add_special_tokens=False)
        completion = tokenizer.encode(row['completion'], add_special_tokens=False) + [tokenizer.eos_token_id]
        if len(prefix) + len(completion) > CONTEXT:
            raise ValueError(f"no truncation allowed: {row['id']} has {len(prefix) + len(completion)} tokens")
        features.append({'input_ids': prefix + completion, 'labels': [-100] * len(prefix) + completion})
    return features


def collate(features):
    # Position-based masking preserves the supervised EOS when pad == EOS.
    return scratch.make_batch(features, TOKENIZER.pad_token_id, 'cpu')


def predict(model, tokenizer, rows, label):
    model.eval()
    model.config.use_cache = True
    records = []
    cache_path = SOURCE / f'{label}-cached.jsonl'
    cached_rows = {r['id']: r for r in map(json.loads, cache_path.read_text().splitlines())} if cache_path.exists() else {}
    destination = RUN / f'{label}-predictions.jsonl'
    with destination.open('w') as stream:
        for row in rows:
            cached = cached_rows.get(row['id'])
            if cached and cached['ended_with_eos'] and cached['prompt_sha256'] == hashlib.sha256(row['prompt'].encode()).hexdigest():
                result = dict(cached, reused_completed_baseline=True)
                stream.write(json.dumps(result) + '\n')
                stream.flush()
                records.append(result)
                print(json.dumps({'phase': label, 'id': row['id'], 'reused_completed_baseline': True}), flush=True)
                continue
            inputs = tokenizer(row['prompt'], return_tensors='pt', add_special_tokens=False).to('cuda:0')
            budget = min(GENERATION_CAP, CONTEXT - inputs['input_ids'].shape[1])
            if budget <= 0:
                raise ValueError('prompt fills context')
            started = time.monotonic()
            with torch.inference_mode():
                output = model.generate(**inputs, generation_config=GenerationConfig(
                    do_sample=False, num_beams=1, max_new_tokens=budget, max_time=300,
                    use_cache=True, eos_token_id=tokenizer.eos_token_id, pad_token_id=tokenizer.pad_token_id))
            generated = output[0, inputs['input_ids'].shape[1]:].tolist()
            ended = bool(generated and generated[-1] == tokenizer.eos_token_id)
            text_ids = generated[:-1] if ended else generated
            result = {'id': row['id'], 'category': row['category'], 'model': label,
                      'prompt_sha256': hashlib.sha256(row['prompt'].encode()).hexdigest(),
                      'generated_ir': tokenizer.decode(text_ids, skip_special_tokens=False),
                      'generated_tokens': len(generated), 'ended_with_eos': ended,
                      'limit_reached': not ended, 'generation_seconds': time.monotonic() - started,
                      'generation_budget': budget}
            stream.write(json.dumps(result) + '\n')
            stream.flush()
            records.append(result)
            print(json.dumps({'phase': label, 'id': row['id'], 'tokens': len(generated),
                              'eos': ended, 'seconds': result['generation_seconds']}), flush=True)
            del output, inputs
    model.config.use_cache = False
    torch.cuda.empty_cache()
    return records


def main():
    global TOKENIZER
    if not torch.cuda.is_available():
        raise RuntimeError('CUDA GPU is required')
    set_seed(SEED)
    torch.set_num_threads(4)
    metadata = json.loads((SOURCE / 'dataset_metadata.json').read_text())
    rows = scratch.load_rows(SOURCE / 'dataset.jsonl', metadata['dataset_sha256'])
    splits = scratch.split_rows(rows, SEED)
    expected_splits = json.loads((SOURCE / 'frozen-splits.json').read_text())
    split_ids = {key: [r['id'] for r in value] for key, value in splits.items()}
    if split_ids != expected_splits:
        raise ValueError('split differs from scratch pilot')
    save('splits.json', split_ids)
    # Evaluate the frozen scratch checkpoint before allocating the larger Qwen model.
    from scratch_cached_generation import generate as scratch_generate
    comparison = json.loads((SOURCE / 'comparison-metadata.json').read_text())
    candidates = list(Path('/kaggle/input').rglob('model-best.pt'))
    matched = [p for p in candidates if hashlib.file_digest(p.open('rb'), 'sha256').hexdigest() == comparison['scratch_model_sha256']]
    if len(matched) != 1:
        raise ValueError(f'expected one matching scratch checkpoint, found {len(matched)}')
    old_path = matched[0]
    old_tokenizer = scratch.Tokenizer.from_file(str(old_path.parent / 'tokenizer.json'))
    old_model = scratch.ScratchCausalLM(old_tokenizer.get_vocab_size(), context_length=3072,
                                      d_model=512, n_heads=8, n_layers=8, dropout=0.1).to('cuda:0')
    old_model.load_state_dict(torch.load(old_path, map_location='cuda:0', weights_only=True), strict=True)
    with (RUN / 'scratch-pilot-predictions.jsonl').open('w') as stream:
        for row in splits['validation']:
            result = scratch_generate(old_model, old_tokenizer, row['prompt'], 'cuda:0', GENERATION_CAP, 120)
            result.update(id=row['id'], category=row['category'], model='scratch-pilot',
                          prompt_sha256=hashlib.sha256(row['prompt'].encode()).hexdigest())
            stream.write(json.dumps(result) + '\n')
            stream.flush()
            print(json.dumps({'phase': 'scratch-pilot', 'id': row['id'], 'tokens': result['generated_tokens'],
                              'eos': result['ended_with_eos'], 'seconds': result['generation_seconds']}), flush=True)
    del old_model, old_tokenizer
    torch.cuda.empty_cache()
    set_seed(SEED)
    revision = HfApi(token=False).model_info(MODEL_ID).sha
    TOKENIZER = AutoTokenizer.from_pretrained(MODEL_ID, revision=revision, trust_remote_code=False, token=False)
    TOKENIZER.pad_token = TOKENIZER.eos_token
    TOKENIZER.padding_side = 'right'
    train_features = encode(splits['train'], TOKENIZER)
    validation_features = encode(splits['validation'], TOKENIZER)
    spec = {'model_id': MODEL_ID, 'revision': revision, 'seed': SEED, 'max_steps': 60,
            'batch_size': 1, 'gradient_accumulation_steps': 4, 'learning_rate': 1e-4,
            'lora_rank': 8, 'lora_alpha': 16, 'lora_dropout': 0.05,
            'quantization': '4-bit NF4 double quantization', 'context_length': CONTEXT,
            'generation_cap': GENERATION_CAP, 'generation_max_seconds_per_function': 300,
            'generation': 'one greedy sample per validation function; raw output; no repair',
            'dataset_sha256': metadata['dataset_sha256'], 'splits': split_ids,
            'test_set_evaluated': False, 'prompt_format': 'existing raw prompt; no chat template',
            'train_max_tokens': max(len(x['input_ids']) for x in train_features),
            'validation_max_tokens': max(len(x['input_ids']) for x in validation_features),
            'torch_version': str(torch.__version__), 'cuda_version': torch.version.cuda,
            'gpu_name': torch.cuda.get_device_name(0)}
    save('run-spec.json', spec)
    print('QWEN_SPEC ' + json.dumps(spec), flush=True)
    bnb = BitsAndBytesConfig(load_in_4bit=True, bnb_4bit_quant_type='nf4',
                            bnb_4bit_use_double_quant=True, bnb_4bit_compute_dtype=torch.float16)
    cached_spec_path = SOURCE / 'cached-baseline-spec.json'
    if cached_spec_path.exists():
        cached_spec = json.loads(cached_spec_path.read_text())
        if cached_spec['revision'] != revision or cached_spec['dataset_sha256'] != metadata['dataset_sha256']:
            raise ValueError('cached baseline model/data revision mismatch')
    model = AutoModelForCausalLM.from_pretrained(MODEL_ID, revision=revision, token=False,
            trust_remote_code=False, quantization_config=bnb, torch_dtype=torch.float16,
            device_map={'': 0}, attn_implementation='sdpa')
    baseline = predict(model, TOKENIZER, splits['validation'], 'qwen-base-4bit')
    model = prepare_model_for_kbit_training(model, use_gradient_checkpointing=True,
                                           gradient_checkpointing_kwargs={'use_reentrant': False})
    model = get_peft_model(model, LoraConfig(r=8, lora_alpha=16, lora_dropout=0.05,
                    target_modules='all-linear', bias='none', task_type='CAUSAL_LM'))
    trainable = sum(p.numel() for p in model.parameters() if p.requires_grad)
    model.print_trainable_parameters()
    args = TrainingArguments(output_dir=str(RUN / 'checkpoints'), max_steps=60,
        per_device_train_batch_size=1, per_device_eval_batch_size=1,
        gradient_accumulation_steps=4, learning_rate=1e-4, warmup_steps=5,
        lr_scheduler_type='cosine', fp16=True, bf16=False,
        gradient_checkpointing=True, gradient_checkpointing_kwargs={'use_reentrant': False},
        eval_strategy='steps', eval_steps=20, save_strategy='steps', save_steps=20,
        save_total_limit=2, load_best_model_at_end=True, metric_for_best_model='eval_loss',
        greater_is_better=False, logging_steps=5, optim='adamw_torch',
        report_to='none', seed=SEED, data_seed=SEED, remove_unused_columns=False,
        label_names=['labels'], dataloader_num_workers=0)
    trainer = Trainer(model=model, args=args, train_dataset=train_features,
                      eval_dataset=validation_features, data_collator=collate, processing_class=TOKENIZER)
    if trainer.args.n_gpu != 1:
        raise RuntimeError('quantized trial must use exactly one visible GPU')
    save('trainer-effective-settings.json', {'visible_gpus': torch.cuda.device_count(),
          'trainer_n_gpu': trainer.args.n_gpu, 'train_batch_size': trainer.args.train_batch_size,
          'gradient_accumulation_steps': trainer.args.gradient_accumulation_steps})
    initial_loss = trainer.evaluate()['eval_loss']
    start = time.monotonic()
    trainer.train()
    training_seconds = time.monotonic() - start
    trainer.save_model(str(RUN / 'adapter-best'))
    TOKENIZER.save_pretrained(RUN / 'adapter-best')
    save('metrics.json', trainer.state.log_history)
    model.gradient_checkpointing_disable()
    tuned = predict(model, TOKENIZER, splits['validation'], 'qwen-qlora')
    save('summary.json', {'status': 'passed', 'model_id': MODEL_ID, 'revision': revision,
        'training_steps': trainer.state.global_step, 'training_seconds': training_seconds,
        'trainable_parameters': trainable, 'initial_validation_loss': initial_loss,
        'best_validation_loss': trainer.state.best_metric, 'best_checkpoint': trainer.state.best_model_checkpoint,
        'peak_gpu_memory_gib': torch.cuda.max_memory_allocated(0) / 2**30,
        'base_complete_outputs': sum(r['ended_with_eos'] for r in baseline),
        'tuned_complete_outputs': sum(r['ended_with_eos'] for r in tuned),
        'validation_functions': len(tuned), 'test_set_evaluated': False,
        'accuracy_evaluation': 'pending local LLVM and execution checks'})
    print('QWEN_TRAINING_COMPLETE', flush=True)


if __name__ == '__main__':
    try:
        main()
    except BaseException as error:
        import traceback
        (RUN / 'failure.txt').write_text(traceback.format_exc())
        save('failure.json', {'status': 'failed', 'type': type(error).__name__, 'message': str(error)})
        raise
