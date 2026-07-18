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
6. Write session log; update progress.md + COMPETENCY evidence + HANDOFF.

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
