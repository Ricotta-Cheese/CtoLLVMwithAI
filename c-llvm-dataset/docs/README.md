# 문서 목차

## 실험 기록 (시간순)

| # | 문서 | 내용 | 핵심 결과 |
|---|---|---|---|
| 01 | [Kaggle 환경 확인](experiments/01_KAGGLE_SMOKE.md) | 직접 만든 27M 모델로 20 step 학습, 체크포인트 저장·재개 | 학습 파이프라인 동작 확인 |
| 02 | [처음부터 학습](experiments/02_SCRATCH_TRAINING.md) | 파일럿 100쌍으로 200 step 학습, 학습 곡선 | 검증 loss 0.898, 생성 IR은 형식 오류 |
| 03 | [Qwen2.5 비교](experiments/03_QWEN25_COMPARISON.md) | 직접 만든 모델 vs Qwen2.5-Coder-1.5B 학습 전·후 | QLoRA 모델만 2/10 실행 일치 → Qwen 계열 채택 |
| 04 | [Qwen3-4B 학습](experiments/04_QWEN3_TRAINING.md) | 1,100쌍 코퍼스로 QLoRA 220 step, 검증 probe 평가 | 14/20 실행 일치 |
| 05 | [동결 시험 평가](experiments/05_QWEN3_TEST.md) | 시험 110함수 최종 평가와 오답 분석 | **72/110 (65.5%)** |

## 가이드

- [데이터셋 생성 전 확인 지침](guides/DATASET_GENERATION_GUIDELINES.md) — 환경 잠금, 생성 범위, 실패 처리, 재현성, 분할 기준
- [Ollama 로컬 실행](guides/OLLAMA_LOCAL.md) — adapter 병합과 `magicompile-qwen3:4b` 등록

## 다음 학습 계획 (제안 단계, 미실행)

- [개선 제안서](plans/NEXT_TRAINING_PROPOSAL.md) — 오답 분석에 근거한 우선순위와 실험 설계
- [준비안 v003](plans/NEXT_TRAINING_PREPARATION.md) — 확정한 준비 결정과 데이터 배분
- [코드 생성 명세](plans/NEXT_TRAINING_CODEGEN_SPEC.md) — 구현 계약과 수용 기준

`training/proposals/` 의 근거 JSON에는 작성 당시의 문서 경로(`docs/NEXT_TRAINING_*.md`)와 해시가 그대로 남아 있습니다. 문서는 이후 `docs/plans/`로 옮겼습니다.
