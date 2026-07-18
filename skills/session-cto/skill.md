---
name: session-cto
description: >-
  Session bookends for CTO training. Modes: start, status, close.
  Loads/writes HANDOFF and NEXT under .training.cto/.
---

# session-cto

## Parse

| Invoke | Action |
|--------|--------|
| `@session-cto start` | Load context; set session active |
| `@session-cto status` | Read-only orientation |
| `@session-cto close` | Refresh HANDOFF + NEXT; summarize |

## start

1. Read `{HANDOFF}`, `{NEXT}`, `{PROFILE}`, `{UNKNOWNS}`, active program if any.
2. Summarize: readiness state, active program/module, top next action, blockers.
3. Update HANDOFF session state → `active`, date today.
4. Propose one concrete action for this session (mentor / drill / consult / assess).

## status

Read-only version of the summary. No writes.

## close

1. Ask (or infer from chat) what was accomplished; write Latest action block into HANDOFF.
2. Update NEXT with the single best next skill invoke.
3. Set session state → `idle`.
4. Optionally draft a commit message for `.training.cto/` changes (do not commit unless asked).

## Rules

Never claim progress without referencing an artifact path under `.training.cto/`.
