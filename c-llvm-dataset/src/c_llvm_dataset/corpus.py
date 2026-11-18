"""Combine verified datasets into one training corpus with structure-grouped, test-preserving splits."""
from __future__ import annotations

from collections import Counter
import hashlib
import json
from pathlib import Path
import tempfile

from .dedup import duplicate_report
from .model import CATEGORIES, canonical_json, digest
from .pipeline import ROOT, inventory, read_json, revalidate, verify_integrity, write_json

SPLITS = ("train", "validation", "test")


def split_by_structure(rows, seed):
    """Deterministic per-category split on structure IDs (same rule as the pilot's training/scratch.py)."""
    result = {name: [] for name in SPLITS}
    for category in sorted(CATEGORIES):  # same order as the pilot's training/scratch.py
        group = [row for row in rows if row["category"] == category]
        if len(group) < 5:
            raise ValueError("at least five distinct structures per category are required")
        if len({row["structure_id"] for row in group}) != len(group):
            raise ValueError("duplicate structure groups; group these before splitting")
        group.sort(key=lambda row: hashlib.sha256(f"{seed}:{category}:{row['structure_id']}".encode()).hexdigest())
        held_out = max(1, len(group) // 10)
        result["train"].extend(group[:-2 * held_out])
        result["validation"].extend(group[-2 * held_out:-held_out])
        result["test"].extend(group[-held_out:])
    return result


def display_path(path):
    path = path.absolute()
    try:
        return str(path.relative_to(ROOT))
    except ValueError:
        return str(path)


def load_dataset(directory):
    raw = (directory / "dataset.jsonl").read_bytes()
    return [json.loads(line) for line in raw.decode("utf-8").splitlines()], digest(raw)


def combine(base, base_splits_path, extension, output, split_seed, compiler=None, progress=print):
    base, extension, output = base.absolute(), extension.absolute(), output.absolute()
    base_splits_path = base_splits_path.absolute()
    if output.exists():
        raise ValueError(f"output already exists; choose a new path: {output}")
    sources = {"base": base, "extension": extension}
    reports, rows_by_name, dataset_hashes, revalidation = {}, {}, {}, {}
    for name, directory in sources.items():
        progress(f"{name}: checking integrity")
        verify_integrity(directory)
        if compiler is not None:
            progress(f"{name}: recompiling and re-executing every pair (C -O0, IR, UBSan)")
            revalidation[name] = revalidate(directory, compiler)
        rows_by_name[name], dataset_hashes[name] = load_dataset(directory)
        reports[name] = read_json(directory / "validation.json")
    base_rows, extension_rows = rows_by_name["base"], rows_by_name["extension"]
    duplicates = duplicate_report([("base", base_rows), ("extension", extension_rows)])
    if not duplicates["passed"]:
        raise ValueError(f"duplicate samples across datasets: {duplicates['collision_counts']}")
    targets = {row["target"] for row in base_rows + extension_rows}
    if len(targets) != 1:
        raise ValueError(f"mixed target profiles: {sorted(targets)}")
    if read_json(base / "toolchain.lock.json") != read_json(extension / "toolchain.lock.json"):
        raise ValueError("datasets were generated under different toolchain locks")

    # The pilot's existing partition is preserved verbatim and must cover exactly the base IDs.
    base_splits = read_json(base_splits_path)
    if set(base_splits) != set(SPLITS):
        raise ValueError("base split file must contain train, validation and test")
    base_ids = {row["id"] for row in base_rows}
    listed = [item for name in SPLITS for item in base_splits[name]]
    if len(listed) != len(set(listed)) or set(listed) != base_ids:
        raise ValueError("base split does not partition the base dataset exactly")
    if split_seed is not None:
        recomputed = split_by_structure(base_rows, split_seed)
        if {name: [row["id"] for row in recomputed[name]] for name in SPLITS} != {name: base_splits[name] for name in SPLITS}:
            raise ValueError("base split differs from the deterministic structure split; refusing to reinterpret it")

    new_split = split_by_structure(extension_rows, split_seed)
    splits = {name: list(base_splits[name]) + [row["id"] for row in new_split[name]] for name in SPLITS}
    split_of = {item: name for name in SPLITS for item in splits[name]}
    origin = {row["id"]: "base" for row in base_rows} | {row["id"]: "extension" for row in extension_rows}
    corpus_rows = []
    for row in base_rows + extension_rows:
        corpus_rows.append({**row, "source_dataset": origin[row["id"]], "split": split_of[row["id"]]})
    if len(corpus_rows) != len(split_of) or {r["id"] for r in corpus_rows} != set(split_of):
        raise ValueError("split does not partition the combined corpus")

    # Leakage checks: no structure, source, or IR is shared by two partitions; pilot test rows never train.
    by_split = {name: [row for row in corpus_rows if row["split"] == name] for name in SPLITS}
    for key in ("structure_id", "source_sha256", "ir_sha256"):
        sets = {name: {row[key] for row in rows} for name, rows in by_split.items()}
        for i, one in enumerate(SPLITS):
            for two in SPLITS[i + 1:]:
                if sets[one] & sets[two]:
                    raise ValueError(f"{key} shared between {one} and {two}")
    if set(base_splits["test"]) & {row["id"] for row in by_split["train"] + by_split["validation"]}:
        raise ValueError("a pilot test sample entered training or validation")
    for name in SPLITS:
        if not set(base_splits[name]) <= {row["id"] for row in by_split[name]}:
            raise ValueError(f"a pilot {name} sample moved to another split")

    counts = {name: dict(sorted(Counter(row["category"] for row in rows).items())) for name, rows in by_split.items()}
    split_report = {
        "method": "per category, order structure IDs by sha256(seed:category:structure_id); last 10% test, preceding 10% validation, rest train",
        "split_seed": split_seed, "unit": "structure_id",
        "base_split_file": display_path(base_splits_path),
        "base_split_file_sha256": digest(base_splits_path.read_bytes()),
        "base_split_preserved": True, "pilot_test_ids_in_train_or_validation": 0,
        "counts": {name: len(splits[name]) for name in SPLITS},
        "counts_by_category": counts,
        "counts_by_origin": {name: dict(Counter(origin[item] for item in splits[name])) for name in SPLITS},
        "structure_overlap_between_splits": 0, "source_overlap_between_splits": 0, "ir_overlap_between_splits": 0,
    }
    samples = [{"source_dataset": name, **sample} for name in ("base", "extension") for sample in reports[name]["samples"]]
    per_dataset = {name: {"path": display_path(sources[name]), "dataset_sha256": dataset_hashes[name],
                          "manifest_sha256": digest((sources[name] / "manifest.json").read_bytes()),
                          "sample_count": len(rows_by_name[name]),
                          "category_counts": reports[name]["category_counts"],
                          "input_pair_count": reports[name]["input_pair_count"],
                          "executable_comparison_count": reports[name]["executable_comparison_count"],
                          "all_samples_passed": all(s["status"] == "passed" and s["llvm_verifier_passed"] and s["ast_valid"]
                                                    and all(e["passed"] for e in s["executions"].values())
                                                    for s in reports[name]["samples"]),
                          "execution_revalidated_in_this_run": name in revalidation}
                   for name in sources}
    if not all(item["all_samples_passed"] for item in per_dataset.values()):
        raise ValueError("a source dataset contains a sample that did not pass every check")
    validation = {
        "status": "passed", "sample_count": len(corpus_rows),
        "category_counts": dict(sorted(Counter(row["category"] for row in corpus_rows).items())),
        "target": next(iter(targets)), "datasets": per_dataset,
        "input_pair_count": sum(d["input_pair_count"] for d in per_dataset.values()),
        "executable_comparison_count": sum(d["executable_comparison_count"] for d in per_dataset.values()),
        "integrity_checked": True, "execution_revalidation": revalidation or "not run",
        "duplicate_check": {k: v for k, v in duplicates.items() if k != "collisions"},
        "split_check": {"passed": True, "counts": split_report["counts"]},
        "verification_scope": "LLVM structural verification and finite execution testing; not a proof of equivalence",
        "samples": samples,
    }
    stage = Path(tempfile.mkdtemp(prefix=output.name + ".work-", dir=output.parent))
    try:
        (stage / "dataset.jsonl").write_text("".join(canonical_json(row) for row in corpus_rows), encoding="utf-8", newline="\n")
        write_json(stage / "splits.json", {name: splits[name] for name in SPLITS})
        write_json(stage / "split_report.json", split_report)
        write_json(stage / "validation.json", validation)
        write_json(stage / "duplicates.json", duplicates)
        settings = {"schema_version": 1, "kind": "combined-corpus", "split_seed": split_seed,
                    "inputs": per_dataset, "toolchain_lock_sha256": digest(canonical_json(read_json(base / "toolchain.lock.json"))),
                    "extension_config_sha256": digest(canonical_json(read_json(extension / "config.json"))),
                    "base_config_sha256": digest(canonical_json(read_json(base / "config.json")))}
        write_json(stage / "config.json", settings)
        write_json(stage / "extension.config.json", read_json(extension / "config.json"))
        write_json(stage / "toolchain.lock.json", read_json(base / "toolchain.lock.json"))
        manifest = {"schema_version": 1, "sample_count": len(corpus_rows), "files": inventory(stage)}
        write_json(stage / "manifest.json", manifest)
        stage.rename(output)
    except BaseException:
        progress(f"Combine failed; partial output retained at {stage}")
        raise
    return {"status": "passed", "sample_count": len(corpus_rows), "splits": split_report["counts"],
            "dataset_sha256": digest((output / "dataset.jsonl").read_bytes()),
            "manifest_sha256": digest((output / "manifest.json").read_bytes())}


def verify_corpus(directory):
    """Re-check a combined corpus from its own files: hashes, uniqueness, partition and leakage."""
    directory = directory.absolute()
    manifest = read_json(directory / "manifest.json")
    if inventory(directory) != manifest["files"]:
        raise ValueError("corpus file integrity check failed")
    rows, _ = load_dataset(directory)
    splits = read_json(directory / "splits.json")
    if not duplicate_report([("corpus", rows)])["passed"]:
        raise ValueError("duplicate samples in corpus")
    listed = [item for name in SPLITS for item in splits[name]]
    if len(listed) != len(set(listed)) or set(listed) != {row["id"] for row in rows}:
        raise ValueError("splits do not partition the corpus")
    for row in rows:
        if row["id"] not in splits[row["split"]]:
            raise ValueError(f"row split label disagrees with splits.json: {row['id']}")
    for key in ("structure_id", "source_sha256", "ir_sha256"):
        owner = {}
        for row in rows:
            if owner.setdefault(row[key], row["split"]) != row["split"]:
                raise ValueError(f"{key} shared between splits")
    return {"status": "passed", "sample_count": len(rows), "file_count": len(manifest["files"]),
            "split_counts": {name: len(splits[name]) for name in SPLITS}}
