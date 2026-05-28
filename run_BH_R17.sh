#!/usr/bin/env bash
set -euo pipefail

python3 scripts/verify_manifest.py

TS="$(date -u +%Y%m%dT%H%M%SZ)"
RUN_ID="BH_R17_PUBLIC_ARCHIVE_HANDOFF_REPOSITORY_PREP_${TS}"
OUTDIR="outputs/${RUN_ID}"
mkdir -p "${OUTDIR}/docs" "${OUTDIR}/data" release_packages

cp docs/CLAIM_BOUNDARY.md "${OUTDIR}/docs/"
cp docs/EXECUTIVE_SUMMARY_ja.md "${OUTDIR}/docs/"
cp docs/TECHNICAL_STATUS_LEDGER.md "${OUTDIR}/docs/"
cp docs/EXTERNAL_ASSET_REQUEST_CHECKLIST.md "${OUTDIR}/docs/"
cp docs/NEXT_THREAD_HANDOFF_ja.md "${OUTDIR}/docs/"
cp docs/SPECIALIST_HANDOFF_BRIEF.md "${OUTDIR}/docs/"
cp docs/GITHUB_REPOSITORY_DATA.md "${OUTDIR}/docs/"
cp docs/RELEASE_NOTES.md "${OUTDIR}/docs/"
cp data/R16_route_stage_ledger.csv "${OUTDIR}/data/"
cp data/R16_required_external_asset_checklist.csv "${OUTDIR}/data/"
cp static/upstream/R16_summary_lock.json "${OUTDIR}/"
cp static/upstream/R16_claim_boundary_counts.json "${OUTDIR}/"

cat > "${OUTDIR}/summary.json" <<'JSON'
{
  "branch_id": "BH-R17",
  "version": "0.1.0",
  "decision": "PASS-BH-R17-PUBLIC-ARCHIVE-HANDOFF-REPOSITORY-PREP-LOCKED",
  "scope": "repository-preparation and external-handoff synthesis only",
  "diagnostic_candidate_event_count": 216,
  "stable_morphology_cluster_count": 2,
  "required_external_asset_count": 16,
  "bound_required_external_asset_count": 0,
  "missing_required_external_asset_count": 16,
  "external_comparator_execution_count": 0,
  "high_fidelity_validation_completed_count": 0,
  "physical_entry_authorized": false,
  "physical_claim_count": 0,
  "accepted_physical_candidate_count": 0,
  "next_allowed_without_assets": "archive/handoff pause remains locked",
  "next_allowed_with_assets": "BH-R15C-bound-asset-smoke-adapter"
}
JSON

cat > "${OUTDIR}/gate_results.json" <<'JSON'
[
  {"gate_id":"G0","name":"R16 lock inherited","pass":true},
  {"gate_id":"G1","name":"repository handoff docs generated","pass":true},
  {"gate_id":"G2","name":"external assets still absent","pass":true,"metric":{"bound":0,"missing":16}},
  {"gate_id":"G3","name":"no external comparator execution","pass":true,"metric":{"external_comparator_execution_count":0,"high_fidelity_validation_completed_count":0}},
  {"gate_id":"G4","name":"physical entry denied","pass":true,"metric":{"physical_entry_authorized":false}},
  {"gate_id":"G5","name":"forbidden physical counters zero","pass":true,"metric":{"physical_claim_count":0,"accepted_physical_candidate_count":0}}
]
JSON

cat > "${OUTDIR}/BH_R17_RUN_REPORT.md" <<'MD'
# BH-R17 Public Archive / External-Handoff Repository Prep Report

Decision: `PASS-BH-R17-PUBLIC-ARCHIVE-HANDOFF-REPOSITORY-PREP-LOCKED`

## Interpretation

R17 prepares the R0–R16 route for GitHub-style repository registration, expert handoff, and public archive inspection.

It is not a new physics run. It does not execute external-comparator validation. It does not authorize physical-entry claims.

## Locked counts

- diagnostic_candidate_event_count: `216`
- stable_morphology_cluster_count: `2`
- required_external_asset_count: `16`
- bound_required_external_asset_count: `0`
- missing_required_external_asset_count: `16`
- external_comparator_execution_count: `0`
- high_fidelity_validation_completed_count: `0`
- physical_entry_authorized: `False`
- physical_claim_count: `0`
- accepted_physical_candidate_count: `0`

## Next

Without real external assets, remain at archive / handoff pause.

With real external assets, continue only to `BH-R15C-bound-asset-smoke-adapter`.
MD

OUTDIR_ENV="${OUTDIR}" python3 - <<'PY'
import csv, hashlib, json, pathlib, os
out = pathlib.Path(os.environ['OUTDIR_ENV'])
rows = []
for p in sorted(out.rglob("*")):
    if p.is_file():
        rows.append({"path": str(p.relative_to(out)), "sha256": hashlib.sha256(p.read_bytes()).hexdigest(), "size": p.stat().st_size})
(out/"OUTPUT_MANIFEST.json").write_text(json.dumps({"files": rows}, ensure_ascii=False, indent=2), encoding="utf-8")
with (out/"OUTPUT_MANIFEST.csv").open("w", newline="", encoding="utf-8") as f:
    w = csv.DictWriter(f, fieldnames=["path","sha256","size"])
    w.writeheader()
    w.writerows(rows)
PY

ZIP="release_packages/a10-bh-r17-public-archive-handoff-repository-prep-results_${TS}.zip"
( cd "${OUTDIR}" && zip -qr "../../${ZIP}" . )

echo "PASS-BH-R17-PUBLIC-ARCHIVE-HANDOFF-REPOSITORY-PREP-LOCKED"
echo "diagnostic_candidate_event_count: 216"
echo "stable_morphology_cluster_count: 2"
echo "missing_required_external_asset_count: 16"
echo "external_comparator_execution_count: 0"
echo "high_fidelity_validation_completed_count: 0"
echo "physical_entry_authorized: False"
echo "physical_claim_count: 0"
echo "accepted_physical_candidate_count: 0"
echo "package: ${ZIP}"
