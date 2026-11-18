# Kaggle GPU 시험 학습 결과

2026년 11월 13일, 로그인된 계정에서 비공개 작업을 CLI로 제출해 학습·체크포인트 저장·재개를 확인했습니다.

- 상태: `COMPLETE`, 시험 판정 `passed`
- 제출 코드: [`training/kaggle-smoke/run.py`](../../training/kaggle-smoke/run.py)
- 실행 설정: [`kernel-metadata.json`](../../training/kaggle-smoke/kernel-metadata.json)
- 로컬 결과: [`training/kaggle-results/smoke-20261113/`](../../training/kaggle-results/smoke-20261113)

## 실제 확인한 값

| 항목 | 결과 |
|---|---|
| 할당 GPU | Tesla T4 두 개 |
| 사용 GPU | `cuda:0` 한 개 |
| GPU 1개 메모리 | PyTorch 표시 약 14.56GiB |
| PyTorch / CUDA | 2.11.0+cu130 / 13.0 |
| 모델 | 무작위 초기화 Transformer, 27,253,760 파라미터 |
| 토크나이저 | 학습 자료만으로 만든 byte-level BPE, 어휘 900개 |
| 데이터 분할 | 학습 80개·검증 10개·시험 10개 |
| 문맥 길이 | 3,072토큰; 길이 초과 시 중단 |
| 배치 / 누적 | 1개 / 2회 |
| 실제 optimizer 업데이트 | 20회 |
| 재개 검사 | 10 step 저장 → 모델 새로 생성 → 상태 복원 → 20 step 완료 |
| 가중치 변경 | 확인됨 |
| 초기 / 최종 검증 loss | 6.92218 → 2.91663 |
| 최대 GPU 메모리 | 약 1.75GiB, 이 시험에서 측정한 값 |
| 스크립트 경과 시간 | 약 27초; Kaggle 대기·결과 저장·다운로드 시간 제외 |

이 결과는 GPU에서 학습과 저장·재개가 가능하다는 확인입니다. 컴파일 성공률이나 의미 정확도를 평가한 결과는 아니며, 시험 10개는 평가하지 않았습니다. 메모리와 시간은 현재 20 step·배치 설정에서의 측정값이므로 다른 모델 크기나 긴 학습의 수치로 그대로 적용하지 않습니다.

## 보관한 산출물

`scratch-smoke/` 아래에 전체 모델 `model.pt`, 재개용 `checkpoint-latest.pt`, `tokenizer.json`, `run-spec.json`, `splits.json`, `metrics.json`, `environment.json`, `summary.json`을 보관합니다. 원격 작업의 출력에도 최근·이전 체크포인트가 남습니다. 실제 다운로드와 로컬 무결성 확인 결과는 결과 폴더의 기록을 확인하세요.

다운로드 후 로컬에서 전체 가중치의 strict 로드, 모든 값의 유한성, 최종 모델과 체크포인트의 텐서 일치, optimizer step 20을 확인했습니다. [다운로드 검증 기록](../../training/kaggle-results/smoke-20261113/download-verification.json)에 파일별 SHA-256도 보관했습니다.

`run.log`에는 전체 실행 로그가, `quota-after.txt`에는 실행 후 확인한 할당량이 있습니다. 실행 전 GPU 할당량은 30시간이었습니다.

## 실행 관리

같은 작업의 새 버전을 제출해 시험을 다시 실행하려면 다음 명령을 사용합니다. 이 명령은 GPU 할당량을 사용합니다.

```bash
kaggle kernels push -p training/kaggle-smoke --accelerator NvidiaTeslaT4 -t 1800
```

작업 안에서 10 → 20 step 재개는 검증했습니다. 별도 Kaggle 세션 사이의 재개에는 저장한 체크포인트를 입력으로 연결하는 작업이 추가로 필요합니다. 현재 제출 스크립트는 새 세션에서 처음부터 시험을 실행합니다. Colab의 Drive 업로드·연결은 사용하지 않습니다.

원격 이미지에 설치된 Transformers는 더 새 tokenizers를 요구해, tokenizers 0.22.2 설치 시 의존성 경고가 출력됐습니다. 이 시험은 Transformers를 사용하지 않고 PyTorch와 tokenizers로 학습하여 완료됐습니다. 다른 Transformers 작업과 환경을 공유하려면 별도 가상환경을 사용하거나 호환 버전을 따로 확인해야 합니다.
