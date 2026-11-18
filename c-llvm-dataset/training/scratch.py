"""A byte-level tokenizer and causal Transformer trained without pretrained weights."""
from __future__ import annotations

from collections import Counter
import hashlib
import json
import math
from pathlib import Path
import platform
import time

import torch
from torch import nn
from torch.nn import functional as F
from tokenizers import Tokenizer, decoders, models, pre_tokenizers, trainers

SPECIAL_TOKENS = ["<|pad|>", "<|eos|>", "<|unk|>", "<|ir|>"]


def sha256(data):
    return hashlib.sha256(data).hexdigest()


def write_json(path, value):
    Path(path).write_text(json.dumps(value, ensure_ascii=False, indent=2, sort_keys=True) + "\n", encoding="utf-8")


def load_rows(path, expected_sha256):
    raw = Path(path).read_bytes()
    if sha256(raw) != expected_sha256:
        raise ValueError("dataset SHA-256 differs from the selected dataset metadata")
    rows = [json.loads(line) for line in raw.decode("utf-8").splitlines() if line.strip()]
    if not rows or len({row["id"] for row in rows}) != len(rows):
        raise ValueError("empty dataset or duplicate IDs")
    if len({row["structure_id"] for row in rows}) != len(rows):
        raise ValueError("duplicate structure groups; group these before splitting")
    for row in rows:
        if sha256(row["completion"].encode()) != row["ir_sha256"]:
            raise ValueError(f"IR digest mismatch: {row['id']}")
        if sha256(row["c_source"].encode()) != row["source_sha256"]:
            raise ValueError(f"C digest mismatch: {row['id']}")
        if any(token in row["prompt"] or token in row["completion"] for token in SPECIAL_TOKENS):
            raise ValueError("reserved token in source text")
    if len({row["target"] for row in rows}) != 1:
        raise ValueError("use a single target profile for the first experiment")
    return rows


def split_rows(rows, seed):
    result = {"train": [], "validation": [], "test": []}
    for category in sorted({row["category"] for row in rows}):
        group = [row for row in rows if row["category"] == category]
        if len(group) < 5:
            raise ValueError("at least five distinct structures per category are required")
        group.sort(key=lambda row: sha256(f"{seed}:{category}:{row['structure_id']}".encode()))
        held_out = max(1, len(group) // 10)
        result["train"].extend(group[:-2 * held_out])
        result["validation"].extend(group[-2 * held_out:-held_out])
        result["test"].extend(group[-held_out:])
    return result


def train_tokenizer(train_rows, vocab_size=2048):
    tokenizer = Tokenizer(models.BPE(unk_token="<|unk|>"))
    tokenizer.pre_tokenizer = pre_tokenizers.ByteLevel(add_prefix_space=False)
    tokenizer.decoder = decoders.ByteLevel()
    trainer = trainers.BpeTrainer(vocab_size=vocab_size, min_frequency=2,
                                  initial_alphabet=pre_tokenizers.ByteLevel.alphabet(),
                                  special_tokens=SPECIAL_TOKENS, show_progress=False)
    tokenizer.train_from_iterator((text for row in train_rows for text in (row["prompt"], row["completion"])), trainer)
    return tokenizer


def encode_rows(rows, tokenizer, max_length):
    result, oversized = [], []
    for row in rows:
        prompt_ids = tokenizer.encode(row["prompt"], add_special_tokens=False).ids
        prefix = prompt_ids + [tokenizer.token_to_id("<|ir|>")]
        completion = tokenizer.encode(row["completion"], add_special_tokens=False).ids
        if tokenizer.decode(completion, skip_special_tokens=False) != row["completion"]:
            raise ValueError("tokenizer failed exact IR roundtrip")
        if tokenizer.token_to_id("<|unk|>") in prompt_ids + completion:
            raise ValueError("unexpected unknown token")
        completion += [tokenizer.token_to_id("<|eos|>")]
        ids = prefix + completion
        if len(ids) > max_length:
            oversized.append({"id": row["id"], "length": len(ids)})
        result.append({"id": row["id"], "input_ids": ids,
                       "labels": [-100] * len(prefix) + completion,
                       "prefix_length": len(prefix)})
    if oversized:
        raise ValueError(f"context too short; do not truncate IR: {oversized[:8]}")
    return result


def make_batch(features, pad_id, device):
    length = max(len(feature["input_ids"]) for feature in features)
    ids, labels, mask = [], [], []
    for feature in features:
        n = len(feature["input_ids"])
        ids.append(feature["input_ids"] + [pad_id] * (length - n))
        labels.append(feature["labels"] + [-100] * (length - n))
        mask.append([True] * n + [False] * (length - n))
    return {"input_ids": torch.tensor(ids, dtype=torch.long, device=device),
            "labels": torch.tensor(labels, dtype=torch.long, device=device),
            "attention_mask": torch.tensor(mask, dtype=torch.bool, device=device)}


class ScratchCausalLM(nn.Module):
    def __init__(self, vocab_size, context_length=3072, d_model=512, n_heads=8, n_layers=8, dropout=0.1):
        super().__init__()
        self.context_length = context_length
        self.token_embedding = nn.Embedding(vocab_size, d_model)
        self.position_embedding = nn.Embedding(context_length, d_model)
        self.dropout = nn.Dropout(dropout)
        block = nn.TransformerEncoderLayer(d_model=d_model, nhead=n_heads, dim_feedforward=4 * d_model,
                                           dropout=dropout, activation="gelu", batch_first=True, norm_first=True)
        self.blocks = nn.TransformerEncoder(block, num_layers=n_layers, norm=nn.LayerNorm(d_model),
                                             enable_nested_tensor=False)
        self.lm_head = nn.Linear(d_model, vocab_size, bias=False)
        # TransformerEncoder clones its prototype. Reinitialize EVERY layer independently.
        self.apply(self._initialize)
        self.lm_head.weight = self.token_embedding.weight
        self.register_buffer("causal_mask", torch.triu(torch.ones(context_length, context_length, dtype=torch.bool), diagonal=1),
                             persistent=False)

    @staticmethod
    def _initialize(module):
        if isinstance(module, (nn.Linear, nn.Embedding)):
            nn.init.normal_(module.weight, mean=0.0, std=0.02)
            if isinstance(module, nn.Linear) and module.bias is not None:
                nn.init.zeros_(module.bias)
        elif isinstance(module, nn.MultiheadAttention):
            nn.init.normal_(module.in_proj_weight, mean=0.0, std=0.02)
            if module.in_proj_bias is not None:
                nn.init.zeros_(module.in_proj_bias)
        elif isinstance(module, nn.LayerNorm):
            nn.init.ones_(module.weight)
            nn.init.zeros_(module.bias)

    def forward(self, input_ids, attention_mask):
        length = input_ids.shape[1]
        if length > self.context_length:
            raise ValueError("context overflow")
        positions = torch.arange(length, device=input_ids.device)
        hidden = self.dropout(self.token_embedding(input_ids) + self.position_embedding(positions))
        hidden = self.blocks(hidden, mask=self.causal_mask[:length, :length],
                             src_key_padding_mask=~attention_mask, is_causal=True)
        return self.lm_head(hidden)


def loss_sum(model, batch):
    logits = model(batch["input_ids"], batch["attention_mask"])
    labels = batch["labels"][:, 1:]
    count = int((labels != -100).sum().item())
    if count == 0:
        raise ValueError("batch contains no completion targets")
    loss = F.cross_entropy(logits[:, :-1].float().reshape(-1, logits.shape[-1]), labels.reshape(-1),
                           ignore_index=-100, reduction="sum")
    return loss, count


@torch.no_grad()
def evaluate_loss(model, features, pad_id, device):
    previous = model.training
    model.eval()
    total, tokens = 0.0, 0
    for feature in features:
        value, count = loss_sum(model, make_batch([feature], pad_id, device))
        total += float(value.item())
        tokens += count
    model.train(previous)
    return total / tokens


def make_optimizer(model, config):
    return torch.optim.AdamW(model.parameters(), lr=config["learning_rate"], betas=(0.9, 0.95), weight_decay=0.1)


def make_scheduler(optimizer, config):
    def multiplier(step):
        if step < config["warmup_steps"]:
            return (step + 1) / max(1, config["warmup_steps"])
        fraction = (step - config["warmup_steps"]) / max(1, config["max_steps"] - config["warmup_steps"])
        return 0.1 + 0.9 * 0.5 * (1 + math.cos(math.pi * min(1.0, fraction)))
    return torch.optim.lr_scheduler.LambdaLR(optimizer, multiplier)


def save_checkpoint(path, model, optimizer, scheduler, scaler, step, batch_rng, run_spec, metrics):
    path = Path(path)
    state = {"model": model.state_dict(), "optimizer": optimizer.state_dict(), "scheduler": scheduler.state_dict(),
             "scaler": scaler.state_dict(), "step": step, "batch_rng": batch_rng.get_state(),
             "torch_rng": torch.get_rng_state(), "cuda_rng": torch.cuda.get_rng_state_all() if torch.cuda.is_available() else [],
             "run_spec": run_spec, "metrics": metrics}
    temporary = path.with_suffix(".tmp")
    torch.save(state, temporary)
    previous = path.with_name("checkpoint-previous.pt")
    if path.exists():
        path.replace(previous)
    temporary.replace(path)


def restore_checkpoint(path, model, optimizer, scheduler, scaler, batch_rng, run_spec, device):
    state = torch.load(path, map_location=device, weights_only=True)
    if state["run_spec"] != run_spec:
        raise ValueError("resume settings, tokenizer, data, code or runtime differ; use a new run directory")
    model.load_state_dict(state["model"])
    optimizer.load_state_dict(state["optimizer"])
    scheduler.load_state_dict(state["scheduler"])
    scaler.load_state_dict(state["scaler"])
    batch_rng.set_state(state["batch_rng"].cpu())
    torch.set_rng_state(state["torch_rng"].cpu())
    if state["cuda_rng"]:
        torch.cuda.set_rng_state_all([value.cpu() for value in state["cuda_rng"]])
    return state["step"], state["metrics"]


def train(model, train_features, validation_features, tokenizer, config, run_directory, run_spec, device):
    run_directory = Path(run_directory)
    pad_id = tokenizer.token_to_id("<|pad|>")
    optimizer = make_optimizer(model, config)
    scheduler = make_scheduler(optimizer, config)
    use_cuda = str(device).startswith("cuda")
    precision = config.get("precision", "fp16")
    if precision not in ("fp16", "bf16"):
        raise ValueError("precision must be fp16 or bf16")
    if use_cuda and precision == "bf16" and not torch.cuda.is_bf16_supported():
        raise ValueError("this GPU does not support bf16; choose fp16 in a new run")
    dtype = torch.bfloat16 if precision == "bf16" else torch.float16
    scaler = torch.amp.GradScaler("cuda", enabled=use_cuda and dtype == torch.float16)
    batch_rng = torch.Generator(device="cpu").manual_seed(config["seed"])
    latest = run_directory / "checkpoint-latest.pt"
    fallback = run_directory / "checkpoint-previous.pt"
    checkpoint = latest if latest.exists() else fallback
    step, metrics = 0, []
    if checkpoint.exists():
        step, metrics = restore_checkpoint(checkpoint, model, optimizer, scheduler, scaler, batch_rng, run_spec, device)
        print(f"Resuming optimizer step {step}", flush=True)
    else:
        baseline = evaluate_loss(model, validation_features, pad_id, device)
        metrics.append({"step": 0, "validation_loss": baseline})
        print(f"Random initialization validation loss: {baseline:.4f}", flush=True)
    model.train()
    started = time.monotonic()
    for step in range(step + 1, config["max_steps"] + 1):
        optimizer.zero_grad(set_to_none=True)
        groups = []
        for _ in range(config["gradient_accumulation_steps"]):
            indices = torch.randint(len(train_features), (config["batch_size"],), generator=batch_rng).tolist()
            groups.append([train_features[index] for index in indices])
        target_count = sum(sum(label != -100 for label in feature["labels"][1:]) for group in groups for feature in group)
        total = 0.0
        for group in groups:
            batch = make_batch(group, pad_id, device)
            with torch.autocast(device_type="cuda" if use_cuda else "cpu", dtype=dtype if use_cuda else torch.bfloat16, enabled=use_cuda):
                value, _ = loss_sum(model, batch)
                loss = value / target_count
            if not torch.isfinite(loss):
                raise RuntimeError("non-finite loss; training stopped")
            total += float(value.detach().item())
            scaler.scale(loss).backward()
        scaler.unscale_(optimizer)
        norm = torch.nn.utils.clip_grad_norm_(model.parameters(), 1.0, error_if_nonfinite=not scaler.is_enabled())
        old_scale = scaler.get_scale()
        scaler.step(optimizer)
        scaler.update()
        if scaler.get_scale() >= old_scale:
            scheduler.step()
        entry = {"step": step, "training_loss": total / target_count, "learning_rate": optimizer.param_groups[0]["lr"]}
        if step % config["eval_every"] == 0 or step == config["max_steps"]:
            entry["validation_loss"] = evaluate_loss(model, validation_features, pad_id, device)
        metrics.append(entry)
        if step % 10 == 0 or "validation_loss" in entry:
            print(json.dumps(entry), flush=True)
        if step % config["save_every"] == 0 or step == config["max_steps"]:
            save_checkpoint(latest, model, optimizer, scheduler, scaler, step, batch_rng, run_spec, metrics)
            write_json(run_directory / "metrics.json", metrics)
    if not latest.exists():
        raise ValueError("no checkpoint produced")
    torch.save(model.state_dict(), run_directory / "model.pt")
    write_json(run_directory / "metrics.json", metrics)
    print(f"Saved full model weights, tokenizer and checkpoints to {run_directory}", flush=True)
    return metrics


@torch.no_grad()
def generate_ir(model, tokenizer, prompt, device, max_new_tokens=1024):
    model.eval()
    prefix = tokenizer.encode(prompt, add_special_tokens=False).ids + [tokenizer.token_to_id("<|ir|>")]
    if len(prefix) >= model.context_length:
        raise ValueError("prompt fills context")
    values = list(prefix)
    output = []
    stopped = False
    for _ in range(min(max_new_tokens, model.context_length - len(prefix))):
        inputs = torch.tensor([values], device=device)
        logits = model(inputs, torch.ones_like(inputs, dtype=torch.bool))[0, -1].clone()
        for token in ("<|pad|>", "<|unk|>", "<|ir|>"):
            logits[tokenizer.token_to_id(token)] = -torch.inf
        token = int(logits.argmax().item())
        if token == tokenizer.token_to_id("<|eos|>"):
            stopped = True
            break
        values.append(token)
        output.append(token)
    return {"generated_ir": tokenizer.decode(output, skip_special_tokens=False),
            "generated_tokens": len(output), "ended_with_eos": stopped,
            "limit_reached": not stopped}
