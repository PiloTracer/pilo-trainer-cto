---
name: cto-consult
description: >-
  Consultancy: advisory memos, board/exec prep, decision reviews. Writes under
  .training.cto/consultancy/. Requires profile-ready.
---

# cto-consult

**Requires:** profile-ready.

## Parse

| Invoke | Action |
|--------|--------|
| `@cto-consult memo - <topic>` | Written advisory memo |
| `@cto-consult board - <topic>` | Board / exec pack outline + talking points |
| `@cto-consult review - <decision>` | Decision quality review |
| `@cto-consult status` | Recent memos |

## Protocol

1. Load PROFILE + relevant program/context; ask ≤3 clarifying questions if stakes unclear.
2. Assumption ledger (Confirmed / Inferences / Unknowns).
3. Write memo to `.training.cto/consultancy/YYYY-MM-DD-<slug>.md`.
4. Recommendation must include: options, tradeoffs, recommended path, risks, first 7-day actions.
5. Update HANDOFF/NEXT.

## Memo shape

```markdown
# Consultancy — <title>
**Date:** YYYY-MM-DD
**Mode:** memo | board | review

## Situation
## Recommendation (bottom line)
## Options & tradeoffs
## Risks & unknowns
## 7-day actions
## Sources
```

Push back on politics-disguised-as-strategy. No invented market numbers — mark Unverified.
