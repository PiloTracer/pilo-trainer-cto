# Pilo Trainer CTO — CTO Professor OS

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)
[![Release](https://img.shields.io/github/v/release/PiloTracer/pilo-trainer-cto?display_name=tag&sort=semver)](https://github.com/PiloTracer/pilo-trainer-cto/releases)
[![Version](https://img.shields.io/badge/version-0.0.1-blue.svg)](CHANGELOG.md)

> **Expert CTO professor / mentor** as a portable operating system: gated skills, binding standards, standard + custom programs, and learner memory under `.training.cto/`. Continuous training, consultancy, and source-backed updates — next to your real work.

**Repo:** [github.com/PiloTracer/pilo-trainer-cto](https://github.com/PiloTracer/pilo-trainer-cto)  
**Platform:** Linux (bash, git, rsync). Verify with `bash scripts/framework-verify.sh`.  
**Works with:** Cursor, Claude Code, Codex, and any agent that reads project files.

---

## Quick start

```bash
# Clone
git clone https://github.com/PiloTracer/pilo-trainer-cto.git
cd pilo-trainer-cto

# Target project must already exist (mkdir + git init if it's brand new)
mkdir -p /abs/path/to/target && (cd /abs/path/to/target && git init -q)

# Thin-client into that target project — run from THIS (source) repo/chat,
# not from inside the target: only the source session inherently knows its own path.
bash scripts/deploy-basic.sh /abs/path/to/target
```

In the **target** project chat:

```text
@session-cto start
@cto-bootstrap init
@cto-assess run
@cto-program-standard install - cto-foundations
@cto-mentor run
@session-cto close
```

**Lost?** → [`START_HERE.md`](START_HERE.md)  
**Free-text?** → `@cto-director - <what you want>`  
**Cheat sheets:** [`.quick/`](.quick/)

| Cheat sheet | Purpose |
|-------------|---------|
| [`.quick/README.md`](.quick/README.md) | Index of one-pagers |
| [`.quick/deploy-to-project.md`](.quick/deploy-to-project.md) | Thin / fat deploy |
| [`.quick/daily-loop.md`](.quick/daily-loop.md) | Session start → train → close |
| [`.quick/programs.md`](.quick/programs.md) | Standard + custom programs |
| [`.quick/skills.md`](.quick/skills.md) | All 17 skills at a glance |
| [`.quick/gates.md`](.quick/gates.md) | Readiness states |

---

## What you get

| Piece | Role |
|-------|------|
| **17 skills** | Mentoring, consultancy, drills, programs, updates |
| **Standards** | Mentoring quality, citation honesty, assessment, program SPECs |
| **`.training.cto/`** | Learner memory (profile, programs, sessions, sources, progress) |
| **Gates** | `profile-ready` → `assessed` → `program-active` → `mentoring-loop` |
| **Curricula** | Seven catalog programs + custom design on request |

---

## Path convention

| Layout | Framework location | Learner memory |
|--------|-------------------|----------------|
| **Self-hosted** (this repo) | git root | `.training.cto/` |
| **Thin-client** (recommended) | `$TRAINER_CTO_SOURCE` | target `.training.cto/` |
| **Fat-client** | target `.ai.cto/` | target `.training.cto/` |

---

## Gated pipeline

```text
  @cto-bootstrap init
        │  .training.cto/ + PROFILE
        ▼
  @cto-assess run
        │  assessed
        ▼
  @cto-program-standard install - <slug>
  @cto-program-custom - <request>
        │  program-active
        ▼
  @session-cto start → @cto-mentor / @cto-drill / @cto-consult / @cto-update
        │
        ▼
  @session-cto close
```

### Skills at a glance

| Skill | One line | Typical invoke |
|-------|----------|----------------|
| **deploy-basic** | Thin-client scaffold | `- /path` · `status` · `update` |
| **deploy-files** | Fat-client as `.ai.cto/` | `copy - /path` |
| **deploy-repo** | Clone or archive | `clone` · `archive` |
| **cto-bootstrap** | Scaffold + PROFILE | `init` · `status` |
| **session-cto** | Session bookends | `start` · `status` · `close` |
| **cto-director** | Free-text orchestrator | `- <request>` |
| **cto-process-router** | Read-only signpost | `- <question>` |
| **cto-assess** | Diagnostic | `run` · `status` |
| **cto-program-standard** | Install catalog program | `install - <slug>` · `list` |
| **cto-program-custom** | Bespoke program | `- <request>` |
| **cto-curriculum** | Module design | `design` · `refine` |
| **cto-mentor** | Mentoring session | `run` · `prepare` |
| **cto-consult** | Advisory / board / review | `memo` · `board` · `review` |
| **cto-drill** | Practical drills | `run - <type>` |
| **cto-sources** | Curate sources | `add` · `curate` · `list` |
| **cto-update** | Continuous refresh | `run` · `status` |
| **cto-review** | Progress + certify | `status` · `certify` |

Full registry: [`skills/README.md`](skills/README.md) · Router: [`PROCESS_ROUTER.md`](PROCESS_ROUTER.md)

---

## Deploy

Target directory must already exist (`mkdir -p` + `git init` if it's a brand-new repo) — both scripts scaffold *into* an existing directory, neither creates the repo itself.

```bash
# Thin-client (preferred)
bash scripts/deploy-basic.sh /abs/path/to/target

# Fat-client
bash scripts/deploy-files.sh /abs/path/to/target
```

Or from source chat: `@deploy-basic - /abs/path/to/target`.

Target receives `.cursorrules` (`TRAINER_CTO_SOURCE`) + `.training.cto/`. **All generated training stays under `.training.cto/`.**

---

## Standard vs custom programs

| Mode | How |
|------|-----|
| **Standard** | `@cto-program-standard list` → `install - cto-foundations` |
| **Custom** | `@cto-program-custom - 6-week eng leadership for Series B CTO` |
| **Free-text** | `@cto-director - design a board-comms intensive for me` |

| Slug | Focus |
|------|-------|
| `cto-foundations` | Role, leverage, calendar, decisions |
| `engineering-leadership` | Org, hiring, performance, culture |
| `delivery-systems` | Roadmap, architecture, reliability, debt |
| `product-stakeholder` | Product partnership, exec/board |
| `governance-risk` | Security, compliance, vendor, AI governance |
| `strategy-scale` | Scale, diligence, platform bets |
| `continuous-edge` | Ongoing updates (`@cto-update`) |

Catalog: [`curricula/`](curricula/)

---

## Coexistence

Sibling of Agent OS (`.ai`), Business OS (`.ai.biz`), UI OS (`.ai.ui`), Social OS (`.ai.soc`). Use `@x-director` for cross-domain work. `@cto-director` redirects pure engineering/UI/biz requests to the matching director.

---

## Verify & contribute

```bash
bash scripts/framework-verify.sh
```

See [`CONTRIBUTING.md`](CONTRIBUTING.md) · [`CHANGELOG.md`](CHANGELOG.md) · [`LICENSE`](LICENSE)
