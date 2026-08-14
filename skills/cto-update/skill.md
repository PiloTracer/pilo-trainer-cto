---
name: cto-update
description: >-
  Continuous learning refresh: update Continuous Edge backlog and active program
  reading lists from publicly available material. Honest citations only.
---

# cto-update

**Requires:** scaffold (`.work.cto/` exists). No waiver — run `@cto-bootstrap init` first.

On failure emit the canonical BLOCKED report from `skills/SKILL_DEPENDENCIES.md`.

## Parse

| Invoke | Action |
|--------|--------|
| `@cto-update run` | Refresh sources + propose focus |
| `@cto-update status` | Last refresh + backlog health |

## run

1. Load PROFILE, active program, `.work.cto/sources/`, continuous-edge program if installed.
2. Identify 3–7 timely themes relevant to the learner (AI ops, reliability, org, security, platform — based on PROFILE).
3. Research with web tools when available; add only verifiable sources via `@cto-sources` rules.
4. Write `.work.cto/reports/update-YYYY-MM-DD.md` with themes, new sources, recommended drill/mentor focus.
5. Update NEXT (one concrete action).

## update-*.md shape

```markdown
# Update — YYYY-MM-DD
**Status:** Draft | In review | Approved | Superseded — YYYY-MM-DD
**Needs:** <one line, or nothing>

## Themes (3–7)
| Theme | Why it matters to this learner | Practice implication |
|-------|-------------------------------|----------------------|

## Sources added
| Title | Author / URL | Status | Added to |

## Recommended focus
<one drill or mentor topic, and why it beats the alternatives>

## Unverified
<anything that could not be confirmed against a live page — kept, labelled, not silently dropped>

## Nothing-changed note
<if the field genuinely produced nothing worth acting on, say so; a thin month is a finding>

## Next action
<one action in exact syntax — or `Next action: none — <reason>`>
```

New sources go to `.work.cto/sources/README.md` with `Status: assigned`, and get a
`reading` row in the active program's task ledger. A source added nowhere but this report is
invisible by next week.

## Quality

- No filler "thought leadership" without a practice implication.
- Prefer durable principles + a few current pieces — not trend spam.
- Label anything not verified as **Unverified**.
- **Operator handoff:** every response that ends a turn follows the [Operator handoff contract](../SKILL_DEPENDENCIES.md#operator-handoff-contract) — terse output; approvals under `**Needs your approval:**` citing `path:L<n>`; questions numbered under `**Needs your answer:**`; exactly one `**Next step:**` command; one line when nothing is needed (Form A). Decisions and questions never mixed; empty sections omitted.
- **Document clarity:** every generated document follows the [Document clarity contract](../SKILL_DEPENDENCIES.md#document-clarity-contract) — Status + Needs header, separate Decisions/Open questions lists, one `## Next action`, no placeholder scaffolding left behind.
