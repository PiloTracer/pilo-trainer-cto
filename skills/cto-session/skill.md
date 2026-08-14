---
name: cto-session
description: >-
  Open or close a CTO training session with verified context load, HANDOFF and NEXT
  updates, and optional git commit/push. Commit scope is repo-mode dependent: all
  safe modified/added/untracked files repo-wide in the self-hosted framework source,
  or scoped to the `.work.cto/` working directory in deployed targets (thin/fat).
  Also supports standalone commit/push without closing (git add + git commit + git
  push, no HANDOFF/NEXT update). `context` loads all mandatory context read-only and
  is uncommitted-aware (surfaces dirty-tree status without writing HANDOFF). Use when
  the user says cto-session start, cto-session close, @cto-session start, close commit,
  close commit push, close commit scoped, commit, commit push, or cto-session context.
  Never commits unless the invocation includes commit. On commit, MUST run git add +
  git commit in the shell for all safe changes in the repo-mode scope — including new
  untracked files/dirs (not HANDOFF-only, never secrets-pattern paths).
---

# cto-session

Bookend CTO training sessions so the next chat (or the learner) can resume without guessing. **Tool-agnostic**; works in the self-hosted framework source and in any target repo that has a `.work.cto/` working directory.

**Pairs with:** `.cursorrules`, `@cto-bootstrap` (creates `.work.cto/`), `@cto-review` (gate state), `{HANDOFF}` / `{NEXT}`.

**Canonical path:** `skills/cto-session/skill.md` · **Invocation examples + detailed protocols:** `reference.md`

**Hard rules:**

- **Default close / default commit:** never `git commit` or `git push`. Only when the invocation includes **`commit`** and/or **`push`** (see [Parse invocation](#parse-invocation)). The flag *is* the explicit request required by `.cursorrules`.
- **`close commit` / `close commit push` / `commit` / `commit push`:** **MUST** run `git add` + `git commit` in the shell (see [reference.md § Close protocol (detailed)](reference.md#close-protocol-detailed) (C4b) / [Commit protocol](#commit-protocol)), staging the full **repo-mode scope** (default, incl. new untracked files/dirs — see [Repo mode](#repo-mode-decides-commit-scope)). A dirty in-scope tree after close with only a draft message is **fail**.
- **Always** show the commit message — drafted, used for commit, or `none - working tree clean`.
- **`commit` / `commit push` (standalone):** run git add + commit + push **without** updating HANDOFF or NEXT. Session stays open. Useful for mid-session checkpoints.
- **Commit scope follows repo mode:** repo-wide in the self-hosted framework source; **`.work.cto/` only** in deployed targets — framework dirs (`skills/`, `curricula/`, …) and target app code stay out of target session commits.
- **Secrets scan before any close/commit.** A match halts the run — no HANDOFF/NEXT writes, no git.
- Never paste secrets from `.env`, `credentials/`, or tokens into chat or HANDOFF.
- Every git-capable mode ends with a **Completion checklist** — each item `pass` | `fail` | `skip` with evidence.
- No `Co-authored-by:` trailers, no `--no-verify`, no force-push, no amend.

### Path resolution (mandatory before any Read)

Resolve from the **current repo root**. `{WORK_ROOT}` = **`.work.cto/`** — not the repo root. In thin/fat clients and in the self-hosted source the paths are the same; only the framework assets move.

| Artifact | Read / write this path |
|----------|------------------------|
| `{HANDOFF}` | `.work.cto/context/HANDOFF.md` |
| `{NEXT}` | `.work.cto/plans/NEXT.md` |
| `{UNKNOWNS}` | `.work.cto/plans/UNKNOWNS.md` |
| `{PROFILE}` | `.work.cto/context/PROFILE.md` |
| Active program | `.work.cto/programs/<slug>/PROGRAM.md` + `progress.md` |

**Never** open `context/HANDOFF.md`, `plans/NEXT.md`, or bare `HANDOFF.md` / `NEXT.md` at repo root — those paths are wrong for CTO Professor OS.

### Repo mode (decides commit scope)

Detect **before any git action** (first match wins):

| # | Signal | Repo mode | Default commit scope |
|---|--------|-----------|----------------------|
| 1 | `.cursorrules` contains `TRAINER_CTO_SOURCE=` set to a real path (not `REPLACE_BASICSOURCE`) | **thin target** | `.work.cto/` only |
| 2 | `.ai.cto/skills/cto-session/skill.md` exists | **fat target** | `.work.cto/` only |
| 3 | `skills/cto-session/skill.md` exists at repo root | **self-hosted source** | **repo-wide** — every safe modified/added/untracked file (`git add -A`) |
| 4 | none of the above | target (fallback) | `.work.cto/` only |

**`{SCOPE}`** below means: the repo root in **self-hosted source** mode, `.work.cto/` otherwise. Only the secrets scan (C1) excludes paths from staging; report any excluded path as a follow-up. `commit scoped` always narrows to HANDOFF + NEXT + session-listed paths, in both modes.

---

## Parse invocation

Normalize the user message to **verb** + optional **modifiers**. Order-insensitive.

| User says | Verb | Git action |
|-----------|------|------------|
| `@cto-session` **start** [- \<goal\>] | start | — |
| `@cto-session` **close** | close | draft message only |
| `cto-session` **close** **commit** | close | commit all **safe** changes in `{SCOPE}` (default — [reference.md § Close protocol (detailed)](reference.md#close-protocol-detailed) (C4b)) |
| `cto-session` **close** **commit** **scoped** | close | commit only HANDOFF + NEXT + paths listed in close report |
| `cto-session` **close** **commit** **push** | close | commit then push |
| `cto-session` **close** **push** | close | treat as **commit push** (`push` requires commit) |
| `cto-session` **commit** | commit | commit all safe changes in `{SCOPE}` (default scope), NO close |
| `cto-session` **commit** **push** | commit | commit then push, NO close |
| `cto-session` **push** | push | push only if tree already committed; else warn + treat as **commit push** |
| `@cto-session` **context** | context | — (read-only full load) |
| `@cto-session` **status** | status | — (read-only compact snapshot) |

**Aliases (same verb):** `begin`, `open` → start; `end`, `handoff` → close.

**Goal text:** anything after `-` or on a new line after `start` (not the words `commit`/`push`/`scoped`).

**Commit scope:** default is the **repo-mode `{SCOPE}`** — all safe changed + **new untracked files/dirs** in scope (`git add -A` in the self-hosted source; `git add -A -- .work.cto` in targets). Nothing out of scope is staged. Use **`commit scoped`** only when the user wants bookend files only.

**Standalone commit/push:** `commit` / `commit push` run the same git steps as `close commit` / `close commit push` but **skip** HANDOFF and NEXT updates. The session remains open. Bare `push` without `commit` pushes only already-committed work; if the in-scope tree has uncommitted changes, warn that they are **not** included and recommend `commit push`.

**On `start` / `status` / `context`, `commit`/`push` flags are ignored** — say so.

---

## Step 0 — Pick a mode

| Mode | Triggers | Action |
|------|----------|--------|
| **start** | `start`, optional goal | [Start protocol](#start-protocol) |
| **close** | `close` [commit] [scoped] [push] | [Close protocol](#close-protocol) |
| **commit** | `commit` [push] | [Commit protocol](#commit-protocol) — git only; no HANDOFF/NEXT writes |
| **push** | `push` (no commit) | push current branch; warn on uncommitted in-scope changes |
| **context** | `context` | [Context protocol](#context-protocol) — full mandatory context load + uncommitted-aware summary; no writes |
| **status** | `status` | [Status protocol](#status-protocol) — compact snapshot; no writes |

If the user gives a **session goal** with start (e.g. `start - mentoring on delegation`), capture it in the start report.

### Session-type classification (on start)

Classify before loading learner context:

- **Training session** — a learner using the pipeline in a deployed target (or an explicit training project in this repo). Run the full start protocol.
- **Framework-dev session** — the work is editing `skills/`, `curricula/`, `standards/`, `templates/`, `scripts/`, or `.cursorrules`. Still bookend (HANDOFF/NEXT updates are allowed — they are the session log), but: skip PROFILE/program reads, never propose `@cto-bootstrap init` / `@cto-assess run` / program skills, and never auto-route into the learner pipeline just because `{PROFILE}` has unfilled `REPLACE:` tokens.

---

## Start protocol

### S1 — Baseline reads (mandatory)

Read table (`.cursorrules`, HANDOFF, NEXT, UNKNOWNS, PROFILE + active program): [reference.md § Start protocol (detailed)](reference.md#start-protocol-detailed) (S1).

### S2 — Conditional reads (goal-based)

Goal-based conditional read table (mentoring / drill / consult / program work → matching standard + program files): [reference.md § Start protocol (detailed)](reference.md#start-protocol-detailed) (S2).

### S3 — Environment snapshot (evidence)

Git snapshot (`git status -sb`, `git log -1 --oneline`) + repo-mode detection: [reference.md § Start protocol (detailed)](reference.md#start-protocol-detailed) (S3).

### S4 — Session goal (interaction)

Capture goal; ask once if unclear: [reference.md § Start protocol (detailed)](reference.md#start-protocol-detailed) (S4).

### S5 — Mark session active (HANDOFF)

Update `**Session state:**` + Latest action date only: [reference.md § Start protocol (detailed)](reference.md#start-protocol-detailed) (S5).

### S6 — Start report (mandatory output)

Start report template and checklist: [reference.md § Start protocol (detailed)](reference.md#start-protocol-detailed) (S6).

---

## Status protocol

Read-only snapshot. **No** HANDOFF/NEXT writes. **No** completion checklist.

1. Read `.work.cto/context/HANDOFF.md` and `.work.cto/plans/NEXT.md`.
2. Run `git status -sb` and `git log -1 --oneline`.
3. Output:

```markdown
## Session status — <Project>

**Session:** active | idle — <date> — <goal if active>
**Repo mode:** self-hosted source | thin target | fat target
**Readiness:** <gate state: profile-ready / assessed / program-active / mentoring-loop>
**Branch:** <branch> · **Tree:** clean | dirty
**Pick up:** <one line from NEXT.md>
**Blockers:** <short list or none>
```

Optional: one line on dirty files (no full diff). For full context load, use **start**. For full context load **without** HANDOFF writes + uncommitted-aware detail, use **context**.

---

## Context protocol

Read-only full context load. **No** HANDOFF/NEXT writes. **No** completion checklist (it is read-only, like `status`); end with the context report. Sits between `status` (one-line compact) and `start` (full load + marks HANDOFF active).

Difference from `start`: writes nothing. Difference from `status`: loads the **full mandatory context set** (S1) plus a dirty-tree **diff summary**, not just a one-liner.

Use when: the learner (or a second agent) wants full session context for ad-hoc reasoning without opening/closing a session bookend — mid-session orientation, "what changed and what's next" without mutating HANDOFF.

### X1 — Mandatory context reads (read in full)

Same set as [S1](reference.md#s1--baseline-reads-mandatory): [reference.md § Context protocol (detailed)](reference.md#context-protocol-detailed) (X1).

### X2 — Uncommitted-aware snapshot (evidence)

`git status -sb` + diff stats + last commit; classify clean/dirty by area; secrets-flag pass without printing content: [reference.md § Context protocol (detailed)](reference.md#context-protocol-detailed) (X2).

### X3 — Context report (mandatory output)

Context report template: [reference.md § Context protocol (detailed)](reference.md#context-protocol-detailed) (X3).

---

## Commit protocol

**Execution order:** M1 → M2 → M3 → M4 (draft message) → M5 (git, if `commit`/`push`) → M6 (report).

Runs git commit and optional push **without** updating HANDOFF or NEXT. Session remains open. Idempotent — re-runnable mid-session.

If M1 secrets **fail**, **stop** — do not run M4 or M5.

### M1 — Working tree audit (same as C1)

Same as [C1 in reference.md § Close protocol (detailed)](reference.md#close-protocol-detailed).

### M2 — Verification gate (same as C2)

Same as [C2 in reference.md § Close protocol (detailed)](reference.md#close-protocol-detailed).

### M3 — Follow-ups

Same as [C3 in reference.md § Close protocol (detailed)](reference.md#close-protocol-detailed).

### M4 — Commit message (always)

Always produce the commit message block — even when tree is clean. Ref prefix (if known), subject/body format, and report labels: [reference.md § Commit protocol (detailed)](reference.md#commit-protocol-detailed) (M4).

### M5 — Git actions (modifiers only)

Same as [C4b in reference.md § Close protocol (detailed)](reference.md#close-protocol-detailed). **Hard rules:** agent MUST run shell git; no `Co-authored-by:` trailers; no empty commits.

### M6 — Commit report (mandatory output)

Report template and checklist: [reference.md § Commit protocol (detailed)](reference.md#commit-protocol-detailed) (M6).

---

## Close protocol

**Execution order:** C1 → C2 → C3 → C4 (draft message) → C5 (HANDOFF) → C6 (NEXT) → C4b (git, if `commit`/`push`) → C7 (report).

If C1 secrets **fail**, **stop** — do not run C5, C6, or C4b; report failure in C7.

### C1 — Working tree audit (mandatory)

`git status` + diff stats; classify findings; **secrets scan** (halt close on match). Full table and patterns: [reference.md § Close protocol (detailed)](reference.md#close-protocol-detailed) (C1).

### C2 — Verification gate (this session)

Completion-gate honesty table (artifacts produced, evidence paths, framework-verify when framework files changed, unverified items): [reference.md § Close protocol (detailed)](reference.md#close-protocol-detailed) (C2).

### C3 — Follow-ups required

Detect uncommitted work, stale HANDOFF/NEXT, unticked task ledgers, open unknowns, owner actions, temp files. Checklist: [reference.md § Close protocol (detailed)](reference.md#close-protocol-detailed) (C3).

### C4 — Commit message (always)

Always show a commit message in the close report. Ref prefix priority and format: [reference.md § Close protocol (detailed)](reference.md#close-protocol-detailed) (C4).

### C4b — Git actions (modifiers only)

Modifier table, repo-mode **default commit scope**, HEREDOC commit shape, post-commit verification. Full spec: [reference.md § Close protocol (detailed)](reference.md#close-protocol-detailed) (C4b).

### C5 — Update HANDOFF (mandatory on close)

Session state → `idle`, Latest action block rewrite, active focus + carry-forward refresh: [reference.md § Close protocol (detailed)](reference.md#close-protocol-detailed) (C5).

### C6 — Update NEXT.md (mandatory on close)

Done / Immediate next action / Queue / Blocked refresh: [reference.md § Close protocol (detailed)](reference.md#close-protocol-detailed) (C6).

### C7 — Close report (mandatory output)

Close report template and checklist: [reference.md § Close protocol (detailed)](reference.md#close-protocol-detailed) (C7).

---

## Critical interactions

| When | Ask / do |
|------|----------|
| **Start** | Prior HANDOFF says `idle` → treat as new session; do not assume prior chat memory |
| **Start** | Missing `.work.cto/` or HANDOFF → offer `@cto-bootstrap init` (training intent) or create minimal HANDOFF (framework-dev); do not invent learner history |
| **Start** | Framework-dev session → skip PROFILE/program reads; never route into the learner pipeline unprompted |
| **Close** | `close commit` / `close commit push` → run C4b in shell after HANDOFF/NEXT; stage the **repo-mode scope** (repo-wide in the source, `.work.cto/` in targets) |
| **Commit** | User says `@cto-session commit` → run [Commit protocol](#commit-protocol); **do not** update HANDOFF or NEXT |
| **Push** | Bare `push` with uncommitted in-scope changes → warn they are excluded; recommend `commit push` |

Full table: [reference.md § Critical interactions](reference.md#critical-interactions).

---

## Rules

- **Write scope (mandatory):** `start` / `status` / `context` / `close` write only under `.work.cto/` (HANDOFF, NEXT, session files). Never create, edit, move, or delete files outside `.work.cto/` as part of a cto-session action — `.work.cto/` is the full *write* domain of this skill in every repo mode.
- **Git scope (mandatory):** staging follows [Repo mode](#repo-mode-decides-commit-scope) — `git add -A` (repo-wide) in the self-hosted source; the explicit pathspec `git add -A -- .work.cto` in targets. Never amend, rebase, or force-push; never stage secrets-pattern paths in either mode.
- Files outside `.work.cto/` may only be *referenced* — read, or mentioned in HANDOFF/NEXT — when they are already part of the changes in the current session context (e.g. code the learner worked on, or framework files edited in the source repo). Even then, cto-session never modifies them.
- Never claim progress without referencing an artifact path under `.work.cto/`.
- Never claim "committed" without showing the SHA from `git log -1 --oneline`.

## Anti-patterns

- Claiming "context loaded" without reading HANDOFF and NEXT
- Closing a session without updating HANDOFF and NEXT (on **close**)
- **`close commit` without running `git commit`** or without a new SHA
- **Staging outside `.work.cto/` in a target repo** — target session commits are `.work.cto/`-scoped (repo-wide staging is correct only in the self-hosted source)
- **Committing only `.work.cto/` in the self-hosted source** when other safe repo files are dirty — source-mode commits are repo-wide
- Committing HANDOFF-only while other safe in-scope paths remain dirty (that is `commit scoped`, not default `commit`)
- Omitting the commit message block from close/commit reports
- Running HANDOFF/NEXT updates on standalone `commit` / `commit push`
- Creating empty commits (skip when the staged tree is clean — report `nothing to commit in scope`)
- Adding `Co-authored-by:` trailers

Full list: [reference.md § Anti-patterns](reference.md#anti-patterns).

---

## Project layout (convention)

**`{WORK_ROOT}` = `.work.cto/`** at the repo root (writes always land here). See [reference.md § Project layout](reference.md#project-layout-convention). Session git commits are **scoped by repo mode**: repo-wide in the self-hosted source, `.work.cto/` in targets (default scope).
