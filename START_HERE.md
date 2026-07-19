# START HERE — CTO learner decision tree

**Purpose:** Answer one question fast: *"What do I train or consult on right now?"*

**Read this when you sit down, are interrupted, or feel lost.**

**Rule:** If something below contradicts a `skill.md` or binding standard, the **skill / standard wins**.

**Paths:** Fat-client nested → prefix with `.ai.cto/`. Self-hosted / thin-client source → no prefix. Learner memory is always **`.training.cto/`** at the project root.

---

## 0. Three things to know

1. **Truth before comfort.** The professor corrects flawed assumptions. Drills beat lectures.
2. **Skills orchestrate. Standards bind. Memory persists.** Almost never read everything at once.
3. **Framework vs `.training.cto/`:** skills/curricula/standards (framework) vs profile, programs, sessions, consultancy (learner memory).

---

## 1. Decision tree

**First fork — which repo/session is this?** If you are editing `skills/`, `curricula/`, `standards/`, `templates/`, `scripts/`, or `.cursorrules` themselves (framework-dev work on this OS), **stop here** — everything below is for a *training project* (a learner using the pipeline). Do not run `@cto-bootstrap init` or chain into the learner pipeline just because a self-hosted `.training.cto/` looks empty; that only applies when you (or the user) explicitly want to create/initialize a training project.

```text
┌──────────────────────────────────────────┐
│  Where am I right now?                   │
└──────────────────────────────────────────┘
       │
       ├── "Setting up a NEW training project" ──► `@deploy-basic - <path>` (from source) or `@cto-bootstrap init`
       │
       ├── "Empty / no .training.cto" AND explicit training intent ──► `@cto-bootstrap init`
       │
       ├── "Just opened / lost"           ──► §2 Resume
       │
       ├── "Don't know my level / gaps"   ──► `@cto-assess run`
       │
       ├── "Want a standard program"      ──► `@cto-program-standard list`
       │
       ├── "Want a custom program"        ──► `@cto-program-custom - <request>`
       │
       ├── "Ready to train today"         ──► `@session-cto start` → `@cto-mentor run`
       │
       ├── "Need consultancy / decision"  ──► `@cto-consult memo - <topic>`
       │
       ├── "Want a practical drill"       ──► `@cto-drill run - <type>`
       │
       ├── "Refresh sources / trends"     ──► `@cto-update run`
       │
       ├── "Check progress / gates"       ──► `@cto-review status`
       │
       ├── "Don't know which skill"       ──► `@cto-director - <describe>`
       │
       └── "Closing for the day"          ──► `@session-cto close`
```

---

## 2. Resume / orient (≤5 minutes)

| Need | Command |
|------|---------|
| Where am I / what's next? | `@session-cto status` + `.training.cto/context/HANDOFF.md` + `.training.cto/plans/NEXT.md` |
| Free-text / unknown skill | `@cto-director - <what you want>` |
| Gate / readiness state | `@cto-review status` |

---

## 3. First-time setup

**Brand-new target project, thin-client (recommended):** create the repo (`mkdir` + `git init`) → from **this source** repo/chat run `@deploy-basic - /path/to/new-repo` (only the source session knows its own path) → open the target and continue below. `@cto-bootstrap init` run standalone inside a never-deployed target cannot wire the thin-client pointer on its own — pass the source explicitly (`@cto-bootstrap init - <source-path>`) if you must run it that way.

| Step | Run |
|------|-----|
| 1. Scaffold memory (if not already done by `@deploy-basic`) | `@cto-bootstrap init` |
| 2. Fill profile | Edit `.training.cto/context/PROFILE.md` (or let bootstrap interview) |
| 3. Assess | `@cto-assess run` |
| 4. Install or design program | `@cto-program-standard install - <slug>` **or** `@cto-program-custom - <request>` |
| 5. First session | `@session-cto start` → `@cto-mentor run` |

---

## 4. Standard catalog (quick)

| Slug | Focus |
|------|-------|
| `cto-foundations` | Role, leverage, calendar, decisions |
| `engineering-leadership` | Org, hiring, performance, culture |
| `delivery-systems` | Roadmap, architecture, reliability, debt |
| `product-stakeholder` | Product partnership, exec/board |
| `governance-risk` | Security, compliance, vendor, AI governance |
| `strategy-scale` | Scale, diligence, platform bets |
| `continuous-edge` | Ongoing updates (fed by `@cto-update`) |

---

## 5. Closing the day

1. `@session-cto close` — refreshes HANDOFF + NEXT  
2. Optionally draft a commit of `.training.cto/` changes (you commit; agent does not unless asked)

---

## 6. Reading order (understanding the system)

1. This file  
2. [`README.md`](README.md) — bird's-eye  
3. [`PROCESS_ROUTER.md`](PROCESS_ROUTER.md) — how-to → skill  
4. [`skills/README.md`](skills/README.md) — registry  
5. Active program under `.training.cto/programs/`
