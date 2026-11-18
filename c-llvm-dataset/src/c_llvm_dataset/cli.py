from __future__ import annotations

import argparse
import json
from pathlib import Path
import tempfile

from .compiler import Compiler, ToolFailure
from .corpus import combine, verify_corpus
from .dedup import duplicate_report
from .model import canonical_json
from .pipeline import ROOT, compare, generate, load_config, read_json, revalidate, verify_integrity, write_json


def main(argv=None):
    parser = argparse.ArgumentParser(description="Generate and verify a deterministic C/LLVM IR pilot corpus")
    parser.add_argument("--clang", default="clang", help="Clang executable; use the same build as the lock")
    commands = parser.add_subparsers(dest="command", required=True)
    doctor = commands.add_parser("doctor", help="test compiler, verifier negative control and UBSan")
    doctor.add_argument("--write-lock", action="store_true")
    doctor.add_argument("--lock", type=Path, default=ROOT / "toolchain.lock.json")
    build = commands.add_parser("generate")
    build.add_argument("--config", type=Path, default=ROOT / "config.json")
    build.add_argument("--lock", type=Path, default=ROOT / "toolchain.lock.json")
    build.add_argument("--output", type=Path, default=ROOT / "artifacts")
    check = commands.add_parser("validate")
    check.add_argument("directory", type=Path)
    check.add_argument("--execute", action="store_true", help="also recompile and rerun every saved pair")
    diff = commands.add_parser("compare")
    diff.add_argument("left", type=Path)
    diff.add_argument("right", type=Path)
    dup = commands.add_parser("check-duplicates", help="check IDs, sources, structures, IR and pairs across datasets")
    dup.add_argument("directories", type=Path, nargs="+")
    merge = commands.add_parser("combine", help="combine a base and extension dataset with structure-grouped splits")
    merge.add_argument("--base", type=Path, required=True)
    merge.add_argument("--base-splits", type=Path, required=True)
    merge.add_argument("--extension", type=Path, required=True)
    merge.add_argument("--output", type=Path, required=True)
    merge.add_argument("--split-seed", type=int, required=True)
    merge.add_argument("--execute", action="store_true", help="recompile and rerun every pair in both datasets first")
    corpus = commands.add_parser("validate-corpus")
    corpus.add_argument("directory", type=Path)
    args = parser.parse_args(argv)
    try:
        if args.command == "doctor":
            compiler = Compiler(args.clang)
            with tempfile.TemporaryDirectory(prefix="c-llvm-doctor-") as tmp:
                compiler.preflight(Path(tmp))
            identity = compiler.identity()
            if args.write_lock:
                if args.lock.exists():
                    raise ValueError("lock exists; choose a new lock path instead of overwriting")
                write_json(args.lock, identity)
            result = {"status": "passed", "toolchain": identity,
                      "negative_control": "invalid SSA dominance rejected", "ubsan": "passed"}
        elif args.command == "generate":
            config = load_config(args.config)
            result = generate(args.config, args.output, Compiler(args.clang, config["timeout_seconds"]), args.lock)
            result = {key: value for key, value in result.items() if key != "samples"}
        elif args.command == "validate":
            directory = args.directory.absolute()
            config = load_config(directory / "config.json")
            result = revalidate(directory, Compiler(args.clang, config["timeout_seconds"])) if args.execute else verify_integrity(directory)
        elif args.command == "check-duplicates":
            named = []
            for directory in args.directories:
                directory = directory.absolute()
                verify_integrity(directory)
                named.append((str(directory), [json.loads(line) for line in (directory / "dataset.jsonl").read_text().splitlines()]))
            result = duplicate_report(named)
            if not result["passed"]:
                parser.exit(1, f"error: duplicates found: {result['collision_counts']}\n")
        elif args.command == "combine":
            compiler = None
            if args.execute:
                compiler = Compiler(args.clang, read_json(args.extension.absolute() / "config.json")["timeout_seconds"])
            result = combine(args.base, args.base_splits, args.extension, args.output, args.split_seed, compiler)
        elif args.command == "validate-corpus":
            result = verify_corpus(args.directory)
        else:
            result = compare(args.left.absolute(), args.right.absolute())
    except (ValueError, ToolFailure, FileNotFoundError) as error:
        parser.exit(1, f"error: {error}\n")
    print(canonical_json(result), end="")
