"""Native LLVM and finite execution evaluation for frozen validation predictions."""
from __future__ import annotations
import argparse
from collections import Counter
import hashlib
import json
from pathlib import Path
import re
import sys
import tempfile

ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(ROOT / 'src'))
from c_llvm_dataset.compiler import Compiler, ToolFailure, HARNESS
from c_llvm_dataset.model import canonical_json
from c_llvm_dataset.pipeline import verify_integrity, check_lock

NAME = r'%[-a-zA-Z$._0-9]+'
VALUE = rf'(?:{NAME}|-?\d+)'


def contract_error(ir, target, layout):
    """Restrict executable candidates to the dataset's pure integer, local-stack subset."""
    triples = re.findall(r'^target triple\s*=\s*"([^"]+)"', ir, re.M)
    layouts = re.findall(r'^target datalayout\s*=\s*"([^"]+)"', ir, re.M)
    if len(triples) > 1 or (triples and triples[0] != target):
        return 'target_triple_mismatch'
    if len(layouts) > 1 or (layouts and layouts[0] != layout):
        return 'target_datalayout_mismatch'
    definitions = re.findall(r'^define\b[^\{]*\{', ir, re.M)
    if len(definitions) != 1:
        return 'expected_one_function_definition'
    header = definitions[0]
    if not re.search(r'\bi32\s+@compute\s*\(', header):
        return 'expected_compute_i32_return'
    parameters = re.search(r'@compute\s*\((.*?)\)', header, re.S)
    if not parameters:
        return 'invalid_function_parameters'
    values = parameters[1].split(',')
    if len(values) != 2 or any(not re.fullmatch(rf'\s*i32\s+(?:noundef\s+)?{NAME}\s*', value) for value in values):
        return 'expected_two_i32_parameters'
    active = False
    done = False
    allocated = set()
    integer_ops = {'add','sub','mul','and','or','xor','shl','lshr','ashr','udiv','sdiv','urem','srem',
                   'icmp','zext','sext','trunc','select','phi','freeze'}
    for raw_line in ir.splitlines():
        line = raw_line.split(';', 1)[0].strip()
        if not line:
            continue
        if not active:
            if line.startswith('define '):
                active = True
                if '{' not in line or line.rsplit('{', 1)[1].strip():
                    return 'multiline_or_inline_function_body_not_supported'
                continue
            if line.startswith(('source_filename ', 'target ', 'attributes ', '!')):
                continue
            return 'external_or_global_or_unsupported_module_directive'
        if line == '}':
            active = False
            done = True
            continue
        if done:
            return 'unexpected_second_function'
        if re.fullmatch(r'[-a-zA-Z$._0-9]+:', line):
            continue
        if '@' in line or 'asm' in line:
            return 'external_reference_or_assembly'
        # Ignore instruction metadata attachments, which cannot introduce executable calls here.
        instruction = re.split(r',\s*!', line, maxsplit=1)[0]
        assigned = re.fullmatch(rf'({NAME})\s*=\s*(.+)', instruction)
        operation = assigned[2] if assigned else instruction
        opcode = operation.split()[0]
        if any(int(bits) not in (1, 8, 16, 32, 64) for bits in re.findall(r'(?<![%\w.])i(\d+)\b', operation)):
            return 'unsupported_integer_width'
        if opcode == 'alloca':
            if not assigned or not re.fullmatch(r'alloca i32(?:, align (?:1|2|4|8|16|32|64))?', operation):
                return 'only_fixed_i32_stack_allocation_supported'
            allocated.add(assigned[1])
        elif opcode == 'load':
            match = re.fullmatch(rf'load i32, ptr ({NAME})(?:, align (?:1|2|4))?', operation)
            if not assigned or not match or match[1] not in allocated:
                return 'load_must_reference_local_i32_allocation'
        elif opcode == 'store':
            match = re.fullmatch(rf'store i32 {VALUE}, ptr ({NAME})(?:, align (?:1|2|4))?', operation)
            if assigned or not match or match[1] not in allocated:
                return 'store_must_reference_local_i32_allocation'
        elif opcode in integer_ops:
            if not assigned or re.search(r'(?<![%\w.])ptr\b|\b(?:undef|poison)\b', operation):
                return 'only_defined_integer_operations_supported'
        elif opcode == 'ret':
            if assigned or not re.fullmatch(rf'ret i32 {VALUE}', operation):
                return 'expected_i32_return_value'
        elif opcode in {'br', 'unreachable'}:
            if assigned:
                return 'invalid_terminator'
        else:
            return 'unsupported_instruction_' + opcode
    return None if done and not active else 'incomplete_function'


def load_predictions(path, expected_rows):
    values = [json.loads(line) for line in path.read_text().splitlines() if line.strip()]
    if len(values) != len(expected_rows) or len({v['id'] for v in values}) != len(values):
        raise ValueError('prediction count or duplicate IDs mismatch')
    by_id = {v['id']: v for v in values}
    if set(by_id) != {r['id'] for r in expected_rows}:
        raise ValueError('predictions must cover exactly the frozen validation set')
    for row in expected_rows:
        if by_id[row['id']]['prompt_sha256'] != hashlib.sha256(row['prompt'].encode()).hexdigest():
            raise ValueError('prediction prompt differs from the frozen input')
    return by_id


def evaluate(predictions_path, artifact_root, split_file, output, compiler, split_name="validation"):
    if split_name not in ('validation', 'test'):
        raise ValueError('only frozen validation or test evaluation is supported')
    corpus_config = json.loads((artifact_root / 'config.json').read_text())
    combined = corpus_config.get('kind') == 'combined-corpus'
    if combined:
        from c_llvm_dataset.corpus import verify_corpus
        verify_corpus(artifact_root)
        # Resolve original per-function execution inputs from the verified source artifacts.
        source_roots = {}
        for name, meta in corpus_config['inputs'].items():
            directory = Path(meta['path'])
            if not directory.is_absolute():
                directory = ROOT / directory
            verify_integrity(directory)
            if hashlib.sha256((directory / 'dataset.jsonl').read_bytes()).hexdigest() != meta['dataset_sha256']:
                raise ValueError('source dataset differs from corpus provenance')
            source_roots[name] = directory
    else:
        verify_integrity(artifact_root)
    check_lock(compiler, artifact_root / 'toolchain.lock.json')
    splits = json.loads(split_file.read_text())
    rows = [json.loads(line) for line in (artifact_root / 'dataset.jsonl').read_text().splitlines()]
    by_id = {row['id']: row for row in rows}
    if combined:
        frozen = json.loads((artifact_root / 'splits.json').read_text())[split_name]
        if not set(splits[split_name]) <= set(frozen):
            raise ValueError(f'probe must be a subset of frozen corpus {split_name}')
        if split_name == 'test' and (len(splits['test']) != len(set(splits['test'])) or set(splits['test']) != set(frozen)):
            raise ValueError('test evaluation must cover the entire frozen test split')
    selected = [by_id[name] for name in splits[split_name]]
    def sample_directory(row):
        base = source_roots[row['source_dataset']] if combined else artifact_root
        return base / row['sample_path']
    predictions = load_predictions(predictions_path, selected)
    example_ir = (sample_directory(selected[0]) / 'module.ll').read_text()
    layout = re.search(r'^target datalayout = "([^"]+)"', example_ir, re.M)[1]
    output.mkdir(parents=True, exist_ok=False)
    details = []
    for row in selected:
        predicted = predictions[row['id']]
        ir = predicted['generated_ir']
        directory = output / row['id']
        directory.mkdir()
        (directory / 'generated.ll').write_text(ir)
        result = {'id': row['id'], 'category': row['category'], 'completed': predicted['ended_with_eos'],
                  'llvm_verified': False, 'contract_passed': False, 'compiled': False,
                  'execution_passed': False, 'function_success': False,
                  'stage': 'llvm_verify', 'generated_ir_sha256': hashlib.sha256(ir.encode()).hexdigest()}
        records = json.loads((sample_directory(row) / 'inputs.json').read_text())
        result['input_count'] = len(records)
        with tempfile.TemporaryDirectory(prefix='model-ir-eval-') as temporary:
            work = Path(temporary)
            (work / 'module.ll').write_text(ir)
            try:
                # Missing target directives are legal LLVM IR. Infer the locked native target;
                # check any explicitly supplied target/layout separately in the contract stage.
                compiler.run([compiler.clang, '-cc1', '-triple', compiler.target,
                              '-emit-llvm-bc', '-llvm-verify-each', '-Wno-override-module',
                              '-x', 'ir', 'module.ll', '-o', 'verified.bc'], work)
                result['llvm_verified'] = True
                result['stage'] = 'contract'
                error = contract_error(ir, compiler.target, layout)
                if error:
                    raise ToolFailure(error)
                result['contract_passed'] = True
                result['stage'] = 'compile'
                (work / 'harness.c').write_text(HARNESS)
                executable = work / 'generated'
                compiler.run([compiler.clang, '-target', compiler.target, '-O2', '-Werror', '-Wno-override-module',
                              '-Xclang', '-llvm-verify-each', 'module.ll', 'harness.c', '-o', str(executable)], work)
                result['compiled'] = True
                result['stage'] = 'execute'
                inputs = ''.join(f"{r['x']} {r['y']}\n" for r in records)
                actual_text = compiler.run([str(executable)], work, inputs)
                try:
                    actual = [int(value) for value in actual_text.splitlines()]
                except ValueError as error:
                    raise ToolFailure('output_not_integer') from error
                expected = [r['expected'] for r in records]
                result['output_count'] = len(actual)
                result['matching_inputs'] = sum(a == b for a, b in zip(actual, expected))
                if actual != expected:
                    first = next((i for i, (a, b) in enumerate(zip(actual, expected)) if a != b), min(len(actual), len(expected)))
                    result['counterexample'] = {'input': {key: records[first][key] for key in ('x','y')} if first < len(records) else None,
                                               'expected': expected[first] if first < len(expected) else None,
                                               'actual': actual[first] if first < len(actual) else None}
                    raise ToolFailure('execution_output_mismatch')
                result['execution_passed'] = True
                result['function_success'] = bool(result['completed'])
                result['stage'] = 'passed' if result['completed'] else 'incomplete_generation'
            except ToolFailure as error:
                result['error'] = str(error)
        (directory / 'result.json').write_text(canonical_json(result))
        details.append(result)
    counts = {key: sum(bool(row[key]) for row in details) for key in
              ('completed','llvm_verified','contract_passed','compiled','execution_passed','function_success')}
    report = {'model': next(iter(predictions.values()))['model'], 'split': split_name,
              'function_count': len(details), 'test_set_evaluated': split_name == 'test',
              'counts': counts, 'rates': {key: value / len(details) for key, value in counts.items()},
              'denominator': f'all selected frozen {split_name} functions; failures retained',
              'execution_scope': 'pure integer/local-i32-stack supported subset; finite stored input tests',
              'target': compiler.target, 'compiler_version': compiler.identity()['compiler_version'],
              'generation_policy': 'one raw greedy candidate; completion required for end-to-end success; no repair',
              'failure_stages': dict(Counter(row['stage'] for row in details)), 'functions': details}
    report['provenance'] = {
        'dataset_manifest_sha256': hashlib.sha256((artifact_root / 'manifest.json').read_bytes()).hexdigest(),
        'predictions_sha256': hashlib.sha256(predictions_path.read_bytes()).hexdigest(),
        'split_file_sha256': hashlib.sha256(split_file.read_bytes()).hexdigest(),
        'evaluator_sha256': hashlib.sha256(Path(__file__).read_bytes()).hexdigest(),
        'toolchain_lock_sha256': hashlib.sha256((artifact_root / 'toolchain.lock.json').read_bytes()).hexdigest(),
    }
    (output / 'report.json').write_text(canonical_json(report))
    return report


if __name__ == '__main__':
    parser = argparse.ArgumentParser()
    parser.add_argument('predictions', type=Path)
    parser.add_argument('--artifacts', type=Path, default=ROOT / 'artifacts')
    parser.add_argument('--splits', type=Path, default=ROOT / 'training/kaggle-results/pilot-001/scratch-pilot-001/splits.json')
    parser.add_argument('--split', choices=('validation','test'), default='validation')
    parser.add_argument('--output', type=Path, required=True)
    args = parser.parse_args()
    report = evaluate(args.predictions, args.artifacts, args.splits, args.output, Compiler(timeout=5), args.split)
    print(json.dumps({key: report[key] for key in ('model','function_count','counts','rates','failure_stages')}, indent=2))
