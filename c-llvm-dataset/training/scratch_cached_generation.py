"""Incremental inference for the trained norm-first ScratchCausalLM; no weight changes."""
import time
import torch
from torch.nn import functional as F


class CachedScratch:
    def __init__(self, model):
        self.model = model.eval()
        self.cache = [None] * len(model.blocks.layers)
        self.position = 0

    @torch.no_grad()
    def forward(self, input_ids):
        model = self.model
        length = input_ids.shape[1]
        if self.position + length > model.context_length:
            raise ValueError('context overflow')
        positions = torch.arange(self.position, self.position + length, device=input_ids.device)
        hidden = model.token_embedding(input_ids) + model.position_embedding(positions)
        for index, layer in enumerate(model.blocks.layers):
            normalized = layer.norm1(hidden)
            q, k, v = F.linear(normalized, layer.self_attn.in_proj_weight, layer.self_attn.in_proj_bias).chunk(3, dim=-1)
            heads = layer.self_attn.num_heads
            def arrange(value):
                return value.reshape(value.shape[0], value.shape[1], heads, -1).transpose(1, 2)
            q, k, v = map(arrange, (q, k, v))
            previous = self.cache[index]
            if previous is not None:
                if length != 1:
                    raise ValueError('only single-token decoding after prefill is supported')
                k = torch.cat((previous[0], k), dim=2)
                v = torch.cat((previous[1], v), dim=2)
            self.cache[index] = (k, v)
            attended = F.scaled_dot_product_attention(q, k, v, dropout_p=0.0, is_causal=previous is None)
            attended = attended.transpose(1, 2).contiguous().reshape(hidden.shape)
            hidden = hidden + layer.self_attn.out_proj(attended)
            hidden = hidden + layer.linear2(layer.activation(layer.linear1(layer.norm2(hidden))))
        self.position += length
        return model.lm_head(model.blocks.norm(hidden))


@torch.no_grad()
def generate(model, tokenizer, prompt, device, max_new_tokens=2560, max_seconds=120):
    prefix = tokenizer.encode(prompt, add_special_tokens=False).ids + [tokenizer.token_to_id('<|ir|>')]
    budget = min(max_new_tokens, model.context_length - len(prefix))
    if budget <= 0:
        raise ValueError('prompt fills context')
    cache = CachedScratch(model)
    inputs = torch.tensor([prefix], device=device)
    output, ended = [], False
    started = time.monotonic()
    for _ in range(budget):
        logits = cache.forward(inputs)[0, -1].clone()
        for name in ('<|pad|>', '<|unk|>', '<|ir|>'):
            logits[tokenizer.token_to_id(name)] = -torch.inf
        token = int(logits.argmax().item())
        if token == tokenizer.token_to_id('<|eos|>'):
            ended = True
            break
        output.append(token)
        inputs = torch.tensor([[token]], device=device)
        if time.monotonic() - started >= max_seconds:
            break
    return {'generated_ir': tokenizer.decode(output, skip_special_tokens=False),
            'generated_tokens': len(output) + int(ended), 'ended_with_eos': ended,
            'limit_reached': not ended, 'generation_budget': budget,
            'generation_seconds': time.monotonic() - started}
