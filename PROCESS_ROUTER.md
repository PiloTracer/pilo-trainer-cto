# Process router — how-to → skill

**Read-only signpost.** Prefer `@cto-process-router - <question>` so the agent follows this map without inventing new skills.

| You want to… | Run |
|--------------|-----|
| Scaffold learner memory | `@cto-bootstrap init` |
| Open / close a training day | `@session-cto start` / `close` |
| Describe a goal in plain language | `@cto-director - <text>` |
| Diagnose level and gaps | `@cto-assess run` |
| List catalog programs | `@cto-program-standard list` |
| Install a catalog program | `@cto-program-standard install - <slug>` |
| Design a bespoke program | `@cto-program-custom - <request>` |
| Refine modules / sequencing | `@cto-curriculum design` / `refine` |
| Run a mentoring session | `@cto-mentor run` |
| Prep tomorrow's session | `@cto-mentor prepare` |
| Advisory memo | `@cto-consult memo - <topic>` |
| Board / exec prep | `@cto-consult board - <topic>` |
| Decision review | `@cto-consult review - <decision>` |
| Practical drill | `@cto-drill run - <type>` — cases in [`drills/case-library.md`](drills/case-library.md) |
| See what's done vs pending | `@cto-review status` (short) · `status --full` (detail) |
| Add or curate sources | `@cto-sources add` / `curate` — start from [`references/core-library.md`](references/core-library.md) |
| Refresh continuous learning | `@cto-update run` |
| Check gates / progress | `@cto-review status` / `certify` |
| Deploy into another project | `@deploy-basic - /path` |
| Vendor framework into project | `@deploy-files copy - /path` |

**Engineering / UI / biz work?** Route to `@ai-director`, `@ui-director`, `@biz-director`, or `@x-director` — not CTO Professor skills.

**Blocked on a gate?** Read [`skills/SKILL_DEPENDENCIES.md`](skills/SKILL_DEPENDENCIES.md) and run the unlock command shown in the BLOCKED report.

**Binding standards** — read the one that matches the work, not all of them:

| Standard | Binds |
|----------|-------|
| [`mentoring.md`](standards/mentoring.md) | Session structure, retrieval opening |
| [`assessment.md`](standards/assessment.md) | Scoring anchors, drill rubric, cap rules |
| [`decision-record.md`](standards/decision-record.md) | ADRs and decision logs — ≥3 options, reversal trigger |
| [`metrics.md`](standards/metrics.md) | DORA, SPACE, and board metric questions |
| [`anti-patterns.md`](standards/anti-patterns.md) | What to challenge during diagnosis |
| [`citation.md`](standards/citation.md) | Any external claim |
| [`program-spec.md`](standards/program-spec.md) | Program structure |
