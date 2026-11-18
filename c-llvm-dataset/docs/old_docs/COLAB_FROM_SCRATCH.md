# Colab에서 모델을 처음부터 학습하기

사전학습 모델의 미세조정이 아니라 **토크나이저와 모델 가중치를 직접 학습**하는 첫 실험입니다. 모델 구조는 PyTorch로 구현한 인과적 Transformer이며 사전학습 가중치나 사전학습 토크나이저를 다운로드하지 않습니다.

## 준비 파일

다음 두 파일을 로컬 컴퓨터에 준비합니다.

- [Colab 학습 노트북](../../notebooks/train_from_scratch_colab.ipynb)
- [학습 코드와 100쌍이 들어 있는 ZIP](../../training/scratch_colab_bundle.zip)

ZIP에는 `scratch.py`, `dataset.jsonl`, `dataset_metadata.json`, `requirements.txt`가 들어 있습니다. 노트북에서 ZIP 해시, 학습 코드 해시, 데이터 해시를 확인하므로 같은 버전의 두 파일을 사용하세요. ZIP을 미리 풀 필요는 없습니다.

## 시작 순서

1. [Google Colab](https://colab.research.google.com/)을 열고 **파일 → 노트북 업로드**에서 `train_from_scratch_colab.ipynb`를 선택합니다.
2. **런타임 → 런타임 유형 변경**에서 GPU를 선택합니다. T4 같은 NVIDIA GPU를 사용하고, 첫 셀의 GPU 이름·메모리 출력을 확인합니다. GPU 종류와 이용 시간은 보장되지 않습니다.
3. 셀을 위에서부터 실행합니다. 업로드 창이 나오면 `scratch_colab_bundle.zip`을 선택합니다.
4. 첫 실행은 `RUN_NAME = "scratch-pilot-001"`과 기본 설정을 유지합니다. Drive 연결 셀에서 저장할 Google 계정을 연결합니다.
5. 토크나이저와 모델 초기화 뒤 `scratch.train(...)` 셀을 실행합니다. 학습 진행과 주기적인 검증 loss가 출력됩니다.
6. 완료 후 학습 곡선과 검증 함수의 생성 미리보기를 확인합니다. 최초 미리보기는 256토큰으로 제한하므로 완성된 IR이 아닐 수 있습니다.

## 기본 설정과 확인된 값

| 항목 | 설정 또는 확인된 값 |
|---|---|
| 데이터 분할 | 학습 80개·검증 10개·시험 10개 |
| 토크나이저 | 학습 80개의 C와 IR만 사용한 byte-level BPE |
| 어휘 수 | 상한 2,048개; 현재 자료의 실제 어휘 900개 |
| 모델 | 무작위 초기화, 8개 층, 너비 512, attention head 8개 |
| 파라미터 | 현재 자료 기준 27,253,760개 |
| 문맥 길이 | 3,072토큰 |
| 실제 길이 | 학습 최대 2,365토큰·검증 최대 2,254토큰 |
| 배치 | 1개씩 8회 gradient accumulation |
| 첫 실험 길이 | optimizer step 시도 200회 |
| 검증/저장 | 검증 25 step마다, 체크포인트 50 step마다 및 마지막 |
| 손실 계산 | IR과 종료 토큰에만 적용; 프롬프트·패딩 제외 |

현재 토크나이저는 공백과 줄바꿈을 포함한 IR을 원문으로 복원하는지 확인합니다. 길이 초과 샘플이 있으면 정답을 자르는 대신 실행을 중단합니다. 시험 데이터는 분할 후 따로 남기며 이 노트북의 학습·토크나이저 생성·생성 미리보기·평가에 사용하지 않습니다.

## 저장과 재개

저장 위치는 Drive의 `MyDrive/MAGICompile/<RUN_NAME>/`입니다.

- `model.pt`: 직접 학습한 전체 모델 가중치
- `tokenizer.json`: 직접 학습한 토크나이저
- `checkpoint-latest.pt`, `checkpoint-previous.pt`: 모델, optimizer, scheduler, scaler, 난수 상태, 학습 단계
- `run-settings.json`, `run-spec.json`, `splits.json`: 실험 설정·코드·데이터·토크나이저 해시와 데이터 분할
- `scratch.py`, `dataset.jsonl`, `dataset_metadata.json`: 사용 코드와 입력 자료
- `metrics.json`, `validation-preview.json`: 학습 기록과 생성 미리보기

체크포인트는 전체 모델과 optimizer를 포함하므로 Drive에 약 2GB 이상의 여유를 권장합니다. 저장 완료 메시지를 확인한 뒤 세션을 종료하세요. 중단 시 마지막 체크포인트 이후의 진행은 잃을 수 있습니다.

재개할 때에는 같은 노트북과 ZIP, 같은 `RUN_NAME`과 설정으로 처음부터 실행합니다. 기존 체크포인트가 있으면 직접 학습하던 가중치와 학습 상태를 복원합니다. 데이터·코드·토크나이저·설정·PyTorch 또는 tokenizers 버전이 다르면 재개를 거부합니다. 새로운 GPU 종류에서는 부동소수점 연산 결과가 달라질 수 있습니다.

학습률·step 수·모델 크기 등을 바꾸어 새 실험을 할 때에는 새 `RUN_NAME`을 사용합니다. 현재 재개 기능은 같은 설정으로 중단된 실행을 이어가는 기능입니다.

## 결과를 읽는 기준

100쌍은 **학습 파이프라인 점검용**입니다. 모델이 새로운 C 함수를 올바르게 컴파일할 수준이라고 기대하기에는 자료의 수와 다양성이 부족합니다. 학습 loss 감소만으로 컴파일 능력을 판단하지 않습니다.

먼저 확인할 것은 다음과 같습니다.

- 무작위 모델에서 유한한 loss와 학습 업데이트가 나오는가?
- 프롬프트와 패딩을 제외하고 정답 IR을 학습하는가?
- 학습 loss와 검증 loss가 어떻게 달라지는가?
- 모델·토크나이저·체크포인트를 저장하고 재개할 수 있는가?
- 생성 출력에 종료 토큰이 있는가, 길이 제한으로 잘린 것은 아닌가?

최종 컴파일 평가는 별도로 LLVM 검증과 실행 비교를 수행해야 합니다. 현재 정답 IR은 **macOS ARM 타깃**이므로 Linux Colab에서 생성 미리보기를 본 것만으로 Linux 네이티브 실행 검증을 완료한 것은 아닙니다.

다음 실험에서는 다양한 구조의 수천~수만 개 이상으로 데이터를 확장하고 일반화 성능을 확인합니다. 필요한 수량은 문법 범위와 결과에 따라 정하며 특정 개수가 성공을 보장하지 않습니다. 생성 전에는 [데이터셋 생성 지침](../DATASET_GENERATION_GUIDELINES.md)을 확인하세요.

## 문제가 생겼을 때

| 상황 | 조치 |
|---|---|
| GPU 없음 | 런타임 유형을 GPU로 변경하고 처음부터 실행 |
| ZIP 해시 불일치 | 같은 버전의 노트북과 ZIP을 다시 준비 |
| 기존 실험과 설정 불일치 | 재개라면 기존 설정 복원, 새 실험이라면 `RUN_NAME` 변경 |
| 정답이 문맥 길이 초과 | 새 실험에서 길이·모델 크기를 조정; 정답 IR을 자르지 않음 |
| CUDA 메모리 부족 | 세션 재시작 후 다시 시도; 필요하면 새 실험에서 너비 256·head 4·층 4로 축소 |
| 생성 미리보기에서 한도 도달 | 완성된 IR로 사용하지 않음; 전체 생성 시 문맥 여유와 실행 시간 확인 |

## 구현과 확인 범위

학습 코드는 [`training/scratch.py`](../../training/scratch.py)에 있습니다. 별도 Python 라이브러리는 `tokenizers==0.22.2`이고, Colab의 CUDA용 PyTorch를 유지합니다. 모델 로드용 Hugging Face 계정은 필요하지 않습니다.

작은 CPU 모델에서 인과적 주의, 손실 마스킹, 데이터 분할, 토크나이저 원문 복원, 체크포인트 중단·재개의 5개 테스트를 수행했습니다. Colab GPU에서 전체 200 step 실행과 Drive 연결은 아직 직접 검증하지 않았습니다. 최초 실행 시 GPU 확인·학습·저장 셀에서 실제 환경 동작을 확인해야 합니다.

노트북과 ZIP을 코드 변경 후 다시 만들려면 `nbformat==5.10.4`가 있는 개발 환경에서 아래 명령을 실행합니다. 기존 자료 묶음과 노트북을 함께 갱신하므로 새 버전은 함께 배포합니다.

```bash
python training/build_colab_notebook.py
```

참고: [PyTorch TransformerEncoder](https://docs.pytorch.org/docs/2.9/generated/torch.nn.TransformerEncoder.html), [토크나이저 직접 학습](https://huggingface.co/docs/tokenizers/python/latest/quicktour.html), [Colab 자원 안내](https://research.google.com/colaboratory/faq.html).
