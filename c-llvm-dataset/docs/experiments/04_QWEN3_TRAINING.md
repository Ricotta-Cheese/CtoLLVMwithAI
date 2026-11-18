# Qwen3-4B-Instruct-2507 주력 학습

2026-11-13부터 주력 모델은 `Qwen/Qwen3-4B-Instruct-2507`입니다. 이전 scratch 및 Qwen2.5 실험 가중치·체크포인트와 scratch 업로드 번들은 로컬에서 삭제했습니다. 정리 기록은 `training/cleanup-20261113.json`에 있으며 약 883MiB를 회수했습니다. 과거 소스·측정값·생성 결과·원본 데이터는 비교와 재현성 기록으로 보존했습니다. 과거 scratch/Qwen2.5 실행기는 삭제된 가중치에 의존하므로 현재 실행 경로로 사용하지 마세요.

모델은 [공식 모델 카드](https://huggingface.co/Qwen/Qwen3-4B-Instruct-2507)의 비사고형 Instruct 모델이며 공식 채팅 템플릿으로 입력합니다. 정확한 모델 리비전은 `training/qwen3-model-lock.json`으로 고정합니다.

## 데이터와 첫 실행 설정

`corpus-1100-v001`의 1,100쌍을 사용합니다. 무결성·구조 중복·분할 누출 검사를 통과했고, 기존 데이터 100쌍과 확장 1,000쌍은 C/IR/UBSan 실행을 재검증한 기록을 갖습니다. 각 함수의 256개 입력, 총 281,600개 함수-입력 사례를 포함합니다. 유한 입력 검사이므로 모든 입력에서의 의미 동등성 증명은 아닙니다.

- 학습 880쌍, 검증 110쌍, 시험 110쌍. 과거 100쌍의 분할도 보존합니다.
- NF4 4비트 QLoRA, FP16, rank 8 / alpha 16 / dropout 0.05, all-linear.
- GPU 한 개만 노출합니다. T4 두 개의 VRAM을 합산하지 않습니다.
- 마이크로배치 1, 누적 4, 220 optimizer step = 학습 데이터 한 바퀴.
- 학습률 1e-4, warmup 11 step, cosine 감쇠.
- 가장 긴 학습/검증 예제는 채팅 템플릿 포함 3,455토큰. 자르지 않고 학습합니다.
- 학습 전 가장 긴 예제의 정방향·역전파 메모리를 시험합니다. 가중치는 갱신하지 않습니다.
- 학습 전과 55 step마다 검증 110쌍 전체의 teacher-forced loss를 측정합니다. 가장 낮은 검증 loss의 adapter를 내보냅니다.
- 생성 평가는 기존 검증 함수 10개와 새 검증 함수 분류별 2개, 총 20개를 사용합니다. 시험 세트는 사용하지 않습니다.
- 생성 설정은 greedy 한 개를 의도했으나 모델 기본값 병합으로 실제로는 고정 시드 sampling이었습니다(하단 정정 참고). 최대 3,072토큰/300초. 원문 그대로 LLVM 검증·컴파일·저장 입력 실행을 평가하며 자동 수리는 하지 않습니다.

Kaggle에서는 macOS 타깃 IR을 텍스트로 학습합니다. 생성 IR의 실행 검증은 잠긴 Apple Clang 환경의 로컬에서 수행합니다. 검증 loss와 실행 일치율은 서로 다른 지표입니다.

## 실행과 재현

프로젝트 루트 `c-llvm-dataset`에서 실행합니다.

```bash
python3.14 training/build_kaggle_qwen3.py
kaggle kernels push -p training/kaggle-qwen3-001 --accelerator NvidiaTeslaT4 -t 14400
```

학습 자료·모델 리비전·소스·고정 의존성·분할의 SHA-256을 기록합니다. 모델 캐시와 환경은 Kaggle `/kaggle/temp`에 두고, 출력에는 선택한 adapter·토크나이저·기록만 남깁니다. 기반 모델 약 8GB를 로컬로 중복 다운로드할 필요는 없습니다. GPU 비결정성 및 Kaggle 이미지 변경으로 가중치의 바이트 단위 재현성까지 보장하지는 않습니다.

선택 adapter 출력: `training/kaggle-results/qwen3-001/qwen3-4b-corpus1100-001/adapter-best`.

```bash
python3.14 training/evaluate_generated_ir.py \
  training/kaggle-results/qwen3-001/qwen3-4b-corpus1100-001/qwen3-4b-qlora-predictions.jsonl \
  --artifacts corpus-1100-v001 \
  --splits training/kaggle-results/qwen3-001/qwen3-4b-corpus1100-001/probe-splits.json \
  --output training/evaluations/qwen3-001
```

평가기는 원본 두 데이터셋의 무결성과 코퍼스 출처를 다시 검사합니다. probe가 동결 검증 분할의 부분집합인지 확인하고, 시험 데이터가 포함되면 실행 전에 거부합니다. 생성이 EOS 없이 끝나면 모든 입력이 일치해도 최종 함수 성공으로 세지 않습니다.

## 실행 결과

Kaggle 작업은 `COMPLETE`로 정상 종료됐습니다. 학습은 220 step / 1 epoch를 완료했고, 약 2시간 17분 18초가 걸렸습니다. 기반 모델 4B 전체를 업데이트한 것이 아니라 16,515,072개 LoRA 파라미터를 학습했습니다. 선택한 adapter는 220 step이며 로컬 가중치 검사(모델 리비전·데이터/소스 해시·파라미터 수·유한값·실제 LoRA 업데이트)를 통과했습니다.

| 항목 | 결과 |
|---|---:|
| 학습 전 검증 loss, 110쌍 | 0.752365 |
| 55 step 검증 loss | 0.008450 |
| 110 step 검증 loss | 0.005173 |
| 165 step 검증 loss | 0.004537 |
| 220 step 검증 loss, 최저 | 0.004449 |
| 최대 할당 GPU 메모리 | 11.285GiB / 14.562GiB |
| 생성 완료, 검증 probe 20함수 | 16/20, 80% |
| LLVM 검증·계약 검사·컴파일 | 16/20, 80% |
| 각 256입력 전부 동작 일치 | 14/20, 70% |

4함수는 300초 생성 제한으로 IR이 잘렸습니다: `combined-010`, `combined-019`, `ext001-combined-113`, `ext001-combined-162`. 3,072토큰 상한에는 도달하지 않았습니다. 이들은 문법 검증에도 실패하며 전체 분모에서 제외하지 않았습니다.

`bitwise-015`와 `ext001-bitwise-066`은 생성 완료와 LLVM 검증·컴파일은 통과했지만 실행 결과가 달랐습니다. 첫 반례는 둘 다 x=0, y=0이며, 각각 기대 17776 / 실제 132, 기대 6240 / 실제 0입니다. 따라서 낮은 검증 loss를 동작 정확도로 해석하면 안 됩니다.

기존 검증 10함수만 보면 성공은 7/10입니다. 이전 Qwen2.5 파일럿의 2/10보다 높지만, 기반 모델뿐 아니라 학습량·데이터 규모·입력 형식도 변경됐으므로 모델 크기의 효과만 분리한 비교가 아닙니다. 이번 20함수는 모델 선택에 사용한 검증 분할에서 뽑은 probe이며, 시험 110쌍은 여전히 미사용입니다. 70%는 이 probe와 저장된 유한 입력에 한정한 값입니다.

전체 결과는 `training/evaluations/qwen3-001/report.json`, 가중치 검사는 `training/kaggle-results/qwen3-001/qwen3-4b-corpus1100-001/local-adapter-verification.json`에 있습니다. 원격 원본 summary의 `native_accuracy: pending`은 원격 작업 당시 상태이며, 이후 로컬에서 이 실행 평가를 완료했습니다.

평가 시작 전 원본 데이터 폴더에 Finder의 `.DS_Store` 3개가 추가된 것을 발견했습니다. manifest에 등록된 파일은 모두 원본과 같았으며, 이 부가 파일만 제거한 뒤 무결성을 다시 확인했습니다. 정리 기록은 `training/kaggle-results/qwen3-001/finder-metadata-cleanup.json`에 보존했습니다.

다음 평가에서는 생성 시간 제한을 늘린 결과를 별도 설정으로 기록하고, 비트 연산 오답의 상수·연산 복사를 분석하는 것이 우선입니다. 이번 원문 출력과 300초 제한 평가 결과는 그대로 보존합니다.

### 생성 방식 표기 정정

시험 작업 준비 중 Transformers 4.57.6이 명시한 `GenerationConfig(do_sample=False)`를 모델 기본 `do_sample=True`로 덮어쓰는 경고를 발견했습니다. 기존 학습 로그에도 이 경고가 있어 위 20함수 검증 결과는 **고정 시드 sampling 한 후보**의 결과로 정정합니다. 측정된 14/20 실행 성공, 원본 출력, 학습 손실과 adapter는 변하지 않습니다. 기존 문서의 greedy 표기는 실제 실행을 보장하지 못했습니다. 새 시험 실행에서는 모델 기본값 병합을 차단하고 `do_sample=False`를 generate에 직접 전달하며, 그 동작을 고정한 Transformers 버전에서 확인했습니다.

## 동결 시험 세트 평가 완료

후속 시험 110함수를 평가해 생성 완료 110/110, LLVM 검증·컴파일 108/110, 저장 입력 전부 동작 일치 **72/110(65.5%)**를 확인했습니다. 이제 시험 세트는 평가에 사용된 상태입니다. 분류별 정확도와 오류 분석은 [시험 결과 문서](05_QWEN3_TEST.md)를 확인하세요.
