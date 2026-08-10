---
name: cto-deploy-repo
description: >-
  Full framework deploy via git clone or tar archive. Modes: clone, archive.
---

# cto-deploy-repo

**Clone:** `bash <source>/scripts/deploy-repo.sh clone <url> <target>`  
**Archive:** `bash <source>/scripts/deploy-repo.sh archive <target-dir>`

**Flag equivalence:** modes accept an optional `--` prefix — `--clone` ≡ `clone`, `--archive` ≡ `archive`.

## Parse

| User says | Mode |
|-----------|------|
| `@cto-deploy-repo clone - <url> <target>` | Clone the framework repo into a standalone copy |
| `@cto-deploy-repo archive - <target-dir>` | Write a tar archive of the framework for transfer or backup |

## When to use this instead of the others

| Skill | Result |
|-------|--------|
| `@cto-deploy-basic` | Target holds `.cursorrules` + `.work.cto/`; skills read from the source. **Preferred for multi-repo sharing** |
| `@cto-deploy-files` | Target holds its own `.ai.cto/` copy alongside its own app code |
| `@cto-deploy-repo` | A standalone copy of the framework *as its own repo*, or a backup artifact |

Use `cto-deploy-repo` when the framework itself is the deliverable — onboarding another machine,
forking for modification, or archiving a known-good version. It does not scaffold
`.work.cto/` into an application repo; that is what the other two do.

## Protocol

1. Confirm the mode and that the destination does not already hold a framework copy.
2. For `clone`, confirm the URL is the intended source and the target parent directory exists.
3. Run the script.
4. Report what landed and which follow-up applies — a clone is a *source*, so the next step is usually `@cto-deploy-basic - /path/to/real/project` from inside it.

## Output contract

| Mode | Produces |
|------|----------|
| `clone` | A git working tree at `<target>` with full history and remote intact |
| `archive` | A tar archive in `<target-dir>`; no git history, no `.work.cto/` |

Neither mode writes `.cursorrules` or `.work.cto/` into an application repo.

## Failure handling

| Condition | Response |
|-----------|----------|
| Target exists and is non-empty | Stop. Do not merge into it — name the path and ask |
| Clone fails (auth, network, bad URL) | Report the exact git error; never fall back to a partial copy |
| `git` or `tar` unavailable | Stop and name the missing tool |
| Archiving a dirty working tree | Say so — the archive captures the working state, including uncommitted changes |

## Rules

Never delete an existing target to make room. Never clone over a directory that contains
`.work.cto/` — learner memory is not replaceable from a remote.
