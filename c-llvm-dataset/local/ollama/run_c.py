"""Send a C file to the local fine-tuned Ollama model using the training prompt format."""
from pathlib import Path
import argparse
import json
import sys
import urllib.error
import urllib.request

ROOT = Path(__file__).resolve().parents[2]


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument('source', type=Path, help='C file containing unsigned int compute(unsigned int x, unsigned int y)')
    parser.add_argument('-o', '--output', type=Path)
    parser.add_argument('--model', default='magicompile-qwen3:4b')
    parser.add_argument('--metadata', type=Path)
    args = parser.parse_args()
    target = json.loads((ROOT / 'corpus-1100-v001/toolchain.lock.json').read_text())['target']
    prompt = ('Compile this C11 function to LLVM IR. Return only the complete LLVM IR module.\n'
              f'Target: {target}\nOptimization: O0\n\n' + args.source.read_text().rstrip() + '\n\n')
    body = {'model': args.model, 'messages': [{'role': 'user', 'content': prompt}], 'stream': False,
            'options': {'temperature': 0, 'seed': 20261113, 'num_ctx': 8192, 'num_predict': 4096, 'repeat_penalty': 1}}
    request = urllib.request.Request('http://127.0.0.1:11434/api/chat', data=json.dumps(body).encode(), headers={'Content-Type': 'application/json'})
    try:
        with urllib.request.urlopen(request, timeout=900) as response:
            result = json.load(response)
    except urllib.error.HTTPError as error:
        raise SystemExit(error.read().decode())
    content = result['message']['content']
    if args.output: args.output.write_text(content)
    else: sys.stdout.write(content + ('' if content.endswith('\n') else '\n'))
    if args.metadata:
        args.metadata.write_text(json.dumps({k: v for k, v in result.items() if k != 'message'}, indent=2)+'\n')
    if result.get('done_reason') == 'length':
        print('Output reached the token limit; IR may be incomplete.', file=sys.stderr)
        return 2
    return 0


if __name__ == '__main__': raise SystemExit(main())
