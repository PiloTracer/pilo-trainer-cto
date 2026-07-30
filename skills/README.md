# CTO Professor OS skills

Portable mentoring workflows. Each skill is a folder with `skill.md`.

**Identifiers:** Folder name = YAML `name:` = `@` handle.

**Invocation:** `@<skill-id> <mode> - <arg>` with ASCII hyphen.

**Memory:** `{TRAINING_ROOT}` = `.training.cto/` at project root.

---

## Naming protocol

| Rule | Requirement |
|------|-------------|
| **Shape** | kebab-case |
| **Domain prefix** | `cto-` |
| **System** | `deploy-*`, `session-cto` |
| **Stable id** | Folder = `name:` = `@` handle |

---

## Registered skills

| Skill id | Folder | Role |
|----------|--------|------|
| deploy-basic | `deploy-basic/` | Thin-client bootstrap (`.cursorrules` + `.training.cto/`); skills via `TRAINER_CTO_SOURCE` |
| deploy-files | `deploy-files/` | Fat-client vendor as `.ai.cto/` |
| deploy-repo | `deploy-repo/` | Full git clone or archive deploy |
| cto-bootstrap | `cto-bootstrap/` | Scaffold `.training.cto/`, PROFILE intake |
| session-cto | `session-cto/` | Session open/close; HANDOFF, NEXT |
| cto-director | `cto-director/` | Free-text → skill routing |
| cto-process-router | `cto-process-router/` | Read-only how-to → skill |
| cto-assess | `cto-assess/` | Diagnostic; unlocks **assessed** |
| cto-program-standard | `cto-program-standard/` | Install catalog program |
| cto-program-custom | `cto-program-custom/` | Design bespoke program |
| cto-curriculum | `cto-curriculum/` | Module design / sequencing |
| cto-mentor | `cto-mentor/` | Mentoring sessions |
| cto-consult | `cto-consult/` | Consultancy memos / board / decision review |
| cto-drill | `cto-drill/` | Practical drills |
| cto-sources | `cto-sources/` | Curate public sources |
| cto-update | `cto-update/` | Continuous learning refresh |
| cto-review | `cto-review/` | Progress + gate certification |

**Typical greenfield:** `@cto-bootstrap init` → `@cto-assess run` → `@cto-program-standard install - cto-foundations` → `@session-cto start` → `@cto-mentor run` → `@session-cto close`

---

## Canonical verbs

| Verb | Meaning |
|------|---------|
| `status` | Read-only report |
| `init` | One-time setup |
| `run` | Execute |
| `install` | Copy catalog → `.training.cto/programs/` |
| `list` | Enumerate options |
| `design` / `refine` | Curriculum authoring |
| `prepare` | Pre-work |
| `memo` / `board` / `review` | Consultancy modes |
| `add` / `curate` | Sources |
| `certify` | Gate promotion |
| `tasks` | Alias for `status` on `cto-review` |
| `start` / `close` | Session bookends |
| `copy` / `clone` / `archive` | Deploy modes |
| `update` | Re-sync an existing deploy (`deploy-basic`) |

Flags: `-y` skips a gate where a waiver exists (logged in HANDOFF) · `--full` expands a
`status` report · `--force` overwrites on deploy · `--dry-run` plans without writing.

---

## Framework assets skills read

| Path | Contents |
|------|----------|
| `standards/` | Seven binding standards — see the table in [`PROCESS_ROUTER.md`](../PROCESS_ROUTER.md) |
| `references/core-library.md` | Verified sources by competency area |
| `drills/case-library.md` | Runnable drill cases with pre-read boundaries |
| `curricula/` | Eight catalog programs |
| [`SKILL_DEPENDENCIES.md`](SKILL_DEPENDENCIES.md) | Gate graph, waivers, and the canonical BLOCKED shape |
