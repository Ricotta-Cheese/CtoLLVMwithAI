"""Clang subprocess boundary, embedded LLVM verifier and executable comparisons."""
from __future__ import annotations

import os
from pathlib import Path
import platform
import re
import shutil
import subprocess
import sys

from .model import digest

C_FLAGS = ["-std=c11", "-Wall", "-Wextra", "-Werror", "-fno-ident", "-fno-discard-value-names"]
IR_FLAGS = ["-O0", "-S", "-emit-llvm", "-Xclang", "-llvm-verify-each"]
HARNESS = '''#include <stdio.h>
#include <limits.h>
_Static_assert(UINT_MAX == 4294967295u, "requires uint32");
extern unsigned int compute(unsigned int, unsigned int);
int main(void) {
    unsigned int x, y;
    while (scanf("%u %u", &x, &y) == 2) {
        printf("%u\\n", compute(x, y));
    }
    return ferror(stdin) || ferror(stdout);
}
'''
INVALID_IR = '''define i32 @compute(i32 %x, i32 %y) {
entry:
  br i1 true, label %left, label %right
left:
  %z = add i32 %x, %y
  br label %right
right:
  ret i32 %z
}
'''


class ToolFailure(RuntimeError):
    pass


def run_command(args, cwd, timeout=20, input_text=None):
    env = dict(os.environ)
    env.update({"LC_ALL": "C", "LANG": "C", "TZ": "UTC", "SOURCE_DATE_EPOCH": "0",
                "UBSAN_OPTIONS": "halt_on_error=1:print_stacktrace=0"})
    try:
        result = subprocess.run([str(arg) for arg in args], cwd=cwd, env=env, input=input_text,
                                text=True, capture_output=True, timeout=timeout)
    except (subprocess.TimeoutExpired, OSError) as error:
        raise ToolFailure(f"tool did not complete: {error}") from error
    if result.returncode:
        raise ToolFailure(f"{Path(str(args[0])).name} exited {result.returncode}: {result.stderr[:6000]}")
    if result.stderr.strip():
        raise ToolFailure(f"unexpected tool diagnostic: {result.stderr[:6000]}")
    return result.stdout


class Compiler:
    def __init__(self, clang="clang", timeout=20):
        found = shutil.which(clang)
        if found is None:
            raise ToolFailure(f"Clang not found: {clang}")
        # Retain the invoked name: resolving clang to clang-N can change driver behavior.
        self.clang = str(Path(found).absolute())
        self.timeout = timeout
        self.driver_target = run_command([self.clang, "-dumpmachine"], Path.cwd(), timeout).strip()
        probe = run_command([self.clang, "-S", "-emit-llvm", "-x", "c", "-", "-o", "-"],
                            Path.cwd(), timeout, "unsigned int compute(unsigned int x, unsigned int y) { return x + y; }\n")
        match = re.search(r'^target triple = "([^"]+)"$', probe, re.M)
        if not match:
            raise ToolFailure("could not determine actual LLVM module target")
        self.target = match.group(1)

    def identity(self):
        version = run_command([self.clang, "--version"], Path.cwd(), self.timeout)
        # The installation directory is host-specific; executable bytes identify the build.
        version = "\n".join(line for line in version.splitlines() if not line.startswith("InstalledDir:"))
        result = {
            "compiler_version": version,
            "compiler_sha256": digest(Path(self.clang).read_bytes()),
            "target": self.target, "driver_target": self.driver_target,
            "python_version": platform.python_version(),
            "system": platform.system(), "system_release": platform.release(), "machine": platform.machine(),
            "c_flags": C_FLAGS, "ir_flags": IR_FLAGS,
            "verifier": "clang-cc1-llvm-verify-each",
            "execution_profile": "native-host",
        }
        if sys.platform == "darwin":
            result["sdk_version"] = run_command(["xcrun", "--show-sdk-version"], Path.cwd(), self.timeout).strip()
            sdk = Path(run_command(["xcrun", "--show-sdk-path"], Path.cwd(), self.timeout).strip())
            settings = sdk / "SDKSettings.json"
            if settings.exists():
                result["sdk_settings_sha256"] = digest(settings.read_bytes())
        return result

    def run(self, args, cwd, input_text=None):
        return run_command(args, cwd, self.timeout, input_text)

    def emit_ir(self, work):
        self.run([self.clang, "-target", self.target, *C_FLAGS, *IR_FLAGS, "source.c", "-o", "module.ll"], work)
        ir = (work / "module.ll").read_text()
        if 'source_filename = "source.c"' not in ir:
            raise ToolFailure("unexpected source filename; refusing non-canonical IR")
        if not re.search(r'^target triple = "' + re.escape(self.target) + '"$', ir, re.M):
            raise ToolFailure("IR target differs from locked compiler target")
        return ir

    def verify_ir(self, work, filename="module.ll"):
        # cc1 shares LLVM's parser and verifier. Explicit triple prevents implicit retargeting.
        self.run([self.clang, "-cc1", "-triple", self.target, "-emit-llvm-bc", "-llvm-verify-each",
                  "-x", "ir", filename, "-o", "verified.bc"], work)
        if not (work / "verified.bc").is_file():
            raise ToolFailure("verifier did not produce bitcode")

    def preflight(self, work):
        work.mkdir(parents=True, exist_ok=True)
        (work / "source.c").write_text(
            '_Static_assert(sizeof(unsigned int) * __CHAR_BIT__ == 32, "requires uint32");\n'
            'unsigned int compute(unsigned int x, unsigned int y) { return x + y; }\n')
        self.emit_ir(work)
        self.verify_ir(work)
        (work / "bad.ll").write_text(INVALID_IR)
        try:
            self.verify_ir(work, "bad.ll")
        except ToolFailure as error:
            if "dominate" not in str(error):
                raise ToolFailure(f"verifier negative control failed unexpectedly: {error}") from error
        else:
            raise ToolFailure("LLVM verifier accepted non-dominating SSA use")
        records = [{"x": 0xFFFFFFFF, "y": 2, "expected": 1}, {"x": 0, "y": 0, "expected": 0}]
        self.check_execution(work, records)

    def check_execution(self, work, records):
        (work / "harness.c").write_text(HARNESS)
        builds = {
            "c_O0": [*C_FLAGS, "-O0", "source.c", "harness.c"],
            "ir_O2": ["-O2", "-Werror", "-Xclang", "-llvm-verify-each", "module.ll", "harness.c"],
            "c_ubsan_O1": [*C_FLAGS, "-O1", "-fsanitize=undefined", "-fno-sanitize-recover=all",
                            "source.c", "harness.c"],
        }
        inputs = "".join(f"{record['x']} {record['y']}\n" for record in records)
        expected = [record["expected"] for record in records]
        results = {}
        for name, flags in builds.items():
            executable = work / name
            self.run([self.clang, "-target", self.target, *flags, "-o", str(executable)], work)
            output = self.run([str(executable)], work, inputs)
            try:
                actual = [int(line) for line in output.splitlines()]
            except ValueError as error:
                raise ToolFailure(f"non-integer output in {name}") from error
            if actual != expected:
                mismatch = next((i for i, (a, b) in enumerate(zip(actual, expected)) if a != b), None)
                raise ToolFailure(f"execution mismatch in {name}: index={mismatch}, actual_count={len(actual)}")
            results[name] = {"passed": True, "input_count": len(records), "output_sha256": digest(output)}
        return results
