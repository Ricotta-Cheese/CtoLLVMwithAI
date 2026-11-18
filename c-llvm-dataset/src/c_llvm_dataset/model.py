"""Small, typed uint32 AST and a separate executable semantics."""
from __future__ import annotations

import hashlib
import json

MASK = (1 << 32) - 1
CATEGORIES = ("arithmetic", "bitwise", "branch", "loop", "combined")


def canonical_json(value):
    return json.dumps(value, ensure_ascii=False, sort_keys=True, separators=(",", ":")) + "\n"


def digest(value):
    data = value if isinstance(value, bytes) else value.encode("utf-8")
    return hashlib.sha256(data).hexdigest()


class StableRandom:
    """SHA-256 counter stream, versioned by its domain string; no Python RNG dependency."""
    def __init__(self, seed):
        self.key = str(seed).encode("utf-8")
        self.counter = 0

    def bits32(self):
        block = hashlib.sha256(b"c-llvm-dataset-rng-v1\0" + self.key + b"\0" + str(self.counter).encode()).digest()
        self.counter += 1
        return int.from_bytes(block[:4], "big")

    def below(self, n):
        if not 0 < n <= (1 << 32):
            raise ValueError("invalid RNG bound")
        limit = (1 << 32) - ((1 << 32) % n)
        while True:
            value = self.bits32()
            if value < limit:
                return value % n

    def choice(self, values):
        return values[self.below(len(values))]


def const(value):
    return {"kind": "const", "value": value}


def var(name):
    return {"kind": "var", "name": name}


def binary(op, left, right):
    return {"kind": "binary", "op": op, "left": left, "right": right}


def evaluate(expr, env):
    kind = expr["kind"]
    if kind == "const":
        return expr["value"]
    if kind == "var":
        return env[expr["name"]]
    left, right = evaluate(expr["left"], env), evaluate(expr["right"], env)
    op = expr["op"]
    if op == "+":
        result = left + right
    elif op == "-":
        result = left - right
    elif op == "*":
        result = left * right
    elif op == "&":
        result = left & right
    elif op == "|":
        result = left | right
    elif op == "^":
        result = left ^ right
    elif op == "<<":
        if not 0 <= right < 32:
            raise ValueError("invalid shift")
        result = left << right
    elif op == ">>":
        if not 0 <= right < 32:
            raise ValueError("invalid shift")
        result = left >> right
    elif op == "==":
        result = int(left == right)
    else:
        raise ValueError(f"unsupported operator: {op}")
    return result & MASK


def execute(program, x, y):
    env = {"x": x & MASK, "y": y & MASK}
    trace = set()

    def run(statements):
        for statement in statements:
            kind = statement["kind"]
            if kind == "assign":
                env[statement["name"]] = evaluate(statement["value"], env)
            elif kind == "if":
                result = bool(evaluate(statement["condition"], env))
                trace.add(f"{statement['id']}:{int(result)}")
                run(statement["then"] if result else statement["else"])
            elif kind == "loop":
                count = evaluate(statement["count"], env)
                if count > 16:
                    raise ValueError("loop bound exceeds 16")
                trace.add(f"{statement['id']}:{count}")
                for i in range(count):
                    env["i"] = i
                    run(statement["body"])
                env.pop("i", None)
            else:
                raise ValueError(f"unsupported statement: {kind}")

    run(program["body"])
    return evaluate(program["return"], env), trace


def expression_c(expr):
    if expr["kind"] == "const":
        return f"{expr['value']}u"
    if expr["kind"] == "var":
        return expr["name"]
    left = expression_c(expr["left"])
    if expr["op"] == "^" and expr["left"]["kind"] == "const" \
            and expr["left"]["value"] in (2, 10) and expr["right"]["kind"] == "const":
        # Clang -Wxor-used-as-pow rejects `2u ^ 16u`; a hex left literal has identical value and silences it.
        left = f"0x{expr['left']['value']:X}u"
    return f"({left} {expr['op']} {expression_c(expr['right'])})"


def render_c(program):
    lines = [
        '_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");',
        "unsigned int compute(unsigned int x, unsigned int y) {",
        "    (void)x;",
        "    (void)y;",
    ]

    def emit(statements, level, declared):
        pad = "    " * level
        for stmt in statements:
            if stmt["kind"] == "assign":
                name = stmt["name"]
                prefix = "" if name in declared else "unsigned int "
                lines.append(f"{pad}{prefix}{name} = {expression_c(stmt['value'])};")
                declared.add(name)
            elif stmt["kind"] == "if":
                lines.append(f"{pad}if ({expression_c(stmt['condition'])}) {{")
                emit(stmt["then"], level + 1, set(declared))
                lines.append(f"{pad}}} else {{")
                emit(stmt["else"], level + 1, set(declared))
                lines.append(f"{pad}}}")
            else:
                lines.append(f"{pad}for (unsigned int i = 0u; i < {expression_c(stmt['count'])}; ++i) {{")
                emit(stmt["body"], level + 1, declared | {"i"})
                lines.append(f"{pad}}}")

    emit(program["body"], 1, {"x", "y"})
    lines += [f"    return {expression_c(program['return'])};", "}"]
    return "\n".join(lines) + "\n"


def validate_ast(program):
    """Reject unsafe/out-of-subset trees before C emission, including definite assignment."""
    if set(program) != {"body", "return"}:
        raise ValueError("invalid program fields")
    ids = set()

    def expr(node, scope, depth=0):
        if depth > 12:
            raise ValueError("expression too deep")
        if node["kind"] == "const":
            if type(node["value"]) is not int or not 0 <= node["value"] <= MASK:
                raise ValueError("constant outside uint32")
        elif node["kind"] == "var":
            if node["name"] not in scope:
                raise ValueError("read before initialization")
        elif node["kind"] == "binary":
            if node["op"] not in ("+", "-", "*", "&", "|", "^", "<<", ">>", "=="):
                raise ValueError("unsupported operator")
            expr(node["left"], scope, depth + 1)
            expr(node["right"], scope, depth + 1)
            if node["op"] in ("<<", ">>") and not (
                node["right"]["kind"] == "const" and 0 <= node["right"]["value"] <= 31
            ):
                raise ValueError("shift must use a safe constant")
        else:
            raise ValueError("unsupported expression")

    expected_count = binary("+", binary("&", var("x"), const(15)), binary("&", var("y"), const(1)))

    def statements(body, scope, in_loop=False):
        for stmt in body:
            kind = stmt["kind"]
            if kind == "assign":
                if stmt["name"] != "acc":
                    raise ValueError("only accumulator assignment is allowed")
                expr(stmt["value"], scope)
                scope.add(stmt["name"])
            elif kind in ("if", "loop"):
                if stmt["id"] in ids:
                    raise ValueError("duplicate control ID")
                ids.add(stmt["id"])
                if kind == "if":
                    expr(stmt["condition"], scope)
                    statements(stmt["then"], set(scope), in_loop)
                    statements(stmt["else"], set(scope), in_loop)
                else:
                    if in_loop or stmt["count"] != expected_count:
                        raise ValueError("loop must use the fixed safe bound")
                    statements(stmt["body"], scope | {"i"}, True)
            else:
                raise ValueError("unsupported statement")

    scope = {"x", "y"}
    statements(program["body"], scope)
    expr(program["return"], scope)


def structure_id(program):
    """Group constant/identifier variants; keep operators and statement structure."""
    def shape(value):
        if isinstance(value, dict):
            if value.get("kind") == "const":
                return {"kind": "const"}
            if value.get("kind") == "var":
                return {"kind": "var"}
            return {key: shape(item) for key, item in value.items() if key not in ("id", "name")}
        if isinstance(value, list):
            return [shape(item) for item in value]
        return value
    return digest(canonical_json(shape(program)))


def required_coverage(program):
    events = set()
    def visit(body):
        for stmt in body:
            if stmt["kind"] == "if":
                events.update((f"{stmt['id']}:0", f"{stmt['id']}:1"))
                visit(stmt["then"])
                visit(stmt["else"])
            elif stmt["kind"] == "loop":
                events.update(f"{stmt['id']}:{n}" for n in (0, 1, 16))
                visit(stmt["body"])
    visit(program["body"])
    return events
