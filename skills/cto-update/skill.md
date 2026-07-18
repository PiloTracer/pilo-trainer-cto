---
name: cto-update
description: >-
  Continuous learning refresh: update Continuous Edge backlog and active program
  reading lists from publicly available material. Honest citations only.
---

# cto-update

## Parse

| Invoke | Action |
|--------|--------|
| `@cto-update run` | Refresh sources + propose focus |
| `@cto-update status` | Last refresh + backlog health |

## run

1. Load PROFILE, active program, `.training.cto/sources/`, continuous-edge program if installed.
2. Identify 3–7 timely themes relevant to the learner (AI ops, reliability, org, security, platform — based on PROFILE).
3. Research with web tools when available; add only verifiable sources via `@cto-sources` rules.
4. Write `.training.cto/reports/update-YYYY-MM-DD.md` with themes, new sources, recommended drill/mentor focus.
5. Update NEXT (one concrete action).

## Quality

- No filler "thought leadership" without a practice implication.
- Prefer durable principles + a few current pieces — not trend spam.
- Label anything not verified as **Unverified**.
