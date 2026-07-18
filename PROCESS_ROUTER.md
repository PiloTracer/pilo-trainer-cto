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
| Practical drill | `@cto-drill run - <type>` |
| Add or curate sources | `@cto-sources add` / `curate` |
| Refresh continuous learning | `@cto-update run` |
| Check gates / progress | `@cto-review status` / `certify` |
| Deploy into another project | `@deploy-basic - /path` |
| Vendor framework into project | `@deploy-files copy - /path` |

**Engineering / UI / biz work?** Route to `@ai-director`, `@ui-director`, `@biz-director`, or `@x-director` — not CTO Professor skills.

**Blocked on a gate?** Read [`skills/SKILL_DEPENDENCIES.md`](skills/SKILL_DEPENDENCIES.md) and run the unlock command shown in the BLOCKED report.
