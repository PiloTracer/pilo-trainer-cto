# CTO Professor OS skills

Portable mentoring workflows. Each skill is a folder with `skill.md`.

**Identifiers:** Folder name = YAML `name:` = `@` handle.

**Invocation:** `@<skill-id> <mode> - <arg>` with ASCII hyphen.

**Memory:** `{WORK_ROOT}` = `.work.cto/` at project root.

---

## Naming protocol

| Rule | Requirement |
|------|-------------|
| **Shape** | kebab-case |
| **Domain prefix** | `cto-` |
| **System** | `cto-deploy-*`, `cto-session` |
| **Stable id** | Folder = `name:` = `@` handle |

---

## Registered skills

| Skill id | Folder | Role |
|----------|--------|------|
| cto-deploy-basic | `cto-deploy-basic/` | Thin-client bootstrap (`.cursorrules` + `.work.cto/`); skills via `TRAINER_CTO_SOURCE` |
| cto-deploy-files | `cto-deploy-files/` | Fat-client vendor as `.ai.cto/` |
| cto-deploy-repo | `cto-deploy-repo/` | Full git clone or archive deploy |
| cto-bootstrap | `cto-bootstrap/` | Scaffold `.work.cto/`, PROFILE intake |
| cto-session | `cto-session/` | Session open/close; HANDOFF, NEXT |
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

**Typical greenfield:** `@cto-bootstrap init` → `@cto-assess run` → `@cto-program-standard install - cto-foundations` → `@cto-session start` → `@cto-mentor run` → `@cto-session close`

---

## Canonical verbs

| Verb | Meaning |
|------|---------|
| `status` | Read-only report |
| `init` | One-time setup |
| `run` | Execute |
| `install` | Copy catalog → `.work.cto/programs/` |
| `list` | Enumerate options |
| `design` / `refine` | Curriculum authoring |
| `prepare` | Pre-work |
| `memo` / `board` / `review` | Consultancy modes |
| `add` / `curate` | Sources |
| `certify` | Gate promotion |
| `tasks` | Alias for `status` on `cto-review` |
| `start` / `close` | Session bookends |
| `copy` / `clone` / `archive` | Deploy modes |
| `update` | Re-sync an existing deploy (`cto-deploy-basic`) |

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
