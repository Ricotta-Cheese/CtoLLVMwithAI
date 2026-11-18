# 다음 학습 코드 생성 명세 v003

작성일 2026-11-16. 이 문서는 향후 코드 생성 작업의 구현 계약이다. [준비 결정](NEXT_TRAINING_PREPARATION.md)과 [계획 JSON](../../training/proposals/v003/preparation-plan.json)을 함께 적용한다. 현재 명세 패키지에는 실행 코드를 추가하지 않는다. 아래 파일명은 구현 시 사용할 권장 위치이며 기존 파일의 공개 진입점·v1 동작을 보존한다.

## 1. 구현 단위와 의존 순서

| 순서 | 대상 | 책임 |
|---|---|---|
| 1 | `src/c_llvm_dataset/ir_profile.py` 신규 | CPU 속성 정규화·조립, 불변 검사, 프로필 계약 |
| 2 | `training/evaluate_generated_ir.py` 확장 | 버전별 계약, 원문/시스템 점수, 강화 입력·승패 보고 |
| 3 | `training/qwen3_train.py`, build 도구 확장 | train/dev payload, 고정 checkpoint, 재개·예산 기록 |
| 4 | `model.py`, `generator.py`, `corpus.py` 확장 | 새 문법, family 분할, 태그·강화 입력·새 코퍼스 |
| 5 | `training/qwen3_test.py`, build 도구 확장 | 실효 greedy 설정·출력 기록, 완료 ID 기반 재개 |

기존 compiler·oracle·corpus 무결성·모델 lock·채팅 인코딩 로직을 재사용한다. 별도 profile/grammar/evaluator 버전 선택을 도입하고, 기존 CLI 기본값으로 실행한 v1 결과가 바뀌지 않게 한다. 기존 corpus·원본 prediction·보고서·adapter와 이번 준비 문서는 입력 자료로 취급한다.

## 2. IR profile 계약

프로필 ID는 `apple-arm64-cpu-separated-v002`다. CPU 값은 정답 코퍼스에서 유일한 값을 추출해 profile manifest에 바이트 그대로 저장한다. `target-cpu`와 `target-features`만 정규화한다. triple은 `arm64-apple-macosx27.2.0`, datalayout은 기존 corpus의 유일한 값을 사용한다.

정답 변환은 LLVM 문자열·주석·속성 그룹의 경계를 인식하고 두 이름의 함수 속성만 제거한다. 원문과 제거 span, 속성 그룹 참조, 복원 위치를 sidecar로 보존한다. source_filename·주석 안의 유사 문자열을 바꾸지 않는다. 중복 속성, 상충 값, 파싱 불명확, 지원하지 않는 적용 위치는 명시적인 계약 오류로 반환한다. 정답 sidecar를 사용한 역변환은 원문 바이트와 같아야 한다.

생성물 조립은 정답 sidecar 없이 `@compute`의 함수 속성 그룹에 두 값을 붙인다. 그룹이 없으면 충돌하지 않는 새 그룹을 만든다. 공통 시스템 평가에서는 B0와 후보 모두 기존 두 속성을 제거한 뒤 고정 값을 붙이는 같은 함수를 사용한다. CPU 속성 값 오류는 원문 계약 오류로 남고 시스템 결과도 별도 기록된다. 파싱할 수 없는 원문은 실패다. triple·datalayout·함수 본문·다른 속성·SSA·상수의 보정은 허용하지 않는다.

B1/B2 원문 계약은 두 CPU 속성 0개, 정확한 triple/datalayout 각 1개, compute 함수 1개다. v1 모델의 새 평가 계약은 고정 CPU 속성 각 1개와 정확한 triple/datalayout을 요구한다. 예전 evaluator 정책은 별도 v1 모드로 재현한다. 함수·ABI·명령·메타데이터 검사는 기존 지원 범위를 유지한다. 조립 출력은 고정 CPU 속성을 요구하는 공통 계약으로 검사한다.

각 표본에 `raw-generated.ll`, `assembled.ll`, diff, SHA-256, profile ID/version, 변환 상태·오류·경고를 저장한다. CPU 속성을 제외한 바이트가 달라지면 실패시킨다. 제거/삽입 때문에 생긴 필수 그룹 선언의 차이는 구조적으로 검사하고 그 변경을 diff에 남긴다.

정답 1,100개를 원본·정규화·복원·조립 형태로 verifier 및 기존 입력에서 검증한다. 복원 바이트와 함수 본문이 같아야 한다. profile 값이 없는 정규화 IR도 verifier·컴파일·실행을 통과해야 한다. 이때 원본 데이터 파일을 수정하지 않는다.

## 3. 문법과 데이터 계약

기존 uint32 C11 서명, 산술·비트·상수 0~31 시프트, 단일 최대 16회 반복을 유지한다. 신규 grammar ID `uint32-mutable-args-v002`는 x/y/acc 대입과 직접 return 표현식을 허용한다. acc를 읽는 경로에서는 먼저 초기화해야 한다. 대입 우변은 갱신 전 상태로 평가하고, 한 문장씩 상태를 갱신한다. 분기 합류 후 초기화 상태는 두 경로의 교집합으로 계산한다. 원본 x/y 입력과 현재 x/y 값을 oracle에서 구분해 기록한다.

반복 본문과 그 하위 분기에서 x/y 변경을 거절한다. 반복 횟수 식 `(x & 15u) + (y & 1u)`의 피연산자는 루프 진입 시 값과 반복 중 값이 같아 최대 16회가 유지된다. 반복 변수 i는 읽기 전용이다. x/y 재대입은 루프 전후와 루프 밖 분기에 허용한다. 이 규칙은 loop bound를 잘못 늘리는 문법 확장을 방지한다.

렌더러는 직접 return과 새 대입을 올바르게 출력해야 한다. `_Static_assert`·공백·변수명 변화는 같은 AST의 표현 변형 태그이며 독립 구조 수에 포함하지 않는다. B1에서는 기존 프롬프트를 바이트 그대로 유지한다. B2에서의 표현 변형은 별도 태그로 기록하며 같은 그룹은 한 분할에만 둔다. 최초 corpus는 AST당 학습 행 하나로 구성해 2,480행과 620 step 계산을 유지한다.

분류는 arithmetic/bitwise/branch/loop/combined를 유지한다. 분류별 신규 수량과 최소 단위·재대입 수량은 계획 JSON을 따른다. 단위 예제와 재대입 예제는 서로 다른 행이다. C source·IR·기존 structure ID 중복 검사와 원본 1,100개 교차 검사를 유지한다. 기존 structure ID가 변수 역할을 지우더라도 중복 조건을 임의로 완화하지 않는다.

정답 raw IR, normalized IR, assembled IR, AST, source, 입력·기대값·trace, category, template/family/grammar/profile ID, seed, 후보 번호, 원본 출처, source/IR/structure hash를 저장한다. 길이·AST 노드·식 깊이·분기·의존 사슬·상수 개수·입출력 토큰·난이도 태그와 split 분포를 보고한다. corpus manifest는 설정·도구·코드·파일 해시를 포함한다.

## 4. family 분할 계약

coarse shape는 기존 탐색 키를 그대로 보존하고 `coarse_shape_seen_in_train`을 추가한다. IID는 학습에 있는 template family에서 구조 중복 없이 추출한다. family OOD는 학습·기존 corpus에 없는 family를 통째로 보류한 집합이다.

family 키는 category와 제어 흐름 골격, 문장별 대입 대상, 읽은 변수와 갱신 순서, return에서 쓰는 변수 역할을 정규화한 서명이다. 상수·산술 연산자·표현식 내부 이진 트리 모양은 키에서 제외한다. 문장 블록 경계와 반복 내부/외부 위치를 유지한다. x/y 이름은 함수 인자 위치로 정규화하고 acc/i 역할은 보존한다. 읽은 변수 집합의 순서는 정렬한다. AST 전체 shape와 family를 혼동하지 않는다.

수작업 template catalog는 데이터 후보를 생성하기 전에 작성·해시 고정한다. 템플릿 이름만 바꿔 같은 서명을 다른 family로 배정할 수 없다. 기존 AST 1,100개를 같은 규칙으로 분류해 기존 family를 registry에 먼저 등록한다. 구현자는 아래 예약 패턴을 시작점으로 각 분류에서 dev/final 각각 2개 이상의 독립 family를 확보한다. family 1개가 dev OOD 5개 또는 final OOD 10개를 초과하지 않게 배분한다.

| 분류 | OOD catalog에 사용할 패턴 후보 |
|---|---|
| arithmetic | 교차 인자 갱신 뒤 두 인자 반환식, 인자 갱신 뒤 acc와 재결합 |
| bitwise | 순차 x/y XOR 갱신 뒤 반환, 인자 마스킹 뒤 acc와 비트 결합 |
| branch | 분기에서 인자를 갱신한 뒤 사용, 인자 갱신 뒤 분기별 직접 return |
| loop | 루프 전 인자 갱신과 루프 후 재결합, 루프 후 인자 갱신과 acc 결합 |
| combined | 루프 전 분기와 내부 분기, 내부 분기와 루프 후 인자 갱신·값 재사용 |

이 표는 catalog 작성 방향이다. 정확한 AST skeleton·서명·train/dev/final 소유권·난이도 범위는 구현 단계의 `family-catalog.json`으로 고정한다. 새 학습에는 위와 다른 서명을 가진 재대입 패턴도 넣는다. train/dev OOD/final OOD family 집합은 서로 겹치지 않고, OOD 두 집합은 기존 1,100개 전체와도 겹치지 않아야 한다. 각 분류 dev는 IID 30/OOD 10, final은 IID 20/OOD 20이다. 같은 AST의 표현 변형은 이 규칙을 공유한다.

catalog 단계에서 할당이 불가능하면 이유·수량·서명 충돌을 보고하고 계획을 개정한다. 검증 조건을 낮춰 생성하지 않는다. 분할별 family·길이·재대입·상수 태그 분포를 생성 전 목표와 생성 후 실측으로 남긴다. 생성과 시험 추론은 별개 단계이며 최종 시험 개별 결과에 따른 catalog 수정은 새 시험 버전을 요구한다.

## 5. oracle와 평가 입력

기존 Python / C O0 / IR 실행 / C UBSan 네 경로를 유지한다. 모든 정답의 추가 입력에도 네 경로를 적용한다. 신규 표본은 경계 64개+난수 192개를 기본 집합으로 저장하고 상수·마스크 경계·분기 증인과 반복 0·1·15·16 입력을 추가한다. 난수 시드는 데이터 생성·평가 확장 각각 분리한다. 중복 입력은 제거한다. 증인을 찾지 못한 경로와 탐색 한도를 기록하고 사전 채택 규칙으로 거절한다.

새 final의 확장 입력은 기본 256개를 포함하고 상수/제어 증인을 넣은 뒤 별도 난수로 1,024개 이상을 확보한다. 최종 생성 prediction을 보기 전에 입력·기대값·해시를 고정한다. 256개 보조 점수는 별도로 유지한다. 기본 256개가 증인을 포함하지 않더라도 확장 입력에서 경로 증인을 검사한다. 개발 주 평가는 고정 256개, 강화 입력 결과는 별도 진단으로 기록한다.

개발 표본에서 상수 ±1, 비가환 피연산자 교환, 갱신문 삭제로 mutation을 만든다. 문법상 유효·검증 가능한 경우, 입력 집합이 변이를 검출하는지 집계한다. 표본별 검출 여부·반례를 저장한다. 검출되지 않은 변이는 미검출로 기록하고 동등성으로 판정하지 않는다. mutation은 평가 입력 진단 자료이며 train/final 정답에 섞지 않는다.

생성 IR의 LLVM verifier 통과는 실행 정의성 보장이 아니다. 기존 지원 범위 검사·프로세스 제한을 유지하고 잘못된 시프트/오버플로 플래그·미초기화 load 등은 검출한 범위만 기록한다. 국소 SMT·Alive2는 별도 후속 실험이다.

## 6. 학습·패키징·재개

기반 리비전·학습 의존성은 기존 lock 및 `training/qwen_requirements.txt`를 시작점으로 한다. rank 8, alpha 16, dropout 0.05, all-linear, LR 1e-4, NF4 double/FP16, microbatch 1, 누적 4, cosine을 사용한다. B1 warmup 11, B2 warmup 31, seed/data_seed 20261113이다. B1은 220, B2는 620 optimizer step에서 종료한다. loss로 다른 checkpoint를 자동 선택하지 않는다.

train/dev만 별도 payload로 만든다. 로컬 검사에는 전체 corpus를 사용하되 GPU 학습 payload에는 기존 및 신규 final C/IR/기대값을 넣지 않는다. split manifest도 학습에 필요한 ID만 포함한다. B0의 기존 adapter는 SHA-256으로 검사한다. 새 adapter는 새 기반 모델에서 시작하고 B0 adapter를 초기값으로 사용하지 않는다.

학습 prompt+completion+EOS 합계가 4,096 이하인지 공식 토크나이저로 전량 확인한다. 초과 후보는 생성 규칙에 따라 거절하며 truncate하지 않는다. 최대 길이 배치로 forward/backward뿐 아니라 실제 optimizer step까지 메모리 시험한다. smoke 뒤 모델·optimizer·scheduler·RNG를 재초기화해 smoke 학습이 본 run에 섞이지 않게 한다.

B1 55 step, B2 155 step 간격 및 종료 시 재개 checkpoint를 저장한다. 실행 생성 평가는 최종 step에만 한다. 종료 adapter와 재개 가능한 optimizer/scheduler/RNG·sampler 상태를 보존하고, 메트릭·실제 샘플 노출·입출력 학습 토큰·유효 배치·LR 곡선·벽시계/GPU 작업량·환경을 저장한다. completed ID 방식은 추론 재개에 쓰고 학습 재개에는 데이터 순서까지 복원한다. 부분 쓰기는 임시 경로와 완료 표시로 구분해 원자적으로 확정한다.

## 7. 추론·평가·선택 계약

HF NF4+adapter, batch 1, greedy 1후보, 4,096 생성 토큰, 함수당 600초, `use_model_defaults=False`, 직접 `do_sample=False`를 적용한다. 실제 generation config와 토큰·EOS·종료 원인·시간·worker/GPU·prompt/adapter/backend 해시를 기록한다. 프롬프트는 기존 system+user 채팅 형식을 사용한다. B1은 출력 프로필 학습만 변경하며 profile 힌트를 추가하지 않는다.

추론 job에는 평가 프롬프트와 ID·분류만 넣는다. 완료 결과를 ID+prompt/adapter/정책 해시로 재사용하고 중복 완료는 거절한다. timeout/EOS 미도달/실행 실패는 최종 분모에 포함한다. 인프라 중단으로 원문이 확정되지 않은 건은 사유를 기록해 재개한다. 완료 후보를 다시 생성해 더 나은 것을 고르지 않는다.

| 보고 필드 | 의미 |
|---|---|
| `raw_execution_success` | 원문 자체의 LLVM·지원 범위·컴파일·전체 입력 실행 통과, 경고 실패 |
| `profile_contract_passed` | 모델별 v1/v2 출력 계약 준수 |
| `raw_strict_function_success` | 원문 실행 성공과 해당 출력 계약 모두 통과 |
| `system_execution_success` | 공통 profile 조립 후 공통 계약·실행 통과 |
| `local_sha_allowed_success` | 별도 Ollama/F16 배포 검사에서 정확한 +sha 무시 경고만 허용한 결과 |

B1의 속성 재출력 계약 위반은 원문 엄격 점수에서 실패이며 시스템 결과와 함께 남긴다. raw/system 양쪽 hash·diff·오류 단계를 보존한다. LLVM 검증률·완료율·카테고리·IID/OOD·family·길이·난이도·태그별 결과와 B0 대비 함수별 승·패를 보고한다. 기존 historical evaluator 점수와 새 계약 점수를 별도 버전으로 표시한다.

개발 패널 구성·선택·비용 정책은 준비안과 계획 JSON을 따른다. 새 25개 패널 선택은 category별 IID 3/OOD 2개를 `SHA256("v003-panel:" + id)` 오름차순으로 고정한다. 새 final 200개는 후보 하나의 모델·checkpoint·조립·제한을 동결한 뒤 B0와 평가한다. 가능하면 family 단위 쌍대 재표집으로 차이의 신뢰구간을 산출하고 family 수가 적다는 점을 보고한다. 전체 75%와 combined 55%는 방향성 목표다.

## 8. 구현 수용 사례

새 테스트는 아래 변경의 회귀를 검출하는 데 필요한 범위로 작성한다. 기존 테스트도 통과해야 한다.

- profile 문자열이 주석·source_filename에 있어도 원문을 보존한다. 속성 중복·상충은 거절하고 그룹 없는 유효 함수는 조립한다. 손상된 SSA와 잘못된 상수는 조립 후에도 실패한다.
- 정답 1,100개 복원 바이트·실행 일치, 공식 토크나이저의 143토큰 제거 계산을 검증한다. 실제 결과가 다르면 재현 조건과 원인을 기록해 근거를 갱신한다.
- triple/datalayout 누락은 v2 계약에서 실패하고 과거 v1 평가 모드가 기존 판정을 재현한다. profile 재출력은 raw strict에서 실패해도 시스템 열을 별도로 계산한다.
- 알려진 로컬 재대입 사례에서 입력 (0,0)의 oracle 정답은 2다. x 갱신 생략 변이가 검출돼야 한다. x/y/acc 갱신·분기 합류·직접 return을 수작업 기대값과 대조한다.
- 반복 내부의 x/y 대입·중첩 반복·미초기화 acc·시프트 32를 거절한다. 루프 전에 인자를 바꿔도 반복이 16회를 넘지 않는다.
- 상수·이름·연산자만 바꿔 held-out family를 학습에 넣는 경우 분할 오류로 잡는다. 서로 다른 template ID의 같은 family 서명도 같은 소유권으로 묶는다.
- train payload에서 final C·IR·기대값이 제거됐는지 내용과 manifest를 검사한다. 토큰 초과·중복 ID·해시 불일치·평가 누락은 명시적으로 보고한다.
- 중단 후 재개 학습의 데이터 순서·step·scheduler를 연속 run과 비교한다. 추론 재개는 완료 후보를 바꾸지 않고, 마지막 실패 함수도 분모에 남긴다.

구현 완료 보고에는 변경 파일, 기존/신규 테스트 결과, 아직 실행하지 않은 전량/GPU 검증, 계획 대비 변경 사항을 적는다. 코드 구현 완료와 새 학습 성능 검증 완료를 각각의 완료 상태로 기록한다.
