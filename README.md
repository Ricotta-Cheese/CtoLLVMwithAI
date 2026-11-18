# C to LLVM with AI

C 함수를 LLVM IR로 변환하는 모델을 학습하고, 생성된 IR이 원본 C와 같은 결과를 내는지 검사하는 프로젝트입니다.

| 디렉토리 | 내용 |
| --- | --- |
| [c-llvm-dataset](c-llvm-dataset/README.md) | C–LLVM IR 데이터 생성·검증 코드, 1,100쌍 학습 코퍼스, 학습·평가 스크립트와 실험 기록 |
| [LocalTestPipeline](LocalTestPipeline/README.md) | Ollama 모델이 생성한 IR을 Clang으로 컴파일해 원본 C와 실행 결과를 비교하는 CLI, 예제 및 테스트 |

데이터와 CLI의 기본 타깃은 macOS ARM64입니다. 데이터 재현에 필요한 환경 잠금과 각 도구의 실행 방법은 위 문서에서 확인할 수 있습니다. 모델 가중치와 실행 로그는 로컬에서 관리합니다.
