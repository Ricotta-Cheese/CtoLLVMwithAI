"""Transactional dataset assembly, provenance, integrity and reproducibility checks."""
from __future__ import annotations

from collections import Counter
import json
from pathlib import Path
import re
import shutil
import tempfile

from .compiler import Compiler, ToolFailure
from .dedup import assert_no_duplicates
from .generator import generate_inputs, generate_program
from .model import CATEGORIES, MASK, canonical_json, digest, render_c, structure_id, validate_ast

ROOT = Path(__file__).resolve().parents[2]


def write_json(path, value):
    path.write_text(canonical_json(value), encoding="utf-8", newline="\n")


def read_json(path):
    return json.loads(path.read_text(encoding="utf-8"))


def source_hashes():
    paths = [ROOT / "run_pipeline.py", *sorted((ROOT / "src" / "c_llvm_dataset").glob("*.py"))]
    return {str(path.relative_to(ROOT)): digest(path.read_bytes()) for path in paths}


def load_config(path):
    config = read_json(path)
    if config.get("schema_version") != 1 or set(config["categories"]) != set(CATEGORIES):
        raise ValueError("unsupported configuration")
    if any(type(n) is not int or n <= 0 for n in config["categories"].values()):
        raise ValueError("category counts must be positive integers")
    if config["max_loop_iterations"] != 16:
        raise ValueError("v1 supports exactly the fixed 0..16 loop bound")
    if len(set(config["edge_values"])) != len(config["edge_values"]) or not config["edge_values"]:
        raise ValueError("edge inputs must be nonempty and unique")
    if any(type(n) is not int or not 0 <= n <= MASK for n in config["edge_values"]):
        raise ValueError("edge input outside uint32")
    for field in ("random_inputs", "max_witness_search", "max_attempts_per_category", "timeout_seconds"):
        if type(config[field]) is not int or config[field] <= 0:
            raise ValueError(f"{field} must be a positive integer")
    if type(config["seed"]) is not int:
        raise ValueError("seed must be an integer")
    prefix = config.get("id_prefix", "")
    if type(prefix) is not str or (prefix and not re.fullmatch(r"[a-z][a-z0-9]*-", prefix)):
        raise ValueError("id_prefix must be empty or lowercase alphanumerics ending in '-'")
    references = config.get("reference_datasets", [])
    if type(references) is not list or any(type(r) is not str or not r for r in references) or len(set(references)) != len(references):
        raise ValueError("reference_datasets must be a list of unique non-empty paths")
    return config


def load_references(config):
    """Verified rows of earlier datasets this run must not duplicate. Relative paths resolve from the project root."""
    infos, named_rows = [], []
    for reference in config.get("reference_datasets", []):
        path = Path(reference)
        directory = path if path.is_absolute() else ROOT / path
        verify_integrity(directory)
        raw = (directory / "dataset.jsonl").read_bytes()
        rows = [json.loads(line) for line in raw.decode("utf-8").splitlines()]
        infos.append({"path": reference, "sample_count": len(rows), "dataset_sha256": digest(raw),
                      "manifest_sha256": digest((directory / "manifest.json").read_bytes())})
        named_rows.append((reference, rows))
    return infos, named_rows


def check_lock(compiler, lock_path):
    if not lock_path.exists():
        raise ValueError("missing toolchain lock; run doctor --write-lock first")
    locked = read_json(lock_path)
    current = compiler.identity()
    if locked != current:
        differing = sorted(key for key in locked.keys() | current.keys() if locked.get(key) != current.get(key))
        raise ValueError(f"toolchain lock mismatch: {differing}; use a separate lock for a new profile")
    return locked


def inventory(directory):
    return {str(path.relative_to(directory)): digest(path.read_bytes())
            for path in sorted(directory.rglob("*")) if path.is_file() and path.name != "manifest.json"}


def generate(config_path, output, compiler, lock_path, progress=print):
    config = load_config(config_path)
    lock = check_lock(compiler, lock_path)
    output = output.absolute()
    if output.exists():
        raise ValueError(f"output already exists; choose a new path: {output}")
    output.parent.mkdir(parents=True, exist_ok=True)
    stage = Path(tempfile.mkdtemp(prefix=output.name + ".work-", dir=output.parent))
    try:
        with tempfile.TemporaryDirectory(prefix="c-llvm-preflight-") as tmp:
            compiler.preflight(Path(tmp))
        write_json(stage / "config.json", config)
        write_json(stage / "toolchain.lock.json", lock)
        (stage / "samples").mkdir()
        rows, validations, rejections = [], [], []
        seen_structures, seen_c = set(), set()
        reference_infos, reference_rows = load_references(config)
        ref_structures = {row["structure_id"] for _, rows in reference_rows for row in rows}
        ref_sources = {row["source_sha256"] for _, rows in reference_rows for row in rows}
        ref_irs = {row["ir_sha256"] for _, rows in reference_rows for row in rows}
        seen_irs = set()
        ref_ids = {row["id"] for _, rows in reference_rows for row in rows}
        prefix = config.get("id_prefix", "")
        for category in CATEGORIES:
            accepted = 0
            for attempt in range(config["max_attempts_per_category"]):
                if accepted == config["categories"][category]:
                    break
                sample_id = f"{prefix}{category}-{accepted:03d}"
                if sample_id in ref_ids:
                    raise ValueError(f"sample ID collides with a reference dataset: {sample_id}")
                program = generate_program(config["seed"], category, attempt)
                validate_ast(program)
                structure = structure_id(program)
                source = render_c(program)
                reason = None
                if structure in seen_structures or digest(source) in seen_c:
                    reason = "duplicate_structure_or_source"
                elif structure in ref_structures:
                    reason = "duplicate_structure_in_reference_dataset"
                elif digest(source) in ref_sources:
                    reason = "duplicate_source_in_reference_dataset"
                if reason is None:
                    try:
                        records, coverage = generate_inputs(program, config, sample_id)
                    except ValueError as error:
                        reason = str(error)
                if reason:
                    rejections.append({"category": category, "attempt": attempt, "reason": reason,
                                       "ast_sha256": digest(canonical_json(program)), "ast": program})
                    continue
                sample_dir = stage / "samples" / sample_id
                sample_dir.mkdir()
                (sample_dir / "source.c").write_text(source, encoding="utf-8", newline="\n")
                write_json(sample_dir / "ast.json", program)
                write_json(sample_dir / "inputs.json", records)
                try:
                    with tempfile.TemporaryDirectory(prefix="c-llvm-compile-") as tmp:
                        work = Path(tmp)
                        (work / "source.c").write_text(source, encoding="utf-8", newline="\n")
                        ir = compiler.emit_ir(work)
                        if digest(ir) in seen_irs or digest(ir) in ref_irs:
                            # Different sources can fold to the same IR (e.g. `acc ^ (1u >> 5u)` and `acc ^ (1u & 2u)`).
                            ir_duplicate = True
                        else:
                            ir_duplicate = False
                            compiler.verify_ir(work)
                        executions = None if ir_duplicate else compiler.check_execution(work, records)
                        if not ir_duplicate:
                            (sample_dir / "module.ll").write_text(ir, encoding="utf-8", newline="\n")
                except ToolFailure as error:
                    # Tool or semantic failures indicate an invariant violation. Never resample them away.
                    write_json(sample_dir / "failure.json", {"error": str(error)})
                    raise
                if ir_duplicate:
                    shutil.rmtree(sample_dir)
                    rejections.append({"category": category, "attempt": attempt, "reason": "duplicate_ir",
                                       "ast_sha256": digest(canonical_json(program)), "ast": program})
                    continue
                validation = {"id": sample_id, "category": category, "status": "passed",
                              "ast_valid": True, "llvm_verifier_passed": True, "coverage": coverage,
                              "input_count": len(records), "executions": executions,
                              "source_sha256": digest(source), "ir_sha256": digest(ir),
                              "structure_id": structure, "candidate_attempt": attempt}
                write_json(sample_dir / "validation.json", validation)
                prompt = ("Compile this C11 function to LLVM IR. Return only the complete LLVM IR module.\n"
                          f"Target: {compiler.target}\nOptimization: O0\n\n{source}")
                rows.append({"id": sample_id, "category": category, "structure_id": structure,
                             "prompt": prompt, "completion": ir, "c_source": source,
                             "source_sha256": digest(source), "ir_sha256": digest(ir),
                             "sample_path": f"samples/{sample_id}", "target": compiler.target,
                             "candidate_attempt": attempt})
                validations.append(validation)
                seen_structures.add(structure)
                seen_c.add(digest(source))
                seen_irs.add(digest(ir))
                accepted += 1
                if accepted % 5 == 0 or accepted == config["categories"][category]:
                    progress(f"{category}: {accepted}/{config['categories'][category]} verified", flush=True)
            if accepted != config["categories"][category]:
                raise ValueError(f"candidate limit exceeded for {category}: {accepted} accepted")
        (stage / "dataset.jsonl").write_text("".join(canonical_json(row) for row in rows), encoding="utf-8", newline="\n")
        cross_run = None
        if reference_rows:
            cross_run = duplicate_check_summary(assert_no_duplicates([("<new>", rows), *reference_rows]), reference_infos)
        total_inputs = sum(item["input_count"] for item in validations)
        report = {"status": "passed", "sample_count": len(rows), "category_counts": dict(Counter(row["category"] for row in rows)),
                  "input_pair_count": total_inputs, "executable_comparison_count": total_inputs * 3,
                  "rejected_candidate_count": len(rejections), "unique_structure_count": len(seen_structures),
                  "execution_profile": "native-host", "target": compiler.target,
                  "verification_scope": "LLVM structural verification and finite execution testing; not a proof of equivalence",
                  "control_coverage_scope": "AST interpreter traces; not native binary instrumentation",
                  "samples": validations}
        if cross_run:
            report["cross_run_duplicate_check"] = cross_run
        write_json(stage / "validation.json", report)
        write_json(stage / "rejections.json", rejections)
        manifest = {"schema_version": 1, "config_sha256": digest(canonical_json(config)),
                    "toolchain_sha256": digest(canonical_json(lock)), "pipeline_sources": source_hashes(),
                    "sample_count": len(rows), "files": inventory(stage)}
        if reference_infos:
            manifest["reference_datasets"] = reference_infos
        write_json(stage / "manifest.json", manifest)
        verify_integrity(stage)
        stage.rename(output)
        return report
    except BaseException:
        progress(f"Generation failed; partial evidence retained at {stage}", flush=True)
        raise


def duplicate_check_summary(report, reference_infos):
    return {"status": "passed", "keys_checked": ["id", "source_sha256", "structure_id", "ir_sha256", "source+ir pair"],
            "row_count": report["row_count"], "collision_counts": report["collision_counts"],
            "reference_datasets": reference_infos}


def verify_integrity(directory):
    directory = directory.absolute()
    manifest = read_json(directory / "manifest.json")
    if inventory(directory) != manifest["files"]:
        raise ValueError("dataset file integrity check failed")
    config = load_config(directory / "config.json")
    if digest(canonical_json(config)) != manifest["config_sha256"]:
        raise ValueError("configuration digest mismatch")
    if digest(canonical_json(read_json(directory / "toolchain.lock.json"))) != manifest["toolchain_sha256"]:
        raise ValueError("toolchain digest mismatch")
    rows = [json.loads(line) for line in (directory / "dataset.jsonl").read_text().splitlines()]
    if len(rows) != sum(config["categories"].values()) or len(rows) != manifest["sample_count"]:
        raise ValueError("dataset row count mismatch")
    if dict(Counter(row["category"] for row in rows)) != config["categories"]:
        raise ValueError("dataset category counts mismatch")
    if len({row["id"] for row in rows}) != len(rows) or len({row["structure_id"] for row in rows}) != len(rows):
        raise ValueError("duplicate sample ID or structure")
    if config.get("reference_datasets"):
        infos, reference_rows = load_references(config)
        if infos != manifest.get("reference_datasets"):
            raise ValueError("reference dataset changed since generation")
        assert_no_duplicates([("<new>", rows), *reference_rows])
    report = read_json(directory / "validation.json")
    if report["status"] != "passed" or report["sample_count"] != len(rows):
        raise ValueError("invalid validation report")
    for row in rows:
        sample = directory / row["sample_path"]
        if sample.parent != directory / "samples" or sample.name != row["id"]:
            raise ValueError("unsafe or unexpected sample path")
        source, ir = (sample / "source.c").read_text(), (sample / "module.ll").read_text()
        if digest(source) != row["source_sha256"] or digest(ir) != row["ir_sha256"]:
            raise ValueError("row content digest mismatch")
        if source != row["c_source"] or ir != row["completion"]:
            raise ValueError("training row differs from validated files")
        program = read_json(sample / "ast.json")
        validate_ast(program)
        if render_c(program) != source or structure_id(program) != row["structure_id"]:
            raise ValueError("AST/source/structure mismatch")
        records = read_json(sample / "inputs.json")
        for record in records:
            from .model import execute
            expected, trace = execute(program, record["x"], record["y"])
            if expected != record["expected"] or sorted(trace) != record["oracle_trace"]:
                raise ValueError("stored expected result or trace differs from interpreter")
        checked = read_json(sample / "validation.json")
        if checked["status"] != "passed" or checked["input_count"] != len(records):
            raise ValueError("invalid per-sample validation")
    return {"status": "passed", "sample_count": len(rows), "file_count": len(manifest["files"])}


def revalidate(directory, compiler):
    result = verify_integrity(directory)
    check_lock(compiler, directory / "toolchain.lock.json")
    with tempfile.TemporaryDirectory(prefix="c-llvm-preflight-") as tmp:
        compiler.preflight(Path(tmp))
    rows = [json.loads(line) for line in (directory / "dataset.jsonl").read_text().splitlines()]
    for row in rows:
        sample = directory / row["sample_path"]
        with tempfile.TemporaryDirectory(prefix="c-llvm-revalidate-") as tmp:
            work = Path(tmp)
            shutil.copyfile(sample / "source.c", work / "source.c")
            shutil.copyfile(sample / "module.ll", work / "module.ll")
            compiler.verify_ir(work)
            results = compiler.check_execution(work, read_json(sample / "inputs.json"))
            if results != read_json(sample / "validation.json")["executions"]:
                raise ValueError("execution revalidation report mismatch")
    return {**result, "execution_revalidated": True}


def compare(left, right):
    verify_integrity(left)
    verify_integrity(right)
    files_left = {**inventory(left), "manifest.json": digest((left / "manifest.json").read_bytes())}
    files_right = {**inventory(right), "manifest.json": digest((right / "manifest.json").read_bytes())}
    if files_left != files_right:
        changed = sorted(key for key in files_left.keys() | files_right.keys() if files_left.get(key) != files_right.get(key))
        raise ValueError(f"reproducibility mismatch: {changed[:20]}")
    return {"status": "identical", "file_count": len(files_left),
            "dataset_sha256": files_left["dataset.jsonl"], "manifest_sha256": files_left["manifest.json"]}
