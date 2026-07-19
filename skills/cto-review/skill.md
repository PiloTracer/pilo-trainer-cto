---
name: cto-review
description: >-
  Progress review and readiness-state certification. Writes reports/ and updates
  COMPETENCY. Modes: status, certify.
---

# cto-review

## Parse

| Invoke | Action |
|--------|--------|
| `@cto-review status` | Readiness + progress snapshot |
| `@cto-review certify` | Promote gate if evidence present |

## status

Report:

| Field | Source |
|-------|--------|
| Readiness state | PROFILE + artifacts |
| Active program / module | programs/ |
| Sessions this month | sessions/ |
| Open unknowns | UNKNOWNS |
| Competency deltas | progress/COMPETENCY.md |
| Recommended next | skill invoke |

## certify

Promote only with evidence, scored per `standards/assessment.md` (binding — do not certify `assessed` or drill-backed competency claims without artifact evidence at the required scoring bar):

| Target state | Evidence required |
|--------------|-------------------|
| profile-ready | PROFILE required fields filled |
| assessed | assessments/baseline.md |
| program-active | programs/<slug>/PROGRAM.md |
| mentoring-loop | ≥1 real session log (not only prep) |
| consultancy-ready | profile-ready (+ memo if claiming consult practice) |

On success: write `.training.cto/reports/certify-YYYY-MM-DD.md`, update PROFILE readiness, HANDOFF.

On failure: BLOCKED report with missing evidence paths.
