#!/usr/bin/env bash
set -euo pipefail
python3 scripts/verify_manifest.py
if [ ! -s paper/a10_bh_claim_bounded_diagnostic_archive_v0_2_0.pdf ]; then
  echo "FAIL-REPOSITORY-QA: missing paper PDF"
  exit 1
fi
if grep -R "black-hole interior discovery" -n README.md docs paper/*.tex | grep -v "does not"; then
  echo "WARN: inspect discovery wording above"
fi
echo "PASS-A10-BH-REPOSITORY-QA"
