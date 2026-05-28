# Technical Status Ledger

## R16 lock inherited by R17

This R17 package inherits the R16 lock:

- route_stage_count: 30
- diagnostic_candidate_event_count: 216
- stable_morphology_cluster_count: 2
- required_external_asset_count: 16
- bound_required_external_asset_count: 0
- missing_required_external_asset_count: 16
- external_comparator_execution_count: 0
- high_fidelity_validation_completed_count: 0
- archive_handoff_pause_locked: true
- physical_entry_authorized: false
- physical_claim_count: 0
- accepted_physical_candidate_count: 0

## Interpretation

The route is handoff-ready as a claim-bounded sandbox archive.
It is not physical-entry-ready.

## Failure handling

Two important failures were preserved rather than erased:

- R3B: nondecaying-tail false accepts were detected and remediated.
- R6: paired morphology collapsed under an inappropriate global width gate and was remediated through morphology-specific guards.

These failures improve the archive because they define real failure boundaries.
