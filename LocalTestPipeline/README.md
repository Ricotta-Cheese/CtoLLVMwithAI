# LocalTestPipeline

`.c` 파일을 선택해 **Ollama의 학습 모델로 LLVM IR을 생성**하고, **Clang으로 컴파일한 원본 C와 실행 결과를 비교**하는 간단한 Python CLI입니다. 모델 다운로드나 학습은 수행하지 않습니다.

## 시작하기

필요한 도구는 Python 3.11 이상, Clang, 실행 중인 Ollama입니다. Python 외부 패키지는 필요 없습니다.

```bash
cd LocalTestPipeline
python3 run.py
```

1. `inputs/`에 있는 `.c` 파일 목록에서 번호를 고릅니다. 하위 폴더의 파일도 표시합니다.
2. 원본 C를 컴파일하고 기준 실행 및 UBSan 검사를 진행합니다.
3. 첫 응답을 기다릴 때는 경과 시간을 표시하고, 응답이 오면 생성되는 IR을 즉시 화면에 이어 출력합니다. 중간 통계가 코드 줄을 끊지 않도록 생성 중에는 코드만 표시하고, 출력 종료 시 총 시간·수신 글자 수를 표시합니다.
4. 생성이 끝나면 모델을 메모리에서 내리고 `/api/ps`로 해제 여부를 확인합니다. 오류나 Ctrl+C 때도 해제를 시도합니다.
5. AI의 원문 IR을 LLVM 검증·컴파일한 뒤, 같은 256개 입력의 결과를 원본 C와 비교합니다.
6. 통과 여부와 첫 불일치 입력을 표시하고 전체 기록을 `outputs/`에 저장합니다.

기본 모델은 `magicompile-qwen3:4b`입니다. **이 모델은 Ollama에 등록되어 실제 IR 생성과 사용 후 메모리 해제까지 확인한 상태**입니다. 재등록 방법은 기존 프로젝트의 [Ollama 준비 방법](../c-llvm-dataset/docs/guides/OLLAMA_LOCAL.md)에 있습니다. Ollama에 등록된 모델은 `ollama list`로 확인하세요. 이 프로그램은 다른 모델로 자동 대체하지 않습니다.

## 코드 넣기

`inputs/add.c` 같은 파일을 추가하세요. 현재 학습 데이터와 비교기는 아래 함수 형식을 지원합니다.

```c
unsigned int compute(unsigned int x, unsigned int y) {
    return x + y;
}
```

- `main()` 없이 `compute` 함수 하나를 작성합니다. 입출력 harness는 프로그램이 붙입니다.
- 부호 없는 32비트 산술·비트 연산·조건 분기·제한된 반복문을 사용합니다.
- 전역 변수, 포인터 연산, 외부 함수 호출은 현재 비교 범위에 포함하지 않습니다. 지원 범위를 벗어난 IR은 실행 전에 거부합니다.
- 입력은 경계값 8개의 전체 조합 64개와 고정 시드 난수 192개입니다. 실행 일치는 이 256개 입력에 대한 검사이며 모든 입력에서의 동등성 증명은 아닙니다.
- 원본 C의 미정의 동작이 UBSan에서 검출되거나 기준 실행끼리 다르면 AI 변환 전에 중단합니다.

## 옵션

```bash
# 번호 선택 없이 실행
python3 run.py --file add.c

# 명시적으로 다른 로컬 모델 사용
python3 run.py --file bitwise.c --model 다른모델명

# 실시간 코드 표시를 끄고 이전처럼 진행 통계만 표시
python3 run.py --file add.c --no-live-output

# 연결 주소와 대기 시간 변경
python3 run.py --file add.c --host http://127.0.0.1:11434 --ai-timeout 900

# 모델 없이 이미 있는 IR의 비교 경로만 확인
python3 run.py --file add.c --ir-file /path/to/module.ll

# 전체 옵션
python3 run.py --help
```

`--ai-timeout`은 HTTP 응답 대기 시간과 스트리밍 중 경과 시간 검사에 사용합니다. 컴파일과 실행에는 별도의 `--tool-timeout`이 적용됩니다. `--ir-file`은 AI 변환을 생략한 비교 모드로, Ollama나 모델 가중치가 필요 없습니다.

기본 프롬프트는 학습 때와 같은 system 문구, O0, `arm64-apple-macosx27.2.0` 타깃입니다. 이 타깃과 다른 환경에서는 실행 비교를 중단합니다. 다른 타깃으로 학습한 모델을 명시적으로 시험할 때만 `--target`을 지정하세요.

## 결과 파일

각 실행은 `outputs/날짜시간_파일명_고유번호/`에 저장됩니다.

| 파일 | 내용 |
|---|---|
| `source.c` | 선택한 C의 복사본 |
| `reference.ll` | Clang이 생성한 기준 LLVM IR |
| `generated.ll` | AI가 생성한 원문 IR 또는 `--ir-file` 복사본 |
| `harness.c` | 동일 입력을 두 실행 파일에 공급하는 harness |
| `inputs.json` | 고정 시드로 생성한 실제 입력 256개 |
| `comparison.json` | 입력별 C/AI 출력과 일치 여부 |
| `report.json` | 단계, 최종 상태, 첫 반례, 모델 메모리 해제 결과 |
| `commands.jsonl` | 컴파일·실행 명령, stdout/stderr 및 종료 코드 |
| `ollama-stream.jsonl` | 수신한 Ollama 원본 이벤트 |
| `reference`, `reference-ubsan`, `generated` | 실제 컴파일한 실행 파일 |

설명문이나 Markdown이 섞인 출력도 자동 수리하지 않고 원문 그대로 검증합니다. 생성 중 끊긴 출력은 실패로 기록합니다. 지원 범위 거부는 계산 결과 불일치와 구분해 보고서에 남깁니다.

종료 코드: `0` 전체 통과, `1` 오류·범위 거부·실행 불일치·미완성 생성·메모리 해제 확인 실패, `130` 사용자 중단입니다. 전체 비교가 맞아도 모델 해제를 확인하지 못했다면 성공으로 표시하지 않습니다.

## 검증

```bash
python3 -m unittest discover -s tests -v
```

테스트에서는 모의 Ollama HTTP 서버와 실제 Clang을 사용해 일치·불일치·잘못된 IR·생성 중 오류·메모리 해제를 확인합니다. 실제 학습 모델의 정확도 측정과는 별개입니다.

API 사용 근거: [Ollama chat](https://docs.ollama.com/api/chat), [모델 해제](https://docs.ollama.com/api/generate), [로드된 모델 확인](https://docs.ollama.com/api/ps).

검증 기록: 모의 Ollama + 실제 Clang 통합 테스트 15개를 통과했습니다. 첫 청크를 표시하기 전에는 서버가 다음 이벤트를 보내지 못하도록 하는 검사로 실시간 표시도 확인했습니다. 번호 선택 CLI를 통한 `add.c` 기준 IR 비교에서도 256/256 입력이 일치했습니다. 실제 학습 모델의 add.c 변환과 메모리 해제를 확인했습니다. 이 첫 변환은 AI가 잘못된 +sha 속성을 생성해 Clang 경고가 발생했고, 엄격 검증 실패로 보존했습니다. 모의 테스트 통과와 실제 모델의 변환 정확도는 구분해야 합니다.

`--not-allow-sha` 엄격 모드에서는 Clang의 종료 코드가 0이어도 stderr 경고가 있으면 검증을 중단합니다. 기본 모드는 아래의 정확한 `+sha` 무시 진단만 허용합니다. 예를 들어 미지원 `+sha` 속성 경고는 **계산 오답이 확인됐다는 뜻이 아니라 실행 비교 전에 진단으로 중단됐다는 뜻**입니다. 해당 속성 자체는 모델 출력 오류이며 원문을 고쳐 통과시키지 않습니다.


## `+sha` 경고가 있을 때

이 모델이 가끔 생성하는 `"target-features"`의 `+sha`는 현재 Apple Clang의 AArch64 타깃에서 인식하지 못하는 속성 이름입니다. `+sha2`, `+sha3`와는 별개의 항목입니다. 기본 동작은 컴파일러가 무시한다고 명시한 `+sha` 진단만 허용하고 실행 비교를 계속하는 것입니다. `--not-allow-sha`를 지정하면 이 경고도 실패로 처리합니다.

**기본 실행**은 정확한 `+sha` 무시 진단만 허용합니다. 엄격 검증은 다음처럼 선택합니다.

```bash
python3 run.py --file add.c

# +sha 경고도 실패로 처리
python3 run.py --file add.c --not-allow-sha
```

이미 생성한 원문을 재생성 없이 확인할 수도 있습니다.

```bash
python3 run.py --file add.c \
  --ir-file outputs/20261116_124927_add_185e4c/generated.ll
```

기본 허용 동작은 IR을 수정하지 않습니다. 기존 `--allow-ignored-sha` 옵션도 호환성을 위해 유지하며 `--not-allow-sha`와 동시에 지정할 수 없습니다. 생성 IR 검증/컴파일 명령이 종료 코드 0이고 stderr의 모든 비어 있지 않은 줄이 정확히 `'+sha' is not a recognized feature for this target (ignoring feature)`일 때만 계속합니다. 원본 C 검사, 실행 파일의 stderr, 다른 경고, 0이 아닌 종료 코드는 허용하지 않습니다. `-w`로 경고 전체를 숨기지도 않습니다.

비교가 일치하면 `경고가 있는 통과`, 보고서 `status: passed_with_warnings`, `strict_success: false`로 표시합니다. 허용한 경고는 `accepted_warnings`와 명령 로그에 보존합니다. 명시한 정책으로 성공한 경우 종료 코드는 0입니다. 기존 엄격 평가 결과와 구분해서 읽으세요.

근본적으로는 모델이 불필요한 CPU 기능 목록을 생성하지 않도록 학습 출력 형식을 정리하는 방법이 있습니다. 예를 들어 다음 버전 데이터에서 타깃별 속성을 결정적으로 붙이는 방식을 검토할 수 있습니다. 기존 기준 데이터나 과거 시험 점수는 수정하지 않습니다.

### 방금 생성한 add.c의 확인 결과

원문 `outputs/20261116_124927_add_185e4c/generated.ll`을 그대로 사용해 기본 256/256 입력의 일치를 확인했습니다. 추가로 경계 입력 64개와 별도 고정 시드 난수 10,000개를 검사해 **10,064/10,064**에서 원본 C O0, C UBSan O1, AI IR O2, Python `(x+y) & 0xffffffff`의 결과가 같았습니다. 보고서는 `outputs/20261116_125237_add_c0fbab/expanded-verification.json`입니다.

본문의 `add i32`에는 `nuw`/`nsw`가 없어 unsigned overflow 시 2^32로 나눈 나머지가 됩니다. 원본 unsigned int 덧셈의 의도와 맞습니다. [LLVM add 명세](https://llvm.org/docs/LangRef.html#add-instruction)를 참고하세요. 이 결과는 이번 덧셈 함수의 확인이며, 모델이 생성하는 모든 함수의 정확도를 뜻하지는 않습니다.

원인 분리 확인용으로 `+sha` 항목만 제거한 복사본 `outputs/20261116_125237_add_c0fbab/generated.without-sha.ll`도 만들었습니다. 함수 본문은 그대로이며 `+sha2`, `+sha3`는 유지했습니다. 이 복사본은 당시 엄격 모드에서도 경고 없이 256/256 입력이 일치했습니다(`outputs/20261116_125434_add_405bb8/report.json`). 원문 결과나 기존 엄격 실패 기록을 덮어쓰지 않았습니다.
