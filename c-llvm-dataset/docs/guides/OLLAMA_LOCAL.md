# 학습한 Qwen3 모델을 로컬 Ollama에서 실행

사용한 모델은 `Qwen/Qwen3-4B-Instruct-2507` 리비전 `cdbee75f17c01a7cc42f958dc650907174af0554`와 프로젝트의 220-step LoRA adapter입니다. 기존 adapter SHA-256을 확인한 뒤 FP16 기반 모델에 PEFT `safe_merge`로 병합합니다. 학습은 추가로 하지 않습니다.

[Ollama 공식 가져오기 문서](https://docs.ollama.com/import)에 따라 완성된 Safetensors 모델을 `Modelfile`의 `FROM`으로 불러옵니다. 일반 `qwen3:4b` 태그로 바꾸면 학습에 사용한 기반 모델 버전과 달라질 수 있으므로, 이 파이프라인은 고정한 원본 리비전을 다운로드합니다.

로컬 모델 이름: `magicompile-qwen3:4b`.

```bash
ollama run magicompile-qwen3:4b
```

학습한 입력 형식을 자동으로 적용해 C 파일을 변환하려면 프로젝트 `c-llvm-dataset`에서 실행합니다.

```bash
python3.14 local/ollama/run_c.py local/ollama/example.c -o /tmp/example.ll
```

이 모델은 `unsigned int compute(unsigned int x, unsigned int y)` 형태의 uint32 함수, 산술·비트 연산·분기·제한된 반복문으로 학습했습니다. 결과 타깃은 데이터셋의 `arm64-apple-macosx27.2.0`, 최적화 수준은 O0입니다. 전체 C 프로그램이나 다른 CPU 타깃으로의 변환 품질은 평가하지 않았습니다.

생성은 temperature 0, seed 20261113, context 8192, 최대 생성 4096토큰, repeat penalty 1로 설정합니다. 공식 Instruct-2507에 맞는 ChatML 형식과 학습 당시 system prompt를 사용합니다.

## 재구축

재구축에 필요한 LoRA adapter는 [Kaggle 학습 결과를 내려받는 단계](../experiments/04_QWEN3_TRAINING.md)에서 준비합니다.

임시 기반 가중치와 병합 파일은 `/private/tmp/magicompile-ollama-build`에 둡니다. 최종 모델은 Ollama의 사용자 모델 저장소에 등록됩니다.

```bash
python3.13 -m venv /private/tmp/magicompile-ollama-env
/private/tmp/magicompile-ollama-env/bin/python -m pip install -r local/ollama/requirements.txt
/private/tmp/magicompile-ollama-env/bin/python local/ollama/merge_adapter.py
ollama create magicompile-qwen3:4b -f local/ollama/Modelfile
```

최초 다운로드에 약 8GB, 병합 임시 출력에 약 8GB가 필요합니다. 병합 기록과 파일 해시는 `local/ollama/merge-manifest.json`에 남깁니다. Ollama에 등록한 뒤에는 임시 기반/병합 가중치를 제거해도 등록된 모델을 실행할 수 있습니다. 원래의 adapter와 검증 기록은 보존합니다.

Kaggle의 시험 65.5%는 NF4 기반 모델+adapter에서 측정했습니다. 로컬 FP16 병합·Ollama 실행은 수치 계산 경로가 다르므로 그 정확도가 그대로 유지된다고 보장할 수 없습니다. 로컬 실행 확인과 별도로 같은 프로토콜의 재평가가 필요합니다.

## 확인 상태

기반 가중치 3개(약 8.04GB)의 공식 SHA-256 검사를 통과했고, adapter 병합과 Ollama 등록을 완료했습니다. `ollama list`에 `magicompile-qwen3:4b`가 표시됩니다. F16 / Qwen3 4.0B / MLX runner이며 저장 크기는 약 8.1GB입니다.

`LocalTestPipeline`의 `add.c` 실제 변환에서 589토큰을 약 36.7초에 생성했고, 사용 후 `/api/ps`에서 모델 제거를 확인했습니다. 생성된 원문 IR에 지원되지 않는 `+sha` target-feature가 포함돼 Clang이 경고했습니다. 파이프라인은 진단을 엄격하게 처리하므로 이 시험은 실패로 기록됐으며, 실행 비교 단계까지 진행하지 않았습니다. 이를 정상 통과로 해석하면 안 됩니다.

실제 결과는 `local/ollama/local-run-verification.json` 및 `LocalTestPipeline/outputs/20261116_124141_add_726ee9/report.json`에 있습니다. Ollama 모델의 409개 저장 blob이 임시 가중치에 의존하지 않음을 확인한 뒤, 중복된 기반/병합 임시 가중치 약 16GB를 정리했습니다. 원래 adapter, 다운로드 및 병합 해시 기록, Ollama에 등록된 완성 모델은 보존했습니다.

다운로드는 `download_base.py`가 64MiB HTTP 구간과 최대 8개 연결로 재개하고, 각 shard의 공식 SHA-256을 확인합니다. 완료된 구간은 임시 작업 폴더에 보존되어 중단 후 재사용됩니다. 검증된 기반 파일이 이미 있으면 `merge_adapter.py --offline`으로 병합만 수행할 수 있습니다.
