"""Local C → Ollama IR → native executable comparison; Python standard library only."""
from __future__ import annotations
from contextlib import contextmanager
from dataclasses import dataclass
from datetime import datetime
from pathlib import Path
import hashlib
import json
import os
import random
import re
import shutil
import subprocess
import sys
import threading
import time
import urllib.error
import urllib.request
import uuid

from ir_contract import contract_error

ROOT = Path(__file__).resolve().parent
DEFAULT_TARGET = 'arm64-apple-macosx27.2.0'
IGNORED_SHA_DIAGNOSTIC = "'+sha' is not a recognized feature for this target (ignoring feature)"
SYSTEM = 'Translate the provided C function to a complete LLVM IR module for the specified target. Return only LLVM IR, without Markdown fences or explanations.'
HARNESS = '''#include <stdio.h>
#include <limits.h>
_Static_assert(UINT_MAX == 4294967295u, "requires uint32");
extern unsigned int compute(unsigned int, unsigned int);
int main(void) {
    unsigned int x, y;
    while (scanf("%u %u", &x, &y) == 2) printf("%u\\n", compute(x, y));
    return ferror(stdin) || ferror(stdout);
}
'''


class PipelineError(RuntimeError):
    pass


@dataclass
class Config:
    model: str = 'magicompile-qwen3:4b'
    host: str = 'http://127.0.0.1:11434'
    clang: str = 'clang'
    target: str = DEFAULT_TARGET
    ai_timeout: float = 900
    tool_timeout: float = 20
    seed: int = 20261113
    max_tokens: int = 4096
    live_output: bool = True
    allow_ignored_sha: bool = True
    output_root: Path = ROOT / 'outputs'


def write_json(path, value):
    # Atomic reports remain readable if the process is interrupted during a status update.
    temporary = path.with_suffix(path.suffix + '.tmp')
    temporary.write_text(json.dumps(value, ensure_ascii=False, indent=2) + '\n')
    temporary.replace(path)


def test_inputs(seed):
    edges = [0, 1, 2, 15, 16, 2147483647, 2147483648, 4294967295]
    rng = random.Random(seed)
    return [(x, y) for x in edges for y in edges] + [(rng.getrandbits(32), rng.getrandbits(32)) for _ in range(192)]


@contextmanager
def progress(label, emit, state, live_output=False):
    stop = threading.Event()
    started = time.monotonic()
    lock = state.setdefault('_lock', threading.RLock())
    emit(label)
    def heartbeat():
        while not stop.wait(2):
            with lock:
                # Keep partial IR lines intact. Once tokens arrive, the live code is progress.
                if not live_output or not state.get('characters', 0):
                    emit(f"  {label}: {time.monotonic()-started:.0f}초 경과 / {state.get('characters', 0):,}글자 수신")
    thread = threading.Thread(target=heartbeat, daemon=True)
    thread.start()
    try:
        yield
    finally:
        stop.set()
        thread.join(timeout=1)
        with lock:
            if live_output and state.get('characters', 0):
                if state.get('last_character') != '\n':
                    sys.stdout.write('\n'); sys.stdout.flush()
                emit('--- LLVM IR 출력 끝 ---')
            emit(f"[AI 출력 종료] {time.monotonic()-started:.1f}초 / {state.get('characters', 0):,}글자 수신")


class Ollama:
    def __init__(self, config):
        self.config = config

    def request(self, endpoint, body=None, timeout=15):
        data = None if body is None else json.dumps(body).encode()
        request = urllib.request.Request(self.config.host.rstrip('/') + endpoint, data=data,
                                         headers={'Content-Type': 'application/json'})
        try:
            return urllib.request.urlopen(request, timeout=timeout)
        except urllib.error.HTTPError as error:
            try:
                text = error.read().decode(errors='replace')
            finally:
                error.close()
            if error.code == 404:
                raise PipelineError(f'Ollama 모델/경로를 찾지 못했습니다: {self.config.model}. ollama list와 모델 등록 상태를 확인하세요. {text}') from error
            raise PipelineError(f'Ollama HTTP {error.code}: {text}') from error
        except (urllib.error.URLError, TimeoutError, OSError) as error:
            raise PipelineError(f'Ollama 연결 실패: {self.config.host}: {error}') from error

    def check(self):
        with self.request('/api/show', {'model': self.config.model}) as response:
            return json.load(response)

    def generate(self, source, output, events, state, on_chunk=None):
        prompt = ('Compile this C11 function to LLVM IR. Return only the complete LLVM IR module.\n'
                  f'Target: {self.config.target}\nOptimization: O0\n\n{source.rstrip()}\n\n')
        body = {'model': self.config.model, 'messages': [{'role': 'system', 'content': SYSTEM}, {'role': 'user', 'content': prompt}],
                'stream': True, 'keep_alive': 0,
                'options': {'temperature': 0, 'seed': self.config.seed, 'num_ctx': 8192,
                            'num_predict': self.config.max_tokens, 'repeat_penalty': 1}}
        started = time.monotonic()
        final = None
        with output.open('w') as text_file, events.open('w') as event_file:
            with self.request('/api/chat', body, timeout=self.config.ai_timeout) as response:
                for raw in response:
                    if time.monotonic() - started > self.config.ai_timeout:
                        raise PipelineError('AI 변환 대기 시간이 초과됐습니다.')
                    if not raw.strip(): continue
                    event = json.loads(raw)
                    event_file.write(json.dumps(event, ensure_ascii=False)+'\n'); event_file.flush()
                    if event.get('error'): raise PipelineError(f"AI 변환 오류: {event['error']}")
                    content = event.get('message', {}).get('content', '')
                    text_file.write(content); text_file.flush()
                    with state.setdefault('_lock', threading.RLock()):
                        state['characters'] += len(content)
                        if content:
                            state['last_character'] = content[-1]
                            if on_chunk is not None: on_chunk(content)
                    if event.get('done'):
                        final = {k: v for k, v in event.items() if k != 'message'}
                        break
        if final is None: raise PipelineError('AI 응답이 완료 이벤트 없이 끊겼습니다. 부분 IR을 보존했습니다.')
        if final.get('done_reason') != 'stop':
            raise PipelineError(f"AI 생성이 정상 종료되지 않았습니다: {final.get('done_reason', 'unknown')}")
        if not state['characters']: raise PipelineError('AI가 빈 IR을 반환했습니다.')
        return final

    def unload(self):
        with self.request('/api/generate', {'model': self.config.model, 'keep_alive': 0, 'stream': False}) as response:
            result = json.load(response)
            if result.get('error'): raise PipelineError(str(result['error']))
        def canonical(name):
            return name if ':' in name.rsplit('/', 1)[-1] else name + ':latest'
        for attempt in range(6):
            with self.request('/api/ps') as response: listing = json.load(response)
            if not isinstance(listing.get('models'), list):
                raise PipelineError('/api/ps 응답에서 모델 목록을 확인할 수 없습니다.')
            loaded = listing['models']
            if not any(canonical(m.get('name', m.get('model', ''))) == canonical(self.config.model) for m in loaded):
                return {'requested': True, 'confirmed': True}
            if attempt < 5: time.sleep(0.5)
        raise PipelineError('모델 해제 요청 후에도 /api/ps에 모델이 남아 있습니다.')


def run_command(args, work, config, input_text=None, allow_ignored_sha=False):
    started = time.monotonic()
    env = dict(os.environ, LC_ALL='C', LANG='C', UBSAN_OPTIONS='halt_on_error=1:print_stacktrace=0')
    log = {'args': [str(a) for a in args]}
    try:
        completed = subprocess.run(log['args'], cwd=work, input=input_text, capture_output=True, text=True,
                                   timeout=config.tool_timeout, env=env)
        log.update(returncode=completed.returncode, stdout=completed.stdout, stderr=completed.stderr)
        if completed.returncode:
            raise PipelineError(f"{Path(str(args[0])).name} 실패 (종료 코드 {completed.returncode}): {completed.stderr.strip()[:3000]}")
        if completed.stderr.strip():
            lines = [line.strip() for line in completed.stderr.splitlines() if line.strip()]
            if allow_ignored_sha and all(line == IGNORED_SHA_DIAGNOSTIC for line in lines):
                log['accepted_warnings'] = lines
            else:
                raise PipelineError(f"{Path(str(args[0])).name} 경고/진단으로 엄격 검증 중단 (종료 코드 0): {completed.stderr.strip()[:3000]}")
        return completed.stdout
    except subprocess.TimeoutExpired as error:
        log['error'] = 'timeout'
        raise PipelineError(f'{Path(str(args[0])).name}: 컴파일/실행 제한 시간 초과') from error
    except OSError as error:
        log['error'] = str(error)
        raise PipelineError(str(error)) from error
    finally:
        log['seconds'] = time.monotonic() - started
        with (work / 'commands.jsonl').open('a') as stream: stream.write(json.dumps(log)+'\n')


def outputs(text, expected_count):
    try: values = [int(line) for line in text.splitlines()]
    except ValueError as error: raise PipelineError('실행 결과에 정수가 아닌 출력이 있습니다.') from error
    if len(values) != expected_count or any(not 0 <= x <= 4294967295 for x in values):
        raise PipelineError(f'실행 결과 개수/uint32 범위 오류: {len(values)}개, 기대 {expected_count}개')
    return values


def evaluate_ir(work, config, clang, layout, pairs, expected, emit):
    ir = (work / 'generated.ll').read_text()
    emit('[검증] AI 원문 LLVM IR 구조 검사')
    run_command([clang, '-cc1', '-triple', config.target, '-emit-llvm-bc', '-llvm-verify-each',
                 '-Wno-override-module', '-x', 'ir', 'generated.ll', '-o', 'generated.bc'], work, config, allow_ignored_sha=config.allow_ignored_sha)
    error = contract_error(ir, config.target, layout)
    if error: raise PipelineError(f'생성 IR 지원 범위 거부: {error}')
    emit('[컴파일] AI IR → 실행 파일')
    run_command([clang, '-target', config.target, '-O2', '-Werror', '-Wno-override-module', '-Xclang',
                 '-llvm-verify-each', 'generated.ll', 'harness.c', '-o', 'generated'], work, config, allow_ignored_sha=config.allow_ignored_sha)
    emit(f'[실행 비교] AI 실행 파일에 {len(pairs)}개 입력 공급')
    actual = outputs(run_command([work/'generated'], work, config, ''.join(f'{x} {y}\n' for x, y in pairs)), len(pairs))
    comparisons = [{'x': x, 'y': y, 'c_result': a, 'ai_result': b, 'match': a == b}
                   for (x, y), a, b in zip(pairs, expected, actual)]
    write_json(work / 'comparison.json', comparisons)
    failed = [x for x in comparisons if not x['match']]
    return {'input_count': len(pairs), 'matching_inputs': len(pairs)-len(failed), 'mismatch_count': len(failed),
            'first_mismatch': failed[0] if failed else None, 'all_equal': not failed}


def run_pipeline(source_path, config, ir_file=None, emit=None):
    if emit is None:
        emit = lambda message: print(message, flush=True)
    source_path = source_path.resolve()
    config.output_root = config.output_root.resolve()
    work = config.output_root / (datetime.now().astimezone().strftime('%Y%m%d_%H%M%S') + '_' + source_path.stem + '_' + uuid.uuid4().hex[:6])
    work.mkdir(parents=True)
    report = {'status': 'running', 'success': False, 'strict_success': False, 'stage': 'prepare', 'source': str(source_path), 'model': None if ir_file else config.model,
              'host': config.host, 'target': config.target, 'seed': config.seed, 'mode': 'existing_ir' if ir_file else 'ollama',
              'output_directory': str(work), 'warning_policy': 'allow_ignored_sha_only' if config.allow_ignored_sha else 'strict', 'memory_release': {'requested': False, 'confirmed': False},
              'generation_policy': 'existing IR; no AI conversion' if ir_file else 'one raw greedy candidate; no repairs',
              'generation_settings': {'temperature': 0, 'max_tokens': config.max_tokens, 'context': 8192, 'repeat_penalty': 1},
              'comparison_scope': 'finite uint32 input tests, not a proof'}
    client = Ollama(config)
    attempted_ai = False
    started = time.monotonic()
    try:
        source = source_path.read_text()
        (work/'source.c').write_text(source)
        report['source_sha256'] = hashlib.sha256(source.encode()).hexdigest()
        (work/'harness.c').write_text(HARNESS)
        clang = shutil.which(config.clang)
        if not clang: raise PipelineError(f'Clang을 찾지 못했습니다: {config.clang}')
        report['clang_version'] = run_command([clang,'--version'], work, config).strip()
        report['stage'] = 'reference_compile'
        emit('[기준 준비] 원본 C 컴파일 및 지원 범위 확인')
        flags = [clang, '-target', config.target, '-std=c11', '-Wall', '-Wextra', '-Werror']
        run_command(flags + ['-O0','-fno-ident','-fno-discard-value-names','-S','-emit-llvm','-Xclang','-llvm-verify-each',
                             'source.c','-o','reference.ll'], work, config)
        reference = (work/'reference.ll').read_text()
        native_probe = run_command([clang,'-S','-emit-llvm','-x','c','-','-o','-'], work, config,
                                   'unsigned int compute(unsigned int x, unsigned int y) { return x+y; }\n')
        native_target = re.search(r'^target triple = "([^"]+)"', native_probe, re.M)[1]
        if native_target != config.target: raise PipelineError(f'실행 타깃 불일치: 현재 {native_target}, 요청 {config.target}')
        layout = re.search(r'^target datalayout = "([^"]+)"', reference, re.M)[1]
        scope_error = contract_error(reference, config.target, layout)
        if scope_error: raise PipelineError(f'원본 C 지원 범위 거부: {scope_error}')
        run_command(flags + ['-O0','source.c','harness.c','-o','reference'], work, config)
        run_command(flags + ['-O1','-fsanitize=undefined','-fno-sanitize-recover=all','source.c','harness.c','-o','reference-ubsan'], work, config)
        pairs = test_inputs(config.seed)
        write_json(work/'inputs.json', [{'x': x, 'y': y} for x, y in pairs])
        input_text = ''.join(f'{x} {y}\n' for x, y in pairs)
        report['stage'] = 'reference_execute'
        emit(f'[기준 실행] 원본 C와 UBSan 실행 파일에 {len(pairs)}개 입력 공급')
        expected = outputs(run_command([work/'reference'], work, config, input_text), len(pairs))
        sanitized = outputs(run_command([work/'reference-ubsan'], work, config, input_text), len(pairs))
        if expected != sanitized: raise PipelineError('원본 C의 O0 실행과 UBSan O1 실행 결과가 다릅니다.')
        if ir_file:
            emit('[IR 입력] 기존 IR 파일 사용 — AI 변환 생략')
            shutil.copyfile(ir_file, work/'generated.ll')
        else:
            report['stage'] = 'model_check'
            emit(f'[모델 확인] {config.model}')
            show = client.check()
            report['model_details'] = show.get('details', {})
            report['stage'] = 'ai_generation'
            attempted_ai = True
            state = {'characters': 0}
            def show_chunk(content):
                if not state.get('display_started'):
                    emit('--- 생성 중인 LLVM IR ---')
                    state['display_started'] = True
                sys.stdout.write(content)
                sys.stdout.flush()
            try:
                with progress('[AI 변환 중]', emit, state, live_output=config.live_output):
                    report['generation'] = client.generate(source, work/'generated.ll', work/'ollama-stream.jsonl', state,
                                                           on_chunk=show_chunk if config.live_output else None)
            finally:
                emit('[메모리 해제] 사용한 Ollama 모델 해제 및 확인')
                report['memory_release']['requested'] = True
                try:
                    report['memory_release'] = client.unload()
                    emit('[메모리 해제 완료] 로드된 모델 목록에서 제거 확인')
                except Exception as error:
                    report['memory_release']['error'] = str(error)
                    emit(f'[메모리 해제 확인 실패] {error}')
        report['stage'] = 'generated_evaluation'
        report['comparison'] = evaluate_ir(work, config, clang, layout, pairs, expected, emit)
        report['generated_ir_sha256'] = hashlib.sha256((work/'generated.ll').read_bytes()).hexdigest()
        report['success'] = report['comparison']['all_equal'] and (not attempted_ai or report['memory_release']['confirmed'])
        report['status'] = 'passed' if report['success'] else 'failed'
        report['stage'] = 'complete'
    except KeyboardInterrupt:
        report.update(status='interrupted', error='사용자가 중단했습니다.')
        emit('[중단] 현재까지의 파일을 보존합니다.')
    except Exception as error:
        report.update(status='failed', error=str(error))
        emit(f'[실패] {error}')
    finally:
        warnings = []
        if (work/'commands.jsonl').exists():
            for line in (work/'commands.jsonl').read_text().splitlines():
                try:
                    warnings.extend(json.loads(line).get('accepted_warnings', []))
                except json.JSONDecodeError:
                    # Preserve interrupted runs even if the final command log line was cut short.
                    report['command_log_incomplete'] = True
        report['accepted_warnings'] = warnings
        report['strict_success'] = report['success'] and not warnings
        if report['success'] and warnings:
            report['status'] = 'passed_with_warnings'
            emit('[경고] Clang이 무시한 +sha 속성 진단만 허용했습니다. 엄격 검증 통과와 구분합니다.')
        report['seconds'] = time.monotonic() - started
        write_json(work/'report.json', report)
    label = '경고가 있는 통과' if report['status'] == 'passed_with_warnings' else '통과' if report['success'] else '중단' if report['status'] == 'interrupted' else '실패'
    emit(f'[최종 결과] {label}')
    emit(f'[결과 저장] {work}')
    if 'comparison' in report:
        c = report['comparison']
        emit(f"[비교 결과] {c['matching_inputs']}/{c['input_count']} 입력 일치")
        if c['first_mismatch']: emit(f"[첫 반례] {c['first_mismatch']}")
    return report
