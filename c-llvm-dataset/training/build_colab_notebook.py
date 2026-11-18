"""Rebuild the standalone Colab notebook and its deterministic upload bundle."""
from pathlib import Path
import hashlib
import json
import textwrap
import zipfile

import nbformat as nbf

ROOT = Path(__file__).resolve().parents[1]
TRAINING = ROOT / 'training'
NOTEBOOK = ROOT / 'notebooks' / 'train_from_scratch_colab.ipynb'
BUNDLE = TRAINING / 'scratch_colab_bundle.zip'
sha = lambda value: hashlib.sha256(value).hexdigest()
manifest = json.loads((ROOT / 'artifacts/manifest.json').read_text())
metadata = {
    'dataset_sha256': manifest['files']['dataset.jsonl'],
    'sample_count': manifest['sample_count'],
    'dataset_manifest_sha256': sha((ROOT / 'artifacts/manifest.json').read_bytes()),
    'training_code_sha256': sha((TRAINING / 'scratch.py').read_bytes()),
    'target': json.loads((ROOT / 'toolchain.lock.json').read_text())['target'],
    'scope': '100-pair pipeline pilot; native execution verified on macOS ARM, not Linux',
}
contents = {
    'scratch.py': (TRAINING / 'scratch.py').read_bytes(),
    'dataset.jsonl': (ROOT / 'artifacts/dataset.jsonl').read_bytes(),
    'dataset_metadata.json': (json.dumps(metadata, indent=2, sort_keys=True) + '\n').encode(),
    'requirements.txt': (TRAINING / 'requirements-colab.txt').read_bytes(),
}
with zipfile.ZipFile(BUNDLE, 'w', compression=zipfile.ZIP_DEFLATED, compresslevel=9) as archive:
    for name, content in sorted(contents.items()):
        info = zipfile.ZipInfo(name, date_time=(2000, 1, 1, 0, 0, 0))
        info.compress_type = zipfile.ZIP_DEFLATED
        info.external_attr = 0o644 << 16
        archive.writestr(info, content)
bundle_sha = sha(BUNDLE.read_bytes())
cells = []
def md(text):
    cells.append(nbf.v4.new_markdown_cell(textwrap.dedent(text).strip()))
def code(text):
    cells.append(nbf.v4.new_code_cell(textwrap.dedent(text).strip()))

md('''
# C → LLVM IR: Colab에서 처음부터 학습하기

**사전학습 가중치와 사전학습 토크나이저를 사용하지 않습니다.** 학습용 C–IR 쌍으로 byte-level BPE 토크나이저를 만들고, 현재 자료 기준 약 2,725만 파라미터의 causal Transformer를 무작위로 초기화합니다.

현재 100쌍은 **학습 과정 점검용**입니다. 80개 학습·10개 검증·10개 시험으로 나누고 시험 데이터는 이 노트북에서 평가하지 않습니다. 새 C 함수의 컴파일 능력은 데이터 확장과 별도의 실행 평가가 필요합니다. 낮은 loss가 올바른 컴파일을 보장하지 않습니다.

준비물: NVIDIA GPU 런타임, `scratch_colab_bundle.zip`, 체크포인트를 저장할 Google Drive 공간. Colab 메뉴에서 **런타임 → 런타임 유형 변경 → GPU**를 선택한 뒤 위에서 아래로 실행하세요. GPU 종류와 할당 시간은 Colab 상황에 따라 달라집니다.

노트북은 로컬에서 구조·구문을 검사했고, 작은 CPU 모델로 학습·체크포인트 재개를 검증했습니다. Colab GPU 전체 실행은 아직 수행하지 않았습니다.
''')
md('''
## 1. 최소 의존성 설치

Colab에 설치된 CUDA용 PyTorch를 유지하고 토크나이저 라이브러리만 설치합니다. 모델 다운로드나 Hugging Face 계정은 필요 없습니다. 설치 전에 GPU 런타임으로 바꾸세요.
''')
code('''
import subprocess
import sys
subprocess.check_call([sys.executable, "-m", "pip", "install", "tokenizers==0.22.2"])
''')
code('''
import hashlib
import io
import json
from pathlib import Path
import re
import shutil
import zipfile
import torch
import tokenizers

if not torch.cuda.is_available():
    raise RuntimeError("GPU가 없습니다. 런타임 유형을 GPU로 바꾼 뒤 처음부터 실행하세요.")
if tokenizers.__version__ != "0.22.2":
    raise RuntimeError("이전 tokenizers가 메모리에 있습니다. 런타임 세션을 재시작하세요.")
DEVICE = "cuda"
print("GPU:", torch.cuda.get_device_name(0))
print("GPU 메모리 GiB:", round(torch.cuda.get_device_properties(0).total_memory / 2**30, 1))
print("PyTorch:", torch.__version__, "CUDA:", torch.version.cuda)
''')
md('''
## 2. 학습 자료 묶음 업로드

함께 제공된 **`scratch_colab_bundle.zip` 하나**를 업로드합니다. 데이터 100쌍과 학습 코드가 들어 있으며, 묶음과 데이터 해시를 확인합니다. 다른 데이터셋을 사용할 때에는 저장소에서 자료 묶음과 노트북을 함께 다시 만드세요.
''')
code('''
from google.colab import files
uploaded = files.upload()
''')
code(f'''
EXPECTED_BUNDLE_SHA256 = "{bundle_sha}"
zip_uploads = [(name, data) for name, data in uploaded.items() if name.endswith(".zip")]
if len(zip_uploads) != 1:
    raise ValueError("scratch_colab_bundle.zip 하나를 업로드하세요.")
name, bundle_bytes = zip_uploads[0]
if hashlib.sha256(bundle_bytes).hexdigest() != EXPECTED_BUNDLE_SHA256:
    raise ValueError("자료 묶음 해시가 다릅니다. 노트북과 ZIP의 버전이 맞는지 확인하세요.")
WORK = Path("/content/c-llvm-scratch")
WORK.mkdir(exist_ok=True)
allowed = {{"scratch.py", "dataset.jsonl", "dataset_metadata.json", "requirements.txt"}}
with zipfile.ZipFile(io.BytesIO(bundle_bytes)) as archive:
    if set(archive.namelist()) != allowed or len(archive.namelist()) != len(allowed):
        raise ValueError("예상하지 않은 ZIP 구조입니다.")
    if sum(info.file_size for info in archive.infolist()) > 20_000_000:
        raise ValueError("예상보다 큰 ZIP입니다.")
    for filename in sorted(allowed):
        (WORK / filename).write_bytes(archive.read(filename))
metadata = json.loads((WORK / "dataset_metadata.json").read_text())
if hashlib.sha256((WORK / "scratch.py").read_bytes()).hexdigest() != metadata["training_code_sha256"]:
    raise ValueError("학습 코드 해시가 다릅니다.")
sys.path.insert(0, str(WORK))
import scratch
rows = scratch.load_rows(WORK / "dataset.jsonl", metadata["dataset_sha256"])
assert len(rows) == metadata["sample_count"]
print("자료 수:", len(rows), "IR 타깃:", metadata["target"])
''')
md('''
## 3. 첫 실험 설정

기본은 8개 층·너비 512·8개 attention head이며, 어휘 수 상한은 2,048개입니다. 현재 자료에서 실제 학습되는 어휘는 900개입니다. 길이 2,048로는 일부 정답이 잘려 **문맥 길이를 3,072**로 잡았습니다. 샘플을 더 늘리면 길이를 다시 검사합니다.

기본 200 optimizer step으로 먼저 학습·저장 과정을 확인하세요. 1 step은 1개 샘플의 미니배치 8회를 누적한 업데이트입니다. 설정을 바꾸는 새 실험은 `RUN_NAME`도 바꾸세요. 체크포인트 재개는 기존 설정을 그대로 사용합니다.
''')
code('''
RUN_NAME = "scratch-pilot-001"
CONFIG = {
    "seed": 20261113,
    "vocab_size": 2048,
    "context_length": 3072,
    "d_model": 512,
    "n_heads": 8,
    "n_layers": 8,
    "dropout": 0.1,
    "batch_size": 1,
    "gradient_accumulation_steps": 8,
    "learning_rate": 3e-4,
    "precision": "fp16",
    "max_steps": 200,
    "warmup_steps": 20,
    "eval_every": 25,
    "save_every": 50,
}
if not re.fullmatch(r"[A-Za-z0-9_-]+", RUN_NAME):
    raise ValueError("RUN_NAME에는 영문·숫자·밑줄·하이픈만 사용하세요.")
torch.manual_seed(CONFIG["seed"])
torch.cuda.manual_seed_all(CONFIG["seed"])
''')
md('''
## 4. Drive 연결과 실험 기록

체크포인트에는 **전체 모델과 optimizer 상태**가 들어갑니다. 최근 체크포인트 두 개와 최종 가중치를 보관하므로 Drive에 약 2GB 이상의 여유를 권장합니다. 노트북 화면을 닫기 전 체크포인트 저장 메시지를 확인하세요. 마지막 저장 이후 진행은 중단 시 잃을 수 있습니다.

같은 `RUN_NAME`이면 체크포인트를 찾아 재개합니다. 데이터·설정·코드·라이브러리 버전이 다르면 새 실험 이름을 사용해야 합니다. GPU 종류가 바뀌면 수치 결과가 달라질 수 있습니다.
''')
code('''
from google.colab import drive
drive.mount("/content/drive")
RUN_DIR = Path("/content/drive/MyDrive/MAGICompile") / RUN_NAME
RUN_DIR.mkdir(parents=True, exist_ok=True)
settings = {
    "config": CONFIG,
    "dataset_sha256": metadata["dataset_sha256"],
    "training_code_sha256": metadata["training_code_sha256"],
    "torch_version": str(torch.__version__),
    "tokenizers_version": tokenizers.__version__,
}
settings_path = RUN_DIR / "run-settings.json"
if settings_path.exists():
    if json.loads(settings_path.read_text()) != settings:
        raise ValueError("기존 실험과 설정이 다릅니다. 새 RUN_NAME을 지정하세요.")
else:
    scratch.write_json(settings_path, settings)
splits = scratch.split_rows(rows, CONFIG["seed"])
split_ids = {key: [row["id"] for row in values] for key, values in splits.items()}
split_path = RUN_DIR / "splits.json"
if split_path.exists() and json.loads(split_path.read_text()) != split_ids:
    raise ValueError("기존 실험과 분할이 다릅니다.")
scratch.write_json(split_path, split_ids)
shutil.copyfile(WORK / "dataset.jsonl", RUN_DIR / "dataset.jsonl")
scratch.write_json(RUN_DIR / "dataset_metadata.json", metadata)
shutil.copyfile(WORK / "scratch.py", RUN_DIR / "scratch.py")
print("분할:", {key: len(value) for key, value in splits.items()})
print("저장 위치:", RUN_DIR)
''')
md('''
## 5. 토크나이저를 학습 데이터만으로 만들기

처음 실행할 때는 학습 80개의 C와 IR만 사용해 byte-level BPE를 학습합니다. 검증·시험 텍스트는 토크나이저 학습에 넣지 않습니다. 재개할 때에는 보관한 토크나이저를 그대로 사용합니다.

길이가 초과하면 실행을 멈춥니다. IR 끝을 잘라 학습시키지 않습니다. 프롬프트와 패딩은 loss에서 제외하고 IR 및 종료 토큰을 학습합니다.
''')
code('''
tokenizer_path = RUN_DIR / "tokenizer.json"
if tokenizer_path.exists():
    tokenizer = scratch.Tokenizer.from_file(str(tokenizer_path))
else:
    tokenizer = scratch.train_tokenizer(splits["train"], CONFIG["vocab_size"])
    tokenizer.save(str(tokenizer_path))
train_features = scratch.encode_rows(splits["train"], tokenizer, CONFIG["context_length"])
validation_features = scratch.encode_rows(splits["validation"], tokenizer, CONFIG["context_length"])
# 시험 10개는 여기에서 학습·토큰화·평가하지 않습니다.
run_spec = {
    **settings,
    "tokenizer_sha256": hashlib.sha256(tokenizer_path.read_bytes()).hexdigest(),
    "splits": split_ids,
}
spec_path = RUN_DIR / "run-spec.json"
if spec_path.exists() and json.loads(spec_path.read_text()) != run_spec:
    raise ValueError("기존 실험의 토크나이저 또는 분할과 다릅니다.")
scratch.write_json(spec_path, run_spec)
print("실제 어휘 수:", tokenizer.get_vocab_size())
print("학습 최대 토큰:", max(len(row["input_ids"]) for row in train_features))
print("검증 최대 토큰:", max(len(row["input_ids"]) for row in validation_features))
''')
md('''
## 6. 무작위 모델 초기화와 학습 시작

아래 생성자는 모델 구조를 만들고 가중치를 무작위로 초기화합니다. `from_pretrained` 호출은 없습니다. 기존 실험의 체크포인트가 있으면 그 실험의 가중치·optimizer·난수 상태를 복원합니다.

학습 배치는 학습 데이터에서 복원 추출합니다. `max_steps`는 epoch 수가 아닌 optimizer 업데이트 시도 수입니다. fp16 overflow로 건너뛴 업데이트는 scheduler를 진행하지 않습니다.
''')
code('''
model = scratch.ScratchCausalLM(
    vocab_size=tokenizer.get_vocab_size(),
    context_length=CONFIG["context_length"],
    d_model=CONFIG["d_model"],
    n_heads=CONFIG["n_heads"],
    n_layers=CONFIG["n_layers"],
    dropout=CONFIG["dropout"],
).to(DEVICE)
print("파라미터 수:", f"{sum(parameter.numel() for parameter in model.parameters()):,}")
metrics = scratch.train(
    model, train_features, validation_features, tokenizer,
    CONFIG, RUN_DIR, run_spec, DEVICE,
)
''')
md('''
## 7. 학습 결과 확인

학습 loss와 검증 loss를 함께 확인합니다. 학습 loss만 낮아지면 과적합일 수 있습니다. 검증 loss는 정답 IR 토큰의 예측 오차이며, 컴파일 성공률이나 의미 정확도가 아닙니다.
''')
code('''
import matplotlib.pyplot as plt
training_points = [point for point in metrics if "training_loss" in point]
validation_points = [point for point in metrics if "validation_loss" in point]
plt.figure(figsize=(9, 4))
plt.plot([point["step"] for point in training_points], [point["training_loss"] for point in training_points], label="Training")
plt.plot([point["step"] for point in validation_points], [point["validation_loss"] for point in validation_points], marker="o", label="Validation")
plt.xlabel("Optimizer step attempt")
plt.ylabel("Completion token cross-entropy")
plt.legend()
plt.grid(alpha=0.2)
plt.tight_layout()
plt.show()
''')
md('''
## 8. 검증 함수 한 개로 생성 미리보기

처음에는 256토큰만 생성해 동작을 확인합니다. 종료 토큰 없이 한도에 도달한 출력은 완성된 IR로 취급하지 않습니다. 이 모델은 KV cache가 없어서 긴 출력 생성이 느릴 수 있습니다.

아래 예시는 검증 데이터입니다. 시험 데이터는 최종 평가를 위해 남겨둡니다. 현재 IR 타깃은 macOS ARM이므로 Linux Colab에서 곧바로 네이티브 실행 검증했다고 해석하지 마세요.
''')
code('''
row = splits["validation"][0]
preview = scratch.generate_ir(model, tokenizer, row["prompt"], DEVICE, max_new_tokens=256)
scratch.write_json(RUN_DIR / "validation-preview.json", {"id": row["id"], **preview})
print("샘플:", row["id"], "종료 토큰:", preview["ended_with_eos"], "한도 도달:", preview["limit_reached"])
print(preview["generated_ir"])
''')
md('''
## 저장 파일과 재개 방법

Drive의 `MAGICompile/<RUN_NAME>/`에 다음이 남습니다.

- `model.pt`: 직접 학습한 전체 모델 가중치
- `tokenizer.json`: 직접 학습한 토크나이저
- `checkpoint-latest.pt`, `checkpoint-previous.pt`: 모델·optimizer·scheduler·scaler·난수 상태
- `run-settings.json`, `run-spec.json`, `splits.json`: 설정과 데이터 분할·해시
- `scratch.py`, `dataset.jsonl`, `dataset_metadata.json`: 사용 코드와 입력 데이터
- `metrics.json`, `validation-preview.json`: 관측 결과

**재개:** GPU를 다시 연결하고, 같은 노트북과 ZIP을 업로드한 뒤 같은 `RUN_NAME`과 설정으로 위에서부터 실행합니다. 최종 가중치만으로는 optimizer 상태까지 재개할 수 없으므로 체크포인트도 보관하세요.

**새 실험:** 설정 변경 시 새 `RUN_NAME`을 사용합니다. 메모리가 부족하면 먼저 GPU를 점유한 다른 객체를 정리하고 세션을 재시작하세요. 작은 모델로 바꾸려면 새 실험에서 `d_model=256, n_heads=4, n_layers=4`를 사용하세요. 문맥 길이를 줄여 정답을 자르는 방식은 피하세요.

**다음 단계:** 동일한 생성·검증 규칙으로 수천~수만 개 이상의 다양한 구조를 확보하고, 실행 간 중복과 데이터 분할을 점검합니다. 필요한 양은 범위와 실험 결과에 따라 정하며, 특정 수량이 일반화를 보장하지 않습니다. Linux용 실행 평가를 하려면 Linux 타깃 데이터셋과 별도의 컴파일 검증 환경을 준비하세요.

참고: [PyTorch TransformerEncoder](https://docs.pytorch.org/docs/2.9/generated/torch.nn.TransformerEncoder.html), [토크나이저 직접 학습](https://huggingface.co/docs/tokenizers/python/latest/quicktour.html), [Colab 자원 안내](https://research.google.com/colaboratory/faq.html).
''')
notebook = nbf.v4.new_notebook(cells=cells, metadata={
    'kernelspec': {'display_name': 'Python 3', 'language': 'python', 'name': 'python3'},
    'language_info': {'name': 'python', 'version': '3.11'},
    'colab': {'name': NOTEBOOK.name, 'provenance': []},
    'accelerator': 'GPU',
})
# Stable cell IDs keep reauthoring diffs small.
for index, cell in enumerate(notebook.cells):
    cell['id'] = f'cell-{index:03d}'
nbf.validate(notebook)
NOTEBOOK.parent.mkdir(exist_ok=True)
nbf.write(notebook, NOTEBOOK)
print(json.dumps({'notebook': str(NOTEBOOK), 'cells': len(cells), 'bundle_bytes': BUNDLE.stat().st_size,
                  'bundle_sha256': bundle_sha}, indent=2))
