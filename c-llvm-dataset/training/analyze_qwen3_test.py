"""Reproduce the completed frozen-test analysis from immutable inference and native results."""
from pathlib import Path
from collections import Counter
import difflib
import hashlib
import json
import re
import statistics

ROOT = Path(__file__).resolve().parents[1]
RESULT = ROOT / 'training/kaggle-results/qwen3-test-002/qwen3-test110-002'
EVAL = ROOT / 'training/evaluations/qwen3-test-002'


def sha(path):
    return hashlib.sha256(path.read_bytes()).hexdigest()


def body(ir):
    active = False
    lines = []
    for raw in ir.splitlines():
        line = raw.split(';', 1)[0].strip()
        if line.startswith('define '): active = True
        if active and line: lines.append(line)
        if active and line == '}': break
    return '\n'.join(lines)


def main():
    spec = json.loads((RESULT / 'test-spec.json').read_text())
    expected_spec = json.loads((ROOT / 'training/kaggle-qwen3-test-001/test-spec.json').read_text())
    assert spec == expected_spec and spec['do_sample'] is False and spec['use_model_defaults'] is False
    splits = json.loads((ROOT / 'corpus-1100-v001/splits.json').read_text())
    assert json.loads((RESULT / 'splits.json').read_text()) == splits
    rows = {r['id']: r for r in map(json.loads, (ROOT / 'corpus-1100-v001/dataset.jsonl').read_text().splitlines())}
    input_bytes = ''.join(json.dumps({k: rows[i][k] for k in ('id', 'category', 'prompt')})+'\n' for i in splits['test']).encode()
    assert hashlib.sha256(input_bytes).hexdigest() == spec['test_inputs_sha256']
    assert spec['adapter_sha256'] == sha(ROOT / 'training/kaggle-results/qwen3-001/qwen3-4b-corpus1100-001/adapter-best/adapter_model.safetensors')
    predictions = [json.loads(l) for l in (RESULT / 'test-predictions.jsonl').read_text().splitlines()]
    assert [p['id'] for p in predictions] == splits['test']
    pred = {p['id']: p for p in predictions}
    report = json.loads((EVAL / 'report.json').read_text())
    assert report['split'] == 'test' and report['function_count'] == 110 and report['test_set_evaluated']
    assert report['provenance']['predictions_sha256'] == sha(RESULT / 'test-predictions.jsonl')
    log_path = RESULT.parent / 'magicompile-qwen3-test110-002.log'
    events = json.loads(log_path.read_text())
    assert not any('model-specific defaults' in e.get('data', '') for e in events)
    assert any('QWEN3_TEST_GENERATION_COMPLETE' in e.get('data', '') for e in events)
    logged = []
    for e in events:
        text = e.get('data', '').strip()
        if text.startswith('{'):
            try: entry = json.loads(text)
            except json.JSONDecodeError: continue
            if 'worker' in entry and 'id' in entry: logged.append(entry)
    assert len(logged) == 110 and {x['id'] for x in logged} == set(splits['test'])
    categories = {}
    for category in ('arithmetic', 'bitwise', 'branch', 'loop', 'combined'):
        fs = [f for f in report['functions'] if f['category'] == category]
        categories[category] = {'count': len(fs), 'llvm_verified': sum(f['llvm_verified'] for f in fs), 'success': sum(f['function_success'] for f in fs), 'success_rate': sum(f['function_success'] for f in fs)/len(fs)}
    numeric = re.compile(r'(?<![%\w.])-?\d+\b')
    groups = {'only_numeric_literal_differences': [], 'instruction_or_operand_structure_differences': []}
    errors = []
    diff_dir = EVAL / 'teacher-diffs'
    diff_dir.mkdir(exist_ok=True)
    for f in report['functions']:
        if f['function_success']: continue
        teacher, actual = rows[f['id']]['completion'], pred[f['id']]['generated_ir']
        difference = ''.join(difflib.unified_diff(teacher.splitlines(True), actual.splitlines(True), fromfile='teacher.ll', tofile='generated.ll'))
        (diff_dir / (f['id'] + '.diff')).write_text(difference)
        entry = {k: f[k] for k in ('id','category','stage','error')}
        entry.update({k: f[k] for k in ('counterexample','matching_inputs','input_count') if k in f})
        if f['stage'] == 'execute':
            a, b = body(teacher), body(actual)
            kind = 'only_numeric_literal_differences' if a != b and numeric.sub('<N>', a) == numeric.sub('<N>', b) else 'instruction_or_operand_structure_differences'
            groups[kind].append(f['id'])
            entry['diff_classification'] = kind
        errors.append(entry)
    workers = [json.loads((RESULT / f'worker-{i}.json').read_text()) for i in range(2)]
    seconds = [p['generation_seconds'] for p in predictions]
    result = {'status': 'passed', 'test_functions': 110, 'stored_input_cases': sum(f['input_count'] for f in report['functions']),
        'counts': report['counts'], 'rates': report['rates'], 'categories': categories,
        'failure_stages': report['failure_stages'], 'semantic_diff_groups': groups,
        'diff_scope': 'Exact normalized instruction-body comparison, ignoring comments and masking numeric literals; heuristic description, not a formal causal attribution',
        'failures': errors, 'generation': {'mode': 'greedy', 'max_tokens': 4096, 'max_seconds_per_function': 600, 'completed': sum(p['ended_with_eos'] for p in predictions),
            'limit_reasons': dict(Counter(p['limit_reason'] for p in predictions if p['limit_reason'])), 'mean_seconds': statistics.mean(seconds),
            'median_seconds': statistics.median(seconds), 'max_observed_seconds': max(seconds), 'sum_worker_generation_seconds': sum(seconds),
            'log_duration_seconds': max(e.get('time',0) for e in events), 'peak_gpu_allocated_gib_per_worker': [w['peak_gpu_allocated_gib'] for w in workers]},
        'provenance': {'adapter_sha256': spec['adapter_sha256'], 'predictions_sha256': sha(RESULT / 'test-predictions.jsonl'),
            'native_report_sha256': sha(EVAL / 'report.json'), 'log_sha256': sha(log_path), 'analysis_source_sha256': sha(Path(__file__)), 'model_revision': spec['revision']},
        'interpretation_limits': ['Finite 256 inputs per function, not all-input equivalence proof', 'Synthetic uint32 subset, not unrestricted C',
            'Validation probe used sampling and a shorter generation budget; cannot isolate a performance change from its 70% rate',
            'Further development informed by these test errors needs a fresh final test set']}
    (EVAL / 'analysis.json').write_text(json.dumps(result, indent=2)+'\n')
    print(json.dumps({k: result[k] for k in ('counts','categories','failure_stages','generation')}, indent=2))


if __name__ == '__main__': main()
