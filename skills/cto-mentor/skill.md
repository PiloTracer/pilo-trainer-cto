---
name: cto-mentor
description: >-
  Run or prepare a mentoring session against the active program. Writes session
  logs under .training.cto/sessions/. Requires program-active (or -y).
---

# cto-mentor

**Requires:** program-active (waiver `-y` for ad-hoc; still write a session log).

## Parse

| Invoke | Action |
|--------|--------|
| `@cto-mentor run` | Live mentoring session |
| `@cto-mentor prepare` | Prep agenda for next session |
| `@cto-mentor status` | Last session + next module |

## prepare

1. Load active PROGRAM + progress + HANDOFF.
2. Write `.training.cto/sessions/YYYY-MM-DD-prep-<slug>.md` with agenda, pre-read, drill, success check.
3. Update NEXT.

## run

Follow `standards/mentoring.md`:

1. Orient (goal for this session, 1 sentence).
2. Socratic diagnosis (challenge assumptions).
3. Teach one concept with a concrete company-shaped example.
4. Run or assign one drill (`@cto-drill` may be nested).
5. Commit to one decision/action; log it.
6. Write the session log to `.training.cto/sessions/YYYY-MM-DD-<topic-slug>.md`.
7. **Tick the task ledger** in `programs/<slug>/progress.md`: set each deliverable this session closed to `done` with the session-log path as Evidence, bump any `Done/Total` counts, and update `Deliverables complete`. A task without an evidence path stays pending.
8. Update COMPETENCY evidence + HANDOFF + NEXT.

New work assigned mid-session (extra reading, a follow-up artifact) gets **added** to the
ledger as a pending row in the same pass — otherwise it is invisible to `@cto-review status`.

## Session log shape

```markdown
# Session — YYYY-MM-DD — <title>

## Goal
## What we covered
## Challenge / pushback
## Drill / practice
## Decisions / commitments
## Sources referenced
## Next
```
