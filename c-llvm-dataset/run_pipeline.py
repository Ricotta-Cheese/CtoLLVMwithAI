#!/usr/bin/env python3
"""Run directly from a checkout without installing packages."""
from pathlib import Path
import sys

sys.path.insert(0, str(Path(__file__).resolve().parent / "src"))
from c_llvm_dataset.cli import main

if __name__ == "__main__":
    main()
