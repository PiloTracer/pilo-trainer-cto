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
| `@cto-review status` | Task status: what's done, what's pending, what's next |
| `@cto-review tasks` | Alias for `status` |
| `@cto-review status --full` | Adds readiness / competency / unknowns detail |
| `@cto-review certify` | Promote gate if evidence present |

## status

**Single source:** the active program's `progress.md` task ledger. Read it; do not
re-derive the task list by parsing session logs, memos, HANDOFF, or plan documents.

If the ledger is missing or unseeded, say exactly that and offer to back-fill it from
existing artifacts. **Do not improvise a status from prose** — that is what produces
unreadable walls of text.

### Output shape (fixed)

```markdown
**Program:** <slug> · **Module:** <current> · **Week <n> of <m>** · <hrs>/week

### Completed (<count>)
1. <task> — <evidence path> · <date>

### Pending (<count>)
1. <task> — <done>/<total>

### Deferred
- <task> — until <condition>

### Next
`<skill invoke>` — <one line on why this one>

### Assessment
<2–4 sentences: pace against remaining time, and the single biggest risk.>
```

### Rules

- **Nothing outside that shape** unless `--full`. No competency table, no unknowns dump, no memo recap, no artifact inventory.
- **Pending lists the current module only.** Later modules collapse to one line each (`M4 Decision hygiene — 3 tasks, not started`). A learner acting today cannot act on module 6; listing its tasks is noise.
- Completed items are ordered oldest → newest. Above 10, show the 10 most recent and a `+<n> earlier` line.
- Counted items stay one line (`1 of 3`), never expanded into three.
- A task with no evidence path is **pending**, whatever the session logs claim.
- Consultancy memos and advisory output are not tasks — exclude them unless a ledger row assigns them.
- The Assessment is a trainer's read, not encouragement. Name slippage and the highest-value untouched item plainly.

### `--full` adds

| Field | Source |
|-------|--------|
| Readiness state | PROFILE + artifacts |
| Sessions this month | `sessions/` |
| Open unknowns | `{UNKNOWNS}` |
| Competency deltas | `progress/COMPETENCY.md` |

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
