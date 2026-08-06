---
name: cto-consult
description: >-
  Consultancy: advisory memos, board/exec prep, decision reviews. Writes under
  .work.cto/consultancy/. Requires profile-ready.
---

# cto-consult

**Requires:** profile-ready (waiver `-y`, logged in HANDOFF; assessed recommended).

On failure emit the canonical BLOCKED report from `skills/SKILL_DEPENDENCIES.md`.

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
3. Scan `standards/anti-patterns.md` against the situation. If a pattern is present, name it in the memo and run its challenge — do not soften it into a suggestion.
4. Write memo to `.work.cto/consultancy/YYYY-MM-DD-<slug>.md`.
5. Recommendation must include: options, tradeoffs, recommended path, risks, first 7-day actions.
6. Update HANDOFF/NEXT.

## Binding standards

| Standard | When |
|----------|------|
| `standards/anti-patterns.md` | Every memo — scan before recommending |
| `standards/decision-record.md` | `review` mode; also any memo that recommends a reversible/irreversible choice |
| `standards/metrics.md` | Any memo touching delivery measurement, productivity, or a board metrics question |
| `standards/citation.md` | Any external claim |

`review` mode scores the decision against the gates in `standards/decision-record.md` —
options, drivers, consequences, reversal trigger, self-consistency — and reports structural
failures separately from overall quality.

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
