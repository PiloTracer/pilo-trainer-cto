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

0. **Classify session type first:** framework-dev (the request is about editing/improving `skills/`, `curricula/`, `standards/`, `templates/`, `scripts/`, or `.cursorrules` themselves) vs training (a learner using the pipeline). If framework-dev, stop here — there is no learner session to open; say so and hand off to the framework task instead of steps 1-4.
1. Read `{HANDOFF}`, `{NEXT}`, `{PROFILE}`, `{UNKNOWNS}`, active program if any.
2. Summarize: readiness state, active program/module, top next action, blockers.
3. Update HANDOFF session state → `active`, date today.
4. Propose one concrete action for this session (mentor / drill / consult / assess). **Never default to `@cto-bootstrap init` solely because `{PROFILE}` has unfilled `REPLACE:` tokens** — only propose it if the user's stated goal for this session is actually starting/setting up a training project.

## status

Read-only version of the summary. No writes.

## close

1. Ask (or infer from chat) what was accomplished; write Latest action block into HANDOFF.
2. Update NEXT with the single best next skill invoke.
3. Set session state → `idle`.
4. Optionally draft a commit message for `.training.cto/` changes (do not commit unless asked).

## Rules

Never claim progress without referencing an artifact path under `.training.cto/`.
