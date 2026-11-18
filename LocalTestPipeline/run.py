#!/usr/bin/env python3
"""Interactive .c selection for LocalTestPipeline."""
from pathlib import Path
import argparse
from pipeline import Config, ROOT, run_pipeline


def choose_file(folder, name=None):
    folder.mkdir(parents=True, exist_ok=True)
    files = sorted(p for p in folder.rglob('*.c') if p.is_file() and not p.is_symlink())
    if not files: raise ValueError(f'{folder}에 .c 파일을 추가하세요.')
    if name:
        selected = (folder / name).resolve()
        if not selected.is_relative_to(folder.resolve()) or selected not in [p.resolve() for p in files]:
            raise ValueError('--file은 inputs 폴더 안의 .c 파일이어야 합니다.')
        return selected
    print('\nC 파일 선택:')
    for i, path in enumerate(files, 1): print(f'  {i}. {path.relative_to(folder)}')
    while True:
        answer = input('번호 선택 (q: 종료): ').strip()
        if answer.lower() == 'q': return None
        try:
            index = int(answer)
            if 1 <= index <= len(files): return files[index-1]
        except ValueError: pass
        print('목록에 있는 번호를 입력하세요.')


def main():
    parser = argparse.ArgumentParser(description='C 파일 → Ollama LLVM IR → Clang 실행 결과 비교')
    parser.add_argument('--file', help='inputs 기준 .c 파일 경로; 생략하면 번호 선택')
    parser.add_argument('--model', default=Config.model)
    parser.add_argument('--host', default=Config.host)
    parser.add_argument('--clang', default=Config.clang)
    parser.add_argument('--target', default=Config.target)
    parser.add_argument('--ai-timeout', type=float, default=Config.ai_timeout)
    parser.add_argument('--tool-timeout', type=float, default=Config.tool_timeout)
    parser.add_argument('--seed', type=int, default=Config.seed)
    parser.add_argument('--max-tokens', type=int, default=Config.max_tokens)
    parser.add_argument('--no-live-output', dest='live_output', action='store_false', help='생성 IR 실시간 표시를 끄고 진행 통계만 표시')
    sha_policy = parser.add_mutually_exclusive_group()
    sha_policy.add_argument('--not-allow-sha', dest='allow_ignored_sha', action='store_false', help='+sha 경고도 실패로 처리하는 엄격 검증')
    sha_policy.add_argument('--allow-ignored-sha', dest='allow_ignored_sha', action='store_true', help='+sha 무시 진단만 허용 (기본값; 기존 명령 호환)')
    parser.set_defaults(allow_ignored_sha=Config.allow_ignored_sha)
    parser.add_argument('--ir-file', type=Path, help='Ollama 없이 기존 LLVM IR 비교')
    args = parser.parse_args()
    if min(args.ai_timeout, args.tool_timeout, args.max_tokens) <= 0: parser.error('시간과 토큰 제한은 양수여야 합니다.')
    try:
        source = choose_file(ROOT/'inputs', args.file)
        if source is None: return 0
        print(f'선택한 코드: {source.name}')
        print(source.read_text())
        config = Config(**{k: v for k, v in vars(args).items() if k not in ('file','ir_file')})
        report = run_pipeline(source, config, args.ir_file)
        return 130 if report['status'] == 'interrupted' else (0 if report['success'] else 1)
    except (ValueError, OSError, EOFError) as error:
        print(f'[입력 오류] {error}'); return 1
    except KeyboardInterrupt:
        print('\n종료합니다.'); return 130


if __name__ == '__main__': raise SystemExit(main())
