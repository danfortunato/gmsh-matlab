#!/usr/bin/env python3
"""Numeric-tolerant token diff for whitespace-separated text files.

Usage:
    numdiff.py A B [RTOL]

Splits both files on whitespace, walks the token pairs:
  * identical tokens pass
  * tokens that both parse as floats pass iff
      |a - b| <= RTOL * max(1, |a|)
  * otherwise fail

Exits 0 if every token matches, 1 otherwise. On success, prints the
largest relative difference observed (so a sub-tolerance drift can still
be tracked over time). On failure, prints the first offending token pair
with its surrounding context.

Designed for gmsh .msh / .pos outputs where the structure is invariant
but coordinates may drift in the LSB of a double across math libraries
(e.g. MATLAB's MKL vs Python's libm cos/sin).
"""
from __future__ import annotations
import sys


def parse_float(tok: str):
    try:
        return float(tok)
    except ValueError:
        return None


def main(argv):
    if len(argv) < 3 or len(argv) > 4:
        sys.stderr.write("usage: numdiff.py A B [RTOL]\n")
        return 2
    pa, pb = argv[1], argv[2]
    rtol = float(argv[3]) if len(argv) > 3 else 1e-12

    try:
        A = open(pa).read().split()
        B = open(pb).read().split()
    except UnicodeDecodeError:
        sys.stderr.write("binary file; numeric tolerance not applicable\n")
        return 1
    if len(A) != len(B):
        sys.stderr.write(f"token count differs: {pa}={len(A)} vs {pb}={len(B)}\n")
        return 1

    max_rel = 0.0
    for i, (a, b) in enumerate(zip(A, B)):
        if a == b:
            continue
        fa, fb = parse_float(a), parse_float(b)
        if fa is None or fb is None:
            ctx = " ".join(A[max(0, i - 3):i + 4])
            sys.stderr.write(f"non-numeric mismatch at token {i}: {a!r} vs {b!r}\n")
            sys.stderr.write(f"  context: {ctx}\n")
            return 1
        diff = abs(fa - fb)
        denom = max(1.0, abs(fa))
        rel = diff / denom
        if rel > rtol:
            ctx = " ".join(A[max(0, i - 3):i + 4])
            sys.stderr.write(
                f"numeric mismatch at token {i}: {a} vs {b} "
                f"(rel diff {rel:.3e} > rtol {rtol:.0e})\n")
            sys.stderr.write(f"  context: {ctx}\n")
            return 1
        if rel > max_rel:
            max_rel = rel

    if max_rel > 0:
        print(f"max relative diff: {max_rel:.3e}")
    return 0


if __name__ == "__main__":
    sys.exit(main(sys.argv))
