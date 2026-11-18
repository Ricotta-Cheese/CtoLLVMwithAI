import copy
import json
from pathlib import Path
import shutil
import subprocess
import sys
import tempfile
import unittest

sys.path.insert(0, str(Path(__file__).resolve().parents[1] / "src"))
from c_llvm_dataset.compiler import Compiler, ToolFailure, run_command
from c_llvm_dataset.generator import generate_inputs, generate_program
from c_llvm_dataset.model import (
    MASK, StableRandom, binary, canonical_json, const, evaluate, execute,
    render_c, required_coverage, structure_id, validate_ast, var,
)
from c_llvm_dataset.corpus import combine, split_by_structure, verify_corpus
from c_llvm_dataset.dedup import duplicate_report
from c_llvm_dataset.pipeline import ROOT, compare, generate, load_config, read_json, verify_integrity, write_json


class Uint32SemanticsTests(unittest.TestCase):
    def test_hand_calculated_boundary_operations(self):
        # Expected results are literals, not recomputed by a copy of the implementation.
        cases = [
            ("+", MASK, 1, 0), ("-", 0, 1, MASK), ("*", MASK, MASK, 1),
            ("*", 2147483648, 2, 0), (">>", MASK, 31, 1),
            ("<<", 1, 31, 2147483648), ("<<", 2147483648, 1, 0),
            ("^", 0xAAAAAAAA, 0x55555555, MASK), ("&", MASK, 15, 15),
            ("|", 0x80000000, 1, 0x80000001), ("==", 4, 4, 1), ("==", 4, 5, 0),
        ]
        for op, x, y, expected in cases:
            with self.subTest(op=op, x=x, y=y):
                self.assertEqual(evaluate(binary(op, const(x), const(y)), {}), expected)

    def test_literal_xor_rendering_avoids_clang_pow_warning(self):
        program = {"body": [{"kind": "assign", "name": "acc", "value": binary("^", const(2), const(16))}], "return": var("acc")}
        self.assertIn("(0x2u ^ 16u)", render_c(program))
        self.assertEqual(evaluate(binary("^", const(2), const(16)), {}), 18)

    def test_intermediate_overflow_before_right_shift(self):
        tree = binary(">>", binary("+", const(MASK), const(1)), const(1))
        self.assertEqual(evaluate(tree, {}), 0)

    def test_reads_before_initialization_and_unsafe_shifts_rejected(self):
        for expr in (var("acc"), binary("<<", var("x"), const(32)),
                     binary(">>", var("x"), var("y")), const(-1)):
            with self.subTest(expr=expr), self.assertRaises(ValueError):
                validate_ast({"body": [], "return": expr})

    def test_hand_calculated_loop_outputs(self):
        program = {
            "body": [{"kind": "assign", "name": "acc", "value": const(0)},
                     {"kind": "loop", "id": "loop0",
                      "count": binary("+", binary("&", var("x"), const(15)), binary("&", var("y"), const(1))),
                      "body": [{"kind": "assign", "name": "acc", "value": binary("+", var("acc"), var("i"))}]}],
            "return": var("acc"),
        }
        validate_ast(program)
        for x, y, expected, count in ((0, 0, 0, 0), (0, 1, 0, 1), (15, 1, 120, 16)):
            result, trace = execute(program, x, y)
            self.assertEqual(result, expected)
            self.assertIn(f"loop0:{count}", trace)

    def test_structural_grouping_ignores_constant_variants(self):
        one = {"body": [], "return": binary("+", var("x"), const(7))}
        two = {"body": [], "return": binary("+", var("y"), const(99))}
        three = {"body": [], "return": binary("*", var("y"), const(99))}
        self.assertEqual(structure_id(one), structure_id(two))
        self.assertNotEqual(structure_id(one), structure_id(three))

    def test_rng_has_stable_stream_and_separate_domains(self):
        one, two = StableRandom("sample"), StableRandom("sample")
        first = [one.bits32() for _ in range(10)]
        self.assertEqual(first, [two.bits32() for _ in range(10)])
        self.assertNotEqual(first, [StableRandom(str(i)).bits32() for i in range(10)])

    def test_generated_inputs_cover_control_boundaries(self):
        config = load_config(ROOT / "config.json")
        for category in config["categories"]:
            program = generate_program(config["seed"], category, 0)
            validate_ast(program)
            records, coverage = generate_inputs(program, config, category)
            self.assertGreaterEqual(len(records), 256)
            self.assertEqual(len(records), len({(r["x"], r["y"]) for r in records}))
            self.assertTrue(required_coverage(program) <= set(coverage["observed"]))
            self.assertEqual(sum(r["origin"] == "edge" for r in records), 64)
            self.assertEqual(sum(r["origin"] == "random" for r in records), 192)
            self.assertEqual(program, generate_program(config["seed"], category, 0))


class CrossRunDuplicateTests(unittest.TestCase):
    @staticmethod
    def row(identifier, category="loop", structure="s", source="a", ir="i"):
        return {"id": identifier, "category": category, "structure_id": structure,
                "source_sha256": source, "ir_sha256": ir}

    def test_detects_every_kind_of_cross_dataset_collision(self):
        base = [self.row("one", structure="s1", source="a1", ir="i1")]
        for field, other in (("id", self.row("one", structure="s2", source="a2", ir="i2")),
                             ("structure_id", self.row("two", structure="s1", source="a2", ir="i2")),
                             ("source_sha256", self.row("two", structure="s2", source="a1", ir="i2")),
                             ("ir_sha256", self.row("two", structure="s2", source="a2", ir="i1")),
                             ("pair", self.row("two", structure="s1", source="a1", ir="i1"))):
            with self.subTest(field=field):
                report = duplicate_report([("base", base), ("new", [other])])
                self.assertFalse(report["passed"])
                self.assertEqual(report["collision_counts"][field], 1)
        clean = duplicate_report([("base", base), ("new", [self.row("two", structure="s2", source="a2", ir="i2")])])
        self.assertTrue(clean["passed"])

    def test_config_rejects_bad_prefix_and_reference_list(self):
        for patch in ({"id_prefix": "Bad_"}, {"reference_datasets": "artifacts"}, {"reference_datasets": ["a", "a"]}):
            config = {**load_config(ROOT / "config.json"), **patch}
            path = Path(tempfile.mkdtemp()) / "c.json"
            write_json(path, config)
            with self.subTest(patch=patch), self.assertRaises(ValueError):
                load_config(path)

    def test_structure_split_is_deterministic_and_group_disjoint(self):
        rows = [{"id": f"{c}-{i}", "category": c, "structure_id": f"{c}{i:03d}"}
                for c in ("arithmetic", "bitwise", "branch", "loop", "combined") for i in range(20)]
        one, two = split_by_structure(rows, 7), split_by_structure(list(reversed(rows)), 7)
        self.assertEqual({k: [r["id"] for r in v] for k, v in one.items()}, {k: [r["id"] for r in v] for k, v in two.items()})
        self.assertEqual({k: len(v) for k, v in one.items()}, {"train": 80, "validation": 10, "test": 10})
        self.assertEqual(len({r["id"] for v in one.values() for r in v}), 100)


@unittest.skipUnless(shutil.which("clang"), "Clang required for integration checks")
class CompilerIntegrationTests(unittest.TestCase):
    @classmethod
    def setUpClass(cls):
        cls.compiler = Compiler()
        cls.tmp = tempfile.TemporaryDirectory(prefix="c-llvm-test-")
        cls.root = Path(cls.tmp.name)
        write_json(cls.root / "toolchain.lock.json", cls.compiler.identity())

    @classmethod
    def tearDownClass(cls):
        cls.tmp.cleanup()

    def test_preflight_rejects_invalid_ssa_and_checks_ubsan(self):
        with tempfile.TemporaryDirectory() as tmp:
            self.compiler.preflight(Path(tmp))

    def test_wrong_expected_output_fails_execution(self):
        with tempfile.TemporaryDirectory() as tmp:
            work = Path(tmp)
            (work / "source.c").write_text(
                'unsigned int compute(unsigned int x, unsigned int y) { return x + y; }\n')
            self.compiler.emit_ir(work)
            with self.assertRaisesRegex(ToolFailure, "execution mismatch"):
                self.compiler.check_execution(work, [{"x": 1, "y": 2, "expected": 4}])

    def test_ubsan_failure_is_not_treated_as_a_valid_sample(self):
        with tempfile.TemporaryDirectory() as tmp:
            work = Path(tmp)
            (work / "source.c").write_text(
                'unsigned int compute(unsigned int x, unsigned int y) {\n'
                '  unsigned int z = 1u << (y & 31u);\n'
                '  int *p = (int *)(void *)&z;\n'
                '  *p += (int)x;\n'
                '  return z;\n}\n')
            self.compiler.emit_ir(work)
            # O0/IR both produce this value, but the sanitizer must stop on signed overflow.
            with self.assertRaisesRegex(ToolFailure, "overflow"):
                self.compiler.check_execution(work, [{"x": 1, "y": 31, "expected": 2147483649},
                                                     {"x": 2147483647, "y": 0, "expected": 2147483648}])

    def test_timeout_fails_closed(self):
        with self.assertRaises(ToolFailure):
            run_command([sys.executable, "-c", "import time; time.sleep(2)"], self.root, timeout=0.05)

    def test_end_to_end_reproducibility_tampering_and_lock_mismatch(self):
        config = load_config(ROOT / "config.json")
        config["categories"] = {category: 1 for category in config["categories"]}
        config_path = self.root / "small.json"
        write_json(config_path, config)
        lock_path = self.root / "toolchain.lock.json"
        for name in ("first", "different-parent/second"):
            result = generate(config_path, self.root / name, self.compiler, lock_path, progress=lambda *a, **k: None)
            self.assertEqual(result["sample_count"], 5)
        left, right = self.root / "first", self.root / "different-parent/second"
        self.assertEqual(compare(left, right)["status"], "identical")
        with self.assertRaisesRegex(ValueError, "output already exists"):
            generate(config_path, left, self.compiler, lock_path)
        sample = next((right / "samples").glob("*/module.ll"))
        sample.write_text(sample.read_text() + "; tampered\n")
        with self.assertRaisesRegex(ValueError, "integrity"):
            verify_integrity(right)
        lock = read_json(lock_path)
        lock["target"] = "wrong-target"
        changed_lock = self.root / "wrong.lock.json"
        write_json(changed_lock, lock)
        with self.assertRaisesRegex(ValueError, "lock mismatch"):
            generate(config_path, self.root / "should-not-exist", self.compiler, changed_lock)
        self.assertFalse((self.root / "should-not-exist").exists())

    def test_extension_rejects_reference_duplicates_and_combines_without_moving_tests(self):
        config = load_config(ROOT / "config.json")
        config["categories"] = {category: 10 for category in config["categories"]}
        base_config = self.root / "base.json"
        write_json(base_config, config)
        lock_path = self.root / "toolchain.lock.json"
        quiet = lambda *a, **k: None
        base = self.root / "ref-base"
        generate(base_config, base, self.compiler, lock_path, progress=quiet)
        extension_config = {**config, "seed": config["seed"] + 1, "id_prefix": "ext-", "reference_datasets": [str(base)]}
        extension_path = self.root / "extension.json"
        write_json(extension_path, extension_config)
        extension = self.root / "ref-extension"
        report = generate(extension_path, extension, self.compiler, lock_path, progress=quiet)
        self.assertEqual(report["cross_run_duplicate_check"]["collision_counts"]["structure_id"], 0)
        self.assertTrue(all(sample["id"].startswith("ext-") for sample in report["samples"]))
        # Re-using the base seed produces the base programs again; all must be rejected as reference duplicates.
        clash_path = self.root / "clash.json"
        write_json(clash_path, {**extension_config, "seed": config["seed"], "max_attempts_per_category": 20})
        with self.assertRaisesRegex(ValueError, "candidate limit exceeded"):
            generate(clash_path, self.root / "clash", self.compiler, lock_path, progress=quiet)
        base_splits = {name: [r["id"] for r in rows] for name, rows in split_by_structure(
            [json.loads(line) for line in (base / "dataset.jsonl").read_text().splitlines()], 5).items()}
        splits_path = self.root / "base-splits.json"
        write_json(splits_path, base_splits)
        corpus = self.root / "corpus"
        combine(base, splits_path, extension, corpus, 5, progress=quiet)
        self.assertEqual(verify_corpus(corpus)["sample_count"], 100)
        merged = read_json(corpus / "splits.json")
        for name in base_splits:
            self.assertEqual(merged[name][:len(base_splits[name])], base_splits[name])
        tampered = (corpus / "dataset.jsonl")
        tampered.write_text(tampered.read_text() + "\n")
        with self.assertRaisesRegex(ValueError, "integrity"):
            verify_corpus(corpus)


if __name__ == "__main__":
    unittest.main()
