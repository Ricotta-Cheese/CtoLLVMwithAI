# C → LLVM IR 파일럿 데이터셋

외부 Python 패키지 없이 C–LLVM IR 쌍을 생성하고 실행 결과를 검증하는 파이프라인입니다. 현재 학습 코퍼스는 검증된 1,100쌍이며, 주력 모델은 Qwen3-4B-Instruct-2507입니다. [현재 Kaggle 학습 설정과 실행 방법](docs/old_docs/QWEN3_KAGGLE.md)을 확인하세요. 모델 학습용 대규모 데이터 생성에 앞서 생성·검증 과정의 정확성을 확인하는 용도입니다.

데이터셋을 새로 생성하거나 확장하기 전에는 [데이터셋 생성 전 확인 지침](docs/DATASET_GENERATION_GUIDELINES.md)을 확인하세요. 환경 잠금, 생성 범위, 실패 처리, 재현성 확인, 학습 데이터 분리 기준을 담았습니다.

Colab에서 사전학습 가중치 없이 토크나이저와 모델을 직접 학습하려면 [처음부터 학습하는 방법](docs/old_docs/COLAB_FROM_SCRATCH.md)을 보세요. [학습 노트북](notebooks/train_from_scratch_colab.ipynb)을 보존했습니다. 이전 가중치와 업로드 ZIP은 Qwen3 전환 과정에서 정리했습니다.

Kaggle에서는 T4 한 개로 20 step 학습과 10 step 체크포인트 재개를 완료했습니다. 실제 측정값과 실행 관리는 [Kaggle 시험 학습 결과](docs/old_docs/KAGGLE_SMOKE_RESULT.md)에 기록했습니다.

기존 100쌍으로 첫 200 step 학습도 완료했습니다. 최저 검증 loss는 175 step의 0.89831이며, [첫 학습 결과와 학습 곡선](docs/old_docs/KAGGLE_FIRST_TRAINING_RESULT.md)에 설정·측정값·생성 미리보기의 한계를 기록했습니다.

Qwen2.5-Coder-1.5B도 QLoRA로 60 step 학습해 비교했습니다. 같은 검증 함수 10개에서 미세조정 Qwen은 LLVM 검증·컴파일 4개, 모든 평가 입력의 동작 일치 2개를 통과했습니다. 직접 만든 모델과 학습 전 Qwen은 LLVM 검증 통과가 0개였습니다. [Qwen 비교 결과](docs/old_docs/QWEN_COMPARISON.md)에 함수별 오류와 평가 한계를 기록했으며, 시험 세트는 아직 사용하지 않았습니다.

## 현재 실행 환경과 범위

- 현재 공식 산출물은 **macOS ARM64 / Apple Clang 21**에서 생성·실행 검증한 데이터입니다. 정확한 타깃은 `toolchain.lock.json`에 기록합니다.
- Linux/Colab에서 실행 검증한 데이터는 아닙니다. Colab에서 텍스트 학습 자료로 사용할 수 있지만, 이 IR의 네이티브 실행 검증에는 현재 타깃과 호환되는 환경이 필요합니다.
- 별도 Linux 데이터셋을 만들 때에는 Linux Clang으로 새로운 환경 잠금을 생성합니다. 같은 시드로 C 코드를 재생성할 수 있지만 타깃·도구가 다르면 IR의 바이트 일치는 보장하지 않습니다. 서로 다른 프로필을 섞지 마세요.
- Python 3.11 이상과 Clang이 필요합니다. `opt`와 `llvm-as` 대신 Clang의 LLVM 파서 및 내장 verifier(`-cc1 -llvm-verify-each`)를 사용합니다. 시작할 때 올바르지 않은 SSA 지배 관계를 실제로 거부하는지 검사합니다.

## 데이터 구성

현재 [통합 코퍼스](corpus-1100-v001/dataset.jsonl)는 **1,100쌍**입니다. [기본 파일럿](artifacts/dataset.jsonl) 100쌍과 [확장 데이터](artifacts-ext001/dataset.jsonl) 1,000쌍을 합쳤습니다. [분할 기록](corpus-1100-v001/splits.json)에는 학습 880쌍, 검증 110쌍, 시험 110쌍이 있습니다.

| 분류 | 기본 파일럿 | 확장 | 통합 코퍼스 | 내용 |
|---|---:|---:|---:|---|
| arithmetic | 20 | 200 | 220 | 부호 없는 32비트 덧셈·뺄셈·곱셈 |
| bitwise | 20 | 200 | 220 | AND·OR·XOR·상수 시프트 |
| branch | 20 | 200 | 220 | 조건 분기와 계산 |
| loop | 20 | 200 | 220 | 0~16회 반복 |
| combined | 20 | 200 | 220 | 반복문 내부 분기 및 반복문 뒤의 분기 |
| **합계** | **100** | **1,000** | **1,100** | |

기본 파일럿의 시드 `20261113`과 분류별 수량은 [config.json](config.json)에, 확장 설정은 [config-ext001.json](config-ext001.json)에 기록되어 있습니다.

무작위 C 코드 생성기를 작성하는 데 [Claude Sonnet 5.5](https://www.anthropic.com/claude/sonnet)를 사용했습니다. 데이터셋의 C 함수는 저장소의 Python 생성기가 고정 시드로 재현할 수 있게 생성합니다.

### 기본 파일럿의 생성 규칙

함수 서명은 `unsigned int compute(unsigned int x, unsigned int y)`이며 `unsigned int`가 정확히 32비트인지 C 정적 단언으로 검사합니다. 모든 상수는 `u` 접미사를 사용하고, 각 연산의 부호 없는 정수 wraparound를 Python 해석기에서도 재현합니다. 시프트는 0~31의 상수이고, 반복 횟수는 `(x & 15u) + (y & 1u)`이므로 최대 16회입니다. 포인터·배열·실수·재귀·외부 함수·나눗셈은 생성하지 않습니다.

상수와 변수명만 다른 변형을 묶는 보수적인 구조 해시를 사용하며, 기본 파일럿 100개는 구조 해시 기준으로도 중복이 없습니다. 통합 코퍼스는 이 구조 해시를 기준으로 학습·검증·시험을 분리합니다.

## 실행

프로젝트 디렉토리에서 실행합니다. 설치 및 `pip install`은 필요하지 않습니다.

```bash
# 도구, 내장 LLVM verifier의 오류 검출, UBSan 실행 확인
python3 run_pipeline.py doctor

# 최초 환경 잠금 생성 — 기존 잠금을 덮어쓰지 않음
python3 run_pipeline.py doctor --write-lock

# 환경 잠금과 현재 도구가 일치할 때만 생성
python3 run_pipeline.py generate --output artifacts

# 저장된 파일 해시, 행 수, C/IR/AST/기대값의 일치 여부 검사
python3 run_pipeline.py validate artifacts

# 저장된 IR을 다시 검증하고 모든 실행 비교까지 재수행
python3 run_pipeline.py validate artifacts --execute

# 다른 경로에 완전히 새로 생성해 바이트 단위 재현성 확인
python3 run_pipeline.py generate --output /tmp/c-llvm-rerun
python3 run_pipeline.py compare artifacts /tmp/c-llvm-rerun

# 검증기 자체 테스트
python3 -m unittest discover -s tests -v
```

`artifacts`가 이미 있으면 생성 명령은 실패합니다. 새 출력 경로를 지정하세요. `doctor --write-lock`도 기존 파일을 덮어쓰지 않습니다. 다른 Clang을 지정할 때에는 전역 옵션을 명령 앞에 둡니다.

```bash
python3 run_pipeline.py --clang /path/to/clang doctor --write-lock --lock linux.lock.json
python3 run_pipeline.py --clang /path/to/clang generate --lock linux.lock.json --output artifacts-linux
```

Linux에서는 UBSan 런타임을 포함한 정상적인 Clang 개발 환경이 필요합니다. 새로운 프로필의 `doctor`가 실패하면 데이터 생성을 진행하지 않습니다. 현재 Linux 실행 경로는 아직 실제 검증하지 않았습니다.

## 샘플 검증

각 함수에 경계값 8개의 전체 조합 64개와 고정 시드 난수 입력 192개, 기본 256개를 사용합니다. Python 해석기의 추적으로 분기의 양쪽 결과와 반복 횟수 0·1·16을 확인합니다. 부족하면 시드가 고정된 탐색으로 증인 입력을 추가하며, 정해진 횟수 안에 찾지 못하면 해당 후보를 거절합니다. 이 제어 흐름 기록은 **AST 해석기 추적**이며 네이티브 바이너리의 분기 계측 결과는 아닙니다.

모든 입력에서 다음 실행의 출력이 Python 기준값과 같아야 합니다.

1. C를 `-O0`로 컴파일한 실행 파일
2. 저장한 LLVM IR을 `-O2`로 컴파일한 실행 파일
3. C를 `-O1 -fsanitize=undefined -fno-sanitize-recover=all`로 컴파일한 실행 파일

IR 자체는 `-O0`로 생성합니다. 따라서 `optnone`이 붙은 함수에는 IR 실행 단계의 `-O2`로도 함수 최적화가 제한될 수 있습니다. IR을 다시 읽고 실행하는 경로를 검사하는 것이 목적이며, 최적화 성능 비교가 아닙니다. 타깃 속성과 메타데이터는 보존합니다.

출력은 프로세스 종료 코드가 아닌 표준 출력의 32비트 정수 전체를 비교합니다. 컴파일 진단·sanitizer 오류·출력 불일치·시간 초과는 실패로 처리합니다. 도구 및 의미 검증 실패는 다른 후보로 조용히 대체하지 않고 전체 생성을 중단합니다. 부분 산출물과 실패 내용은 `artifacts.work-*`에 남기며, 성공한 결과만 최종 출력 디렉토리로 이동합니다. 구조 중복·관측 출력의 상수화·커버리지 부족으로 거절한 후보는 `rejections.json`에 AST와 사유를 기록합니다.

이 검증은 유한 입력에서의 실행 검사입니다. 모든 입력에서의 의미 동등성이나 UB 부재를 수학적으로 증명하지 않으며, C 컴파일러와 IR 실행 경로가 동일 LLVM 도구를 공유한다는 한계도 있습니다. 별도 Python 의미 해석기와 수작업 기준 테스트로 오류 검출 경로를 보완합니다.

## 산출물

```text
artifacts/
├── dataset.jsonl            # prompt/completion 및 C 소스·구조 식별자
├── manifest.json            # 파일 SHA-256, 설정·도구·소스 코드 해시
├── config.json
├── toolchain.lock.json
├── validation.json         # 전체 및 샘플별 검증 결과
├── rejections.json
└── samples/<id>/
    ├── source.c
    ├── module.ll
    ├── ast.json
    ├── inputs.json         # 입력·기대값·입력 출처·해석기 추적
    └── validation.json
```

학습에는 `dataset.jsonl`의 `prompt`와 `completion` 필드를 사용합니다. 출력 정답은 코드 블록이나 설명이 없는 전체 LLVM IR 모듈입니다. `c_source`는 원본 검사에 사용하고, 모델 입력에는 이미 `prompt`에 포함돼 있으므로 중복 연결하지 마세요. 토크나이저별 길이 제한은 학습 단계에서 검사해야 하며, IR 끝부분을 잘라 학습시키면 안 됩니다.

## 재현성의 의미

같은 소스 코드·설정·잠긴 도구 환경에서 생성한 데이터 파일과 manifest가 바이트 단위로 같아야 합니다. 난수 생성기는 SHA-256 counter stream으로 구현해 Python 표준 RNG 버전 변화의 영향을 피했습니다. C 입력 파일명은 항상 `source.c`이고, IR 생성 명령에는 절대 경로를 넣지 않습니다. JSON 키·행 순서와 줄바꿈을 고정하며, 시각·실행 시간·임시 디렉토리명은 데이터에 넣지 않습니다.

현재 도구 잠금은 Clang 실행 파일 SHA-256, 버전, 타깃, Python 버전, OS/아키텍처, 컴파일 옵션, macOS SDK 버전과 설정 해시를 검사합니다. 전체 OS 파일 시스템을 보관한 컨테이너 이미지 잠금은 아니므로 임의의 다른 머신에서의 바이트 일치까지 보장하지 않습니다. 별도 경로 두 번 생성한 실제 비교 결과는 루트의 `reproducibility.json`에 기록합니다.

참고: [LLVM opt](https://llvm.org/docs/CommandGuide/opt.html), [Clang UBSan](https://clang.llvm.org/docs/UndefinedBehaviorSanitizer.html).

## 다음 학습 제안

첨부 보고서·생성기·분할·시험 기록을 검토한 [다음 학습 개선 제안서](docs/NEXT_TRAINING_PROPOSAL.md)를 추가했습니다. 고정 타깃 속성 분리, 상수·복합 구조 보강, family OOD 평가, 단계별 실험과 자원 상한을 담았으며 아직 신규 학습은 시작하지 않았습니다.

후속 검토를 반영한 [다음 학습 준비안 v003](docs/NEXT_TRAINING_PREPARATION.md)과 [코드 생성 명세](docs/NEXT_TRAINING_CODEGEN_SPEC.md)에 구현 계약, 인자 재대입 범위, 평가 패널, checkpoint·예산 정책을 정리했습니다. 설정 계획과 근거 스냅샷은 `training/proposals/v003/`에 있습니다. 현재 완료 범위는 명세와 비실행 준비 자료이며, 구현·신규 데이터·학습 검증은 준비안의 단계별 완료 조건을 따릅니다.
