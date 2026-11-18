from pathlib import Path
import hashlib
import json
import platform
import sys
import tempfile
import unittest

ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(ROOT / 'training'))
from evaluate_generated_ir import evaluate, contract_error, load_predictions
from c_llvm_dataset.compiler import Compiler


class ModelEvaluationTests(unittest.TestCase):
    @classmethod
    def setUpClass(cls):
        expected = json.loads((ROOT / 'artifacts/toolchain.lock.json').read_text())['python_version']
        if platform.python_version() != expected:
            raise unittest.SkipTest(f'native evaluation requires locked Python {expected}; run with python3.14')
        cls.splits = ROOT / 'training/kaggle-results/pilot-001/scratch-pilot-001/splits.json'
        cls.ids = json.loads(cls.splits.read_text())['validation']
        cls.rows = {r['id']: r for r in map(json.loads, (ROOT / 'artifacts/dataset.jsonl').read_text().splitlines())}
        cls.compiler = Compiler(timeout=5)

    def predictions(self):
        return [{'id': name, 'model': 'oracle-control', 'generated_ir': self.rows[name]['completion'],
                 'prompt_sha256': hashlib.sha256(self.rows[name]['prompt'].encode()).hexdigest(),
                 'ended_with_eos': True} for name in self.ids]

    def test_teacher_ir_passes_all_stages(self):
        with tempfile.TemporaryDirectory() as temporary:
            root = Path(temporary)
            path = root / 'predictions.jsonl'
            path.write_text(''.join(json.dumps(row) + '\n' for row in self.predictions()))
            report = evaluate(path, ROOT / 'artifacts', self.splits, root / 'out', self.compiler)
            self.assertEqual(report['counts']['function_success'], 10)
            self.assertEqual(report['counts']['execution_passed'], 10)

    def test_invalid_wrong_result_and_incomplete_are_counted_as_failures(self):
        rows = self.predictions()
        rows[0]['generated_ir'] = 'not LLVM IR\n'
        rows[1]['generated_ir'] = 'define i32 @compute(i32 %x, i32 %y) {\nentry:\n ret i32 0\n}\n'
        rows[2]['ended_with_eos'] = False
        with tempfile.TemporaryDirectory() as temporary:
            root = Path(temporary)
            path = root / 'predictions.jsonl'
            path.write_text(''.join(json.dumps(row) + '\n' for row in rows))
            report = evaluate(path, ROOT / 'artifacts', self.splits, root / 'out', self.compiler)
            self.assertEqual(report['function_count'], 10)
            self.assertEqual(report['counts']['function_success'], 7)
            self.assertEqual(report['counts']['llvm_verified'], 9)
            self.assertEqual(report['counts']['execution_passed'], 8)
            self.assertEqual(report['functions'][1]['stage'], 'execute')
            self.assertIn('counterexample', report['functions'][1])
            self.assertEqual(report['functions'][2]['stage'], 'incomplete_generation')

    def test_executable_subset_excludes_external_calls_and_arbitrary_pointers(self):
        for body in ('call i32 @puts(ptr null)', '%p = inttoptr i64 100 to ptr', 'store i32 1, ptr null'):
            ir = f'define i32 @compute(i32 %x, i32 %y) {{\nentry:\n{body}\nret i32 0\n}}\n'
            self.assertIsNotNone(contract_error(ir, self.compiler.target, 'layout'))

    def test_combined_corpus_probe_and_test_leakage_rejection(self):
        corpus = ROOT / 'corpus-1100-v001'
        all_rows = {r['id']: r for r in map(json.loads, (corpus / 'dataset.jsonl').read_text().splitlines())}
        frozen = json.loads((corpus / 'splits.json').read_text())
        ids = [next(i for i in frozen['validation'] if all_rows[i]['source_dataset'] == source)
               for source in ('base', 'extension')]
        with tempfile.TemporaryDirectory() as temporary:
            root = Path(temporary)
            split = root / 'probe.json'
            split.write_text(json.dumps({'validation': ids}))
            predictions = root / 'predictions.jsonl'
            predictions.write_text(''.join(json.dumps({'id': i, 'model': 'oracle-combined',
                'generated_ir': all_rows[i]['completion'], 'ended_with_eos': True,
                'prompt_sha256': hashlib.sha256(all_rows[i]['prompt'].encode()).hexdigest()}) + '\n' for i in ids))
            report = evaluate(predictions, corpus, split, root / 'out', self.compiler)
            self.assertEqual(report['counts']['function_success'], 2)
            split.write_text(json.dumps({'validation': [frozen['test'][0]]}))
            with self.assertRaisesRegex(ValueError, 'subset of frozen corpus validation'):
                evaluate(predictions, corpus, split, root / 'leak', self.compiler)

    def test_prompt_mismatch_rejected(self):
        rows = self.predictions()
        rows[0]['prompt_sha256'] = 'different'
        with tempfile.TemporaryDirectory() as temporary:
            path = Path(temporary) / 'p.jsonl'
            path.write_text(''.join(json.dumps(row) + '\n' for row in rows))
            with self.assertRaisesRegex(ValueError, 'prompt differs'):
                load_predictions(path, [self.rows[name] for name in self.ids])


if __name__ == '__main__':
    unittest.main()
