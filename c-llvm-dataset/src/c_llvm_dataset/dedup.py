"""Cross-run duplicate detection over verified dataset rows (pure functions, no tool access)."""
from __future__ import annotations

from collections import defaultdict

# Each key is a different notion of "the same sample". All must be unique across every dataset in a corpus.
KEYS = ("id", "source_sha256", "structure_id", "ir_sha256", "pair")


def _key(row, name):
    if name == "pair":
        return (row["source_sha256"], row["ir_sha256"])
    return row[name]


def duplicate_report(named_rows):
    """named_rows: list of (dataset_name, rows). Returns collisions per key, within and across datasets."""
    seen = {name: defaultdict(list) for name in KEYS}
    total = 0
    for dataset, rows in named_rows:
        for row in rows:
            total += 1
            for name in KEYS:
                seen[name][_key(row, name)].append((dataset, row["id"]))
    collisions = {}
    for name in KEYS:
        groups = [{"key": list(key) if isinstance(key, tuple) else key, "members": members}
                  for key, members in sorted(seen[name].items(), key=lambda item: str(item[0])) if len(members) > 1]
        collisions[name] = groups
    return {"row_count": total, "datasets": [name for name, _ in named_rows],
            "collision_counts": {name: len(groups) for name, groups in collisions.items()},
            "collisions": collisions,
            "passed": not any(collisions.values())}


def assert_no_duplicates(named_rows):
    report = duplicate_report(named_rows)
    if not report["passed"]:
        counts = {name: n for name, n in report["collision_counts"].items() if n}
        raise ValueError(f"duplicate samples across datasets: {counts}")
    return report
