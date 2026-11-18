"""Aggregate validation-only compiler evaluation reports without selecting a final winner."""
import argparse
from pathlib import Path
import json


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument('reports', nargs='+', type=Path)
    parser.add_argument('--output', type=Path, required=True)
    args = parser.parse_args()
    reports = [json.loads(path.read_text()) for path in args.reports]
    reference = reports[0]
    for report in reports:
        if report['split'] != 'validation' or report['test_set_evaluated']:
            raise ValueError('only frozen validation comparisons are allowed in this trial')
        if [r['id'] for r in report['functions']] != [r['id'] for r in reference['functions']]:
            raise ValueError('function sets/order differ')
        for field in ('dataset_manifest_sha256','split_file_sha256','toolchain_lock_sha256','evaluator_sha256'):
            if report['provenance'][field] != reference['provenance'][field]:
                raise ValueError('evaluation provenance differs: ' + field)
    table = [{'model': r['model'], 'functions': r['function_count'], **r['counts'],
              'report': str(path)} for r,path in zip(reports,args.reports)]
    maximum = max(r['counts']['execution_passed'] for r in reports)
    leaders = [r['model'] for r in reports if r['counts']['execution_passed'] == maximum]
    result = {'scope': 'exploratory validation comparison; no final model selection', 'table': table,
              'leading_on_finite_execution': leaders, 'leading_execution_success_count': maximum,
              'test_set_evaluated': False,
              'limitations': ['ten validation functions; model sizes, tokenizers, pretraining and training budgets differ',
                              'same raw prompts and finite inputs; greedy single candidate; no repair',
                              'legal LLVM outside the supported pure-integer contract is not executed',
                              'finite execution tests do not prove equivalence']}
    args.output.parent.mkdir(parents=True,exist_ok=True)
    args.output.write_text(json.dumps(result,indent=2)+'\n')
    print(json.dumps(result,indent=2))


if __name__=='__main__':
    main()
