"""Deterministic AST candidates and boundary/random/control-witness inputs."""
from .model import MASK, StableRandom, binary, const, evaluate, execute, required_coverage, var


def generate_program(seed, category, attempt):
    rng = StableRandom(f"{seed}:program:{category}:{attempt}")

    def expression(variables, ops, depth):
        if depth == 0 or rng.below(5) == 0:
            if rng.below(4) == 0:
                return const(rng.choice((0, 1, 2, 3, 7, 15, 16, 31, MASK, rng.bits32())))
            return var(rng.choice(variables))
        op = rng.choice(ops)
        left = expression(variables, ops, depth - 1)
        right = const(rng.below(32)) if op in ("<<", ">>") else expression(variables, ops, depth - 1)
        return binary(op, left, right)

    def assignment(value):
        return {"kind": "assign", "name": "acc", "value": value}

    arithmetic = ("+", "-", "*")
    bitwise = ("&", "|", "^", "<<", ">>")
    mixed = arithmetic + bitwise
    initial_ops = bitwise if category == "bitwise" else arithmetic
    body = [assignment(binary(rng.choice(initial_ops[:3]), var("x"), var("y")))]

    def update(ops, variables=("x", "y", "acc")):
        return assignment(binary(rng.choice(ops), var("acc"), expression(variables, ops, 1 + rng.below(3)))) if ops == arithmetic else assignment(
            binary("^", var("acc"), expression(variables, ops, 1 + rng.below(3)))
        )

    def branch(identifier, variables=("x", "y", "acc")):
        tested = binary("^", var("x"), var("y"))
        if "i" in variables:
            tested = binary("^", tested, var("i"))
        condition = binary("==", binary("&", tested, const(1 << rng.below(32))), const(0))
        return {"kind": "if", "id": identifier, "condition": condition,
                "then": [update(mixed, variables) for _ in range(1 + rng.below(2))],
                "else": [update(mixed, variables) for _ in range(1 + rng.below(2))]}

    if category in ("arithmetic", "bitwise"):
        ops = arithmetic if category == "arithmetic" else bitwise
        body.extend(update(ops) for _ in range(1 + rng.below(4)))
    elif category == "branch":
        body.append(branch("branch0"))
        body.append(update(mixed))
    elif category in ("loop", "combined"):
        count = binary("+", binary("&", var("x"), const(15)), binary("&", var("y"), const(1)))
        variables = ("x", "y", "acc", "i")
        inner = [update(mixed, variables) for _ in range(1 + rng.below(3))]
        if category == "combined":
            inner.append(branch("branch0", variables))
        body.append({"kind": "loop", "id": "loop0", "count": count, "body": inner})
        if category == "combined":
            body.append(branch("branch1"))
    else:
        raise ValueError(f"unknown category: {category}")
    return {"body": body, "return": var("acc")}


def generate_inputs(program, config, sample_id):
    pairs = [(x, y) for x in config["edge_values"] for y in config["edge_values"]]
    rng = StableRandom(f"{config['seed']}:inputs:{sample_id}")
    seen = set(pairs)
    random_count = 0
    while random_count < config["random_inputs"]:
        pair = (rng.bits32(), rng.bits32())
        if pair not in seen:
            pairs.append(pair)
            seen.add(pair)
            random_count += 1
    covered = set()
    records = []
    for index, (x, y) in enumerate(pairs):
        result, trace = execute(program, x, y)
        covered.update(trace)
        records.append({"x": x, "y": y, "expected": result,
                        "origin": "edge" if index < len(config["edge_values"]) ** 2 else "random",
                        "oracle_trace": sorted(trace)})
    required = required_coverage(program)
    witnesses = StableRandom(f"{config['seed']}:witnesses:{sample_id}")
    searched = 0
    while not required <= covered and searched < config["max_witness_search"]:
        searched += 1
        pair = (witnesses.bits32(), witnesses.bits32())
        if pair in seen:
            continue
        result, trace = execute(program, *pair)
        if (required - covered) & trace:
            records.append({"x": pair[0], "y": pair[1], "expected": result,
                            "origin": "witness", "oracle_trace": sorted(trace)})
            seen.add(pair)
            covered.update(trace)
    if not required <= covered:
        raise ValueError(f"missing oracle control coverage: {sorted(required - covered)}")
    if len({record["expected"] for record in records}) < 2:
        raise ValueError("candidate has constant observed output")
    return records, {"required": sorted(required), "observed": sorted(covered),
                     "witness_search_count": searched}
