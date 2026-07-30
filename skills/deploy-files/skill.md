---
name: deploy-files
description: >-
  Fat-client deploy: vendor full CTO Professor OS into target as .ai.cto/,
  then scaffold .training.cto/. Use when offline/local skills are required.
---

# deploy-files

**Shell:** `bash <source>/scripts/deploy-files.sh <target-path> [--force]`

## Parse

| User says | Mode |
|-----------|------|
| `@deploy-files copy - /path/to/target` | Vendor the framework as `<target>/.ai.cto/` |
| `@deploy-files - /path/to/target` | Same; `copy` is the default and may be omitted |
| `@deploy-files copy - /path --force` | rsync update over an existing `.ai.cto/` |

## Thin or fat?

| Use | When |
|-----|------|
| `@deploy-basic` (preferred) | The source repo stays reachable on this machine. One copy of the framework, many targets |
| `@deploy-files` | The target must work without the source — offline, a different machine, a handoff, or a build that vendors its dependencies |

Fat-client costs you upgrades: each target holds its own snapshot and drifts independently.

## Protocol

1. **Target directory must already exist.** This skill scaffolds into a directory; it does not create the repo. If missing, say so and stop.
2. Validate the source has `templates/`, `skills/`, `standards/`, `curricula/`, `references/`, `drills/`.
3. Run `scripts/deploy-files.sh <target-path> [--force]` (rsync into `.ai.cto/`, excluding `.git/`, `.training.cto/`, and scratch dirs).
4. Confirm `.training.cto/` scaffolded and `.cursorrules` created **only if missing** — leave `TRAINER_CTO_SOURCE=REPLACE_BASICSOURCE`, which is how fat-client is detected.
5. Report the output contract below, then tell the user to fill REPLACE tokens and run `@session-cto start`.

## Output contract

Report actual paths, not assumed success:

```text
.ai.cto/           skills · curricula · standards · references · drills · templates · scripts
.training.cto/     learner memory skeleton (created if absent, never overwritten)
.cursorrules       created only if absent; TRAINER_CTO_SOURCE stays REPLACE_BASICSOURCE
```

## Failure handling

| Condition | Response |
|-----------|----------|
| Target directory does not exist | Stop. Tell the user to `mkdir -p` (and `git init` if it should be a repo) |
| `.ai.cto/` already exists, no `--force` | Stop — the script exits rather than clobbering. Offer `--force` (rsync update) and say it deletes files absent from the source |
| Target has an existing `.cursorrules` | Never clobber. Report it as skipped and offer a rules-aware merge |
| `rsync` missing | Stop and name the missing tool; do not fall back to a partial `cp` |

## Rules

Never vendor into a target that is already thin-client (a `.cursorrules` with a real
`TRAINER_CTO_SOURCE`) without saying so — the two modes disagree about where skills live, and
the resulting target reads some paths from the source and others locally.
