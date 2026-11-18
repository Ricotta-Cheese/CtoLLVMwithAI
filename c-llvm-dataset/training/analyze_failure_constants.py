"""Break down the 36 frozen-test execution failures by category, diff type,
folded constants and partial input agreement.

Reads the existing analysis.json, teacher diffs and corpus; writes
training/evaluations/qwen3-test-002/failure-breakdown.json.

"Folded constant" heuristic: a numeric literal that appears in the teacher IR
lines removed by the diff, is missing from the generated lines, and whose
uint32 value is not written as a `<n>u` literal in the C source. Such values
exist only because Clang evaluates constant subexpressions even at -O0, so the
model has to compute them. This is a heuristic description, not a proof of
cause.

Run from c-llvm-dataset: python3 training/analyze_failure_constants.py
"""
import collections
import json
import re
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
EVAL = ROOT / "training/evaluations/qwen3-test-002"
CATEGORIES = ["arithmetic", "bitwise", "branch", "loop", "combined"]
SKIP = ("target", "attributes", "!")


def literals(lines):
    found = collections.Counter()
    for line in lines:
        line = re.sub(r"%[\w.]+", "", line)
        line = re.sub(r"align \d+|\bi(1|8|32|64)\b", "", line)
        found.update(int(x) for x in re.findall(r"(?<![\w.])-?\d+(?![\w.])", line))
    return found


def changed(diff_lines, sign):
    return [
        line[1:]
        for line in diff_lines
        if line.startswith(sign)
        and not line.startswith(sign * 3)
        and not any(token in line for token in SKIP)
    ]


def main():
    analysis = json.loads((EVAL / "analysis.json").read_text())
    diff_type = {i: k for k, ids in analysis["semantic_diff_groups"].items() for i in ids}
    sources = {}
    with open(ROOT / "corpus-1100-v001/dataset.jsonl") as handle:
        for row in handle:
            record = json.loads(row)
            sources[record["id"]] = record["c_source"]

    by_category = {c: collections.Counter() for c in CATEGORIES}
    functions = []
    for failure in analysis["failures"]:
        category = failure["category"]
        if failure["stage"] != "execute":
            by_category[category]["llvm_verify_failed"] += 1
            continue
        diff = (EVAL / "teacher-diffs" / f"{failure['id']}.diff").read_text().splitlines()
        missing = list(literals(changed(diff, "-")) - literals(changed(diff, "+")))
        in_source = {int(x) for x in re.findall(r"(\d+)u", sources[failure["id"]])}
        folded = sorted(x for x in missing if x % 2**32 not in in_source)
        kind = diff_type[failure["id"]]
        by_category[category][kind] += 1
        functions.append(
            {
                "id": failure["id"],
                "category": category,
                "diff_type": kind,
                "matching_inputs": failure["matching_inputs"],
                "missing_teacher_literals": sorted(missing),
                "folded_constants": folded,
            }
        )

    matching = [f["matching_inputs"] for f in functions]
    report = {
        "execution_failures": len(functions),
        "by_category": {c: dict(by_category[c]) for c in CATEGORIES},
        "involves_folded_constant": sum(1 for f in functions if f["folded_constants"]),
        "matching_inputs": {
            "zero": sum(1 for m in matching if m == 0),
            "at_least_half": sum(1 for m in matching if m >= 128),
            "at_least_200": sum(1 for m in matching if m >= 200),
            "of": 256,
        },
        "heuristic": " ".join(__doc__.split("\n\n")[2].split()),
        "functions": functions,
    }
    out = EVAL / "failure-breakdown.json"
    out.write_text(json.dumps(report, ensure_ascii=False, indent=2) + "\n")
    print(json.dumps({k: v for k, v in report.items() if k != "functions"}, indent=2))


if __name__ == "__main__":
    main()
