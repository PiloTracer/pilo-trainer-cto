# cto-session — reference

Supplement to `skill.md`. Invocation examples, detailed protocols, report templates, and edge cases.

**`{SCOPE}`** throughout this file means the **repo-mode commit scope** from `skill.md` § Repo mode:

| Repo mode | Detection | `{SCOPE}` |
|-----------|-----------|-----------|
| **self-hosted source** | `skills/cto-session/skill.md` at repo root (and no live `TRAINER_CTO_SOURCE` pointer, no `.ai.cto/`) | **repo-wide** — every safe modified/added/untracked file |
| **thin target** | `.cursorrules` has `TRAINER_CTO_SOURCE=` set to a real path | `.work.cto/` only |
| **fat target** | `.ai.cto/skills/cto-session/skill.md` exists | `.work.cto/` only |
| **target (fallback)** | none of the above | `.work.cto/` only |

---

## Invocation examples

**Canonical forms** — do not require the word `session`:

| Action | Prompt |
|--------|--------|
| Open | `@cto-session` **start** |
| Open + goal | `cto-session` **start** - mentoring on delegation |
| Close | `@cto-session` **close** |
| Close + commit (all safe in-scope changes incl. new files) | `cto-session` **close** **commit** |
| Close + commit (HANDOFF/NEXT only) | `cto-session` **close** **commit** **scoped** |
| Close + commit + push | `cto-session` **close** **commit** **push** |
| **Commit only (no close)** | `@cto-session` **commit** |
| **Commit + push (no close)** | `cto-session` **commit** **push** |
| **Push only (already-committed work)** | `cto-session` **push** |
| **Full context load (no writes, uncommitted-aware)** | `@cto-session` **context** |
| Load check | `@cto-session` **status** |

Legacy aliases still work: `begin`, `open` → start; `end`, `handoff` → close.

### Cursor / Claude Code / Codex

```
@cto-session start
@cto-session close
@cto-session close commit
@cto-session close commit push
@cto-session commit
@cto-session commit push
@cto-session context
```

### Close modifiers (git)

| Invocation | Commit? | Push? | Commit message in report | Closes session? |
|------------|---------|-------|--------------------------|-----------------|
| `close` | no | no | **always** (draft) | yes |
| `close commit` | yes | no | **always** (used + SHA if ok) | yes |
| `close commit scoped` | yes (bookend files only) | no | **always** | yes |
| `close commit push` | yes | yes | **always** (used + push result) | yes |
| `close push` | yes | yes | same as `close commit push` | yes |
| `commit` | yes | no | **always** (used + SHA if ok) | **no** |
| `commit push` | yes | yes | **always** (used + push result) | **no** |
| `push` | no (warn if dirty) | yes | **always** (draft) | **no** |

Default `close` never runs `git commit` or `git push`. The user runs git manually from the drafted message if they want.

**`close commit` / `commit` default scope:** stage all **safe** changes in the repo-mode `{SCOPE}` from `git status --porcelain`, **including new untracked files/dirs** — **not** HANDOFF/NEXT only. In **targets** that means `.work.cto/` (`git add -A -- .work.cto`; framework dirs and app code stay unstaged). In the **self-hosted source** that means the whole repo (`git add -A`; every framework file, doc, and script travels). Agent **must** run shell `git add` + `git commit` and show SHA + post-commit `git status -sb`. See [Close protocol (detailed)](#close-protocol-detailed) (C4b).

**Standalone `commit` / `commit push`:** same git behavior as `close commit` / `close commit push` but **skips** HANDOFF and NEXT updates. Session stays open.

### Natural language triggers

| Phrase | Maps to |
|--------|---------|
| `start` / `begin` / `open` | start |
| `close` / `end` / `handoff` | close |
| `close commit` | close + commit |
| `close commit push` | close + commit + push |
| `commit` | commit only (no close) |
| `commit push` | commit + push, no close |
| `context` / full load without writes | context |
| `status` / where am I | status |

### Examples

**Start:**

```
@cto-session start - drill: board update under pressure
```

**Close (default — no git write):**

```
@cto-session close
```

Expect: HANDOFF/NEXT updated; **Commit message** section with draft text; git checklist items `skip`.

**Close with commit:**

```
cto-session close commit
```

Expect: HANDOFF/NEXT updated; agent stages the repo-mode `{SCOPE}` (incl. new untracked files/dirs) + `git commit`; report shows SHA and `git status -sb` (clean or explicit leftovers). **Fail** if only bookend files were committed while other safe in-scope changes remain unstaged, or (in a target) if files outside `.work.cto/` were staged.

**Close with commit and push:**

```
cto-session close commit push
```

Expect: commit then `git push`; report shows push result or the missing-upstream instructions.

**Commit only (no close):**

```
cto-session commit
```

Expect: git audit, message drafted (`docs: cto session <date>` or ref-prefixed), `git add` + `git commit` run, session **remains active**. No HANDOFF/NEXT updates.

---

## Mode comparison

| | start | status | context | close | close commit | close commit push | **commit** | **commit push** |
|---|-------|--------|---------|-------|--------------|-------------------|-----------|----------------|
| Read HANDOFF/NEXT | yes | yes | yes | yes | yes | yes | **no** | **no** |
| Update HANDOFF | active | no | no | idle | idle | idle | **no** | **no** |
| Update NEXT | no | no | no | yes | yes | yes | **no** | **no** |
| `git commit` | no | no | no | no | yes | yes | **yes** | **yes** |
| `git push` | no | no | no | no | no | yes | **no** | **yes** |
| Commit message in output | no | no | no | **always** | **always** | **always** | **always** | **always** |
| Completion checklist | yes | no | no | yes | yes | yes | **yes** | **yes** |

---

## HANDOFF — session state templates

The CTO HANDOFF uses `**Session state:**` (values `active` / `idle`) plus a `## Latest action` block — the equivalents of Agent OS Open/Closed.

### Active (after start)

```markdown
**Last updated:** 2026-08-14
**Session state:** active

## Latest action

**Date:** 2026-08-14
**Request:** `@cto-session start - drill: board update under pressure`
```

### Idle (after close)

```markdown
**Last updated:** 2026-08-14
**Session state:** idle

## Latest action

**Date:** 2026-08-14
**Request:** `@cto-session close commit push`
**Executed:**
1. …
**Blockers:** none
**Next recommended:** see `.work.cto/plans/NEXT.md`
```

Treat `idle` sessions as historical only; the next chat is a **new session** — do not assume unwritten goals from prior threads unless they appear in HANDOFF or linked artifacts.

---

## Git commands reference

| Purpose | Command |
|---------|---------|
| Short status | `git status -sb` |
| Close audit | `git status` + `git diff --stat` + `git diff --cached --stat` |
| Stage session scope — self-hosted source | `git add -A` |
| Stage session scope — target | `git add -A -- .work.cto` |
| Staged? | `git diff --cached --quiet` (exit 1 = there is something to commit) |
| After commit | `git log -1 --oneline` |

| When | Allowed |
|------|---------|
| `close` | audit only |
| `close commit` | `git status --porcelain` → stage safe paths in `{SCOPE}` (default; incl. new untracked files/dirs) → `git commit` → `git status -sb` |
| `close commit scoped` | `git add` HANDOFF + NEXT (+ session-listed paths only) |
| `close commit push` | above + `git push` |
| `commit` | same as `close commit` but **no** HANDOFF/NEXT update |
| `commit push` | same as `close commit push` but **no** HANDOFF/NEXT update |
| `push` | `git push` only; warn if the in-scope tree is dirty |

Never on default `close`: commit or push. **Standalone `commit` / `commit push`** always runs git.

---

## Commit message rules (summary)

- Subject ≤72 chars, imperative, per `.cursorrules`: `type: description` (or `REF-123: subject` when a task ref is known).
- Body: why, not file list; omit if subject suffices.
- Default session message (targets): `docs: cto session <YYYY-MM-DD>`; with a closing note: `docs: cto session <YYYY-MM-DD>: <note>` (truncate to 72 chars).
- Self-hosted source sessions usually justify a real type: `feat:` / `fix:` / `docs:` / `refactor:` per the framework change (e.g. `feat: align cto-session with session-control verbs`).

### Ref prefix (optional, auto-detect)

CTO Professor OS has no task registry; a ref is used **only when one is already known**. Priority order:

1. **HANDOFF session goal** — `## Latest action` / goal text contains `[A-Z]+-[0-9]+` → use it.
2. **Branch name** — `(feature|fix|chore|docs)/[A-Z]+-[0-9]+` or `[A-Z]+-[0-9]+/` → extract.
3. **Last commit subject** — `git log -1 --oneline` starts with `[A-Z]+-[0-9]+` → reuse.
4. **No ref** → use the type-prefixed default. This is normal — never block on it, never invent one.

### Commit message examples

**Training session in a target (no ref):**

```
docs: cto session 2026-08-14

Mentoring on delegation; drill artifact + notes under .work.cto/.
```

**Session with closing note:**

```
docs: cto session 2026-08-14: board-update drill, round 2 scored
```

**Framework-dev session in the self-hosted source:**

```
feat: align cto-session with session-control verbs

Adds context verb, scoped modifier, and repo-mode commit scope.
```

**Known ref (branch `docs/CTO-12-session-skill`):**

```
CTO-12: align cto-session with session-control verbs
```

---

## Bootstrap (no HANDOFF yet)

If `.work.cto/context/HANDOFF.md` is missing:

1. Say HANDOFF is required for cto-session.
2. **Training intent:** offer `@cto-bootstrap init` (scaffolds `.work.cto/` + PROFILE).
3. **Framework-dev session:** offer a minimal HANDOFF (Last updated / Session state / Latest action / Active focus / Carry-forward) — do not invent learner history.

Do not create PROFILE or program files from cto-session.

---

## Integration with other skills

| Skill | When |
|-------|------|
| `cto-bootstrap` | Missing `.work.cto/` at start (training intent only) |
| `cto-review` **status** | Optional on start (gate state) or close (gate delta) |
| `cto-mentor` / `cto-drill` / `cto-consult` / `cto-update` | The work between start and close |
| User commit rule (`.cursorrules`) | Overrides any urge to commit on close — only the `commit`/`push` flags authorize git |

---

## Edge cases

| Situation | Behavior |
|-----------|----------|
| Repo not a git repo | `commit`/`push` report `skipped: <path> is not a git repository` and stop — no partial work |
| Merge conflict markers in tree | close checklist **fail**; list files |
| Target repo: only framework dirs / app code changed | Outside `.work.cto/` scope — session commit stages nothing; list as follow-up for a separate (user-run) commit |
| Self-hosted source: framework dirs dirty | **In scope** — repo-wide commit stages them; that is the point of source mode |
| Secrets-pattern path in `git status` | **fail** secrets check; halt; do not summarize content |
| User closes mid-drill | HANDOFF Latest action notes "in-flight: …" under Executed |
| Multiple logical changesets | close report suggests 2+ message blocks (user commits separately; session commit stays single + in-scope) |
| HANDOFF already `active`, new `start -` goal | Update Latest action goal + date; note prior goal in start report |
| HANDOFF `active`, same-goal `start` again | Refresh date only; do not duplicate reads in the report |
| Secrets scan fail | **Halt** close/commit — no HANDOFF/NEXT/git until resolved |
| Clean tree + `commit` | Skip commit; report `Commit message (used): none - working tree clean`; never create an empty commit |
| No upstream on `push` | Report it; give the exact `git push -u origin <branch>` command for the user — do not run it (that sets git config) |
| Repo mode ambiguous (both `.ai.cto/` and root `skills/` present) | Prefer the live `TRAINER_CTO_SOURCE` pointer → thin target; else treat root `skills/` as self-hosted source; state the decision in the report |

---

## Wrong prompts

| Prompt | Problem | Use instead |
|--------|---------|-------------|
| `close` expecting auto-commit | Default is draft only | `close commit` |
| `close commit` but tree still dirty | Agent staged HANDOFF-only or skipped shell git | Re-run close; follow C4b default scope |
| `close commit` for bookend files only | Default commits the repo-mode scope | `close commit scoped` |
| `push` expecting uncommitted work to ship | Push only moves commits | `commit push` |
| `commit` expecting HANDOFF update | Standalone commit skips HANDOFF/NEXT | Use `close commit` instead |
| `commit push` expecting session close | Standalone commit keeps session open | Use `close commit push` instead |
| `context` expecting session to open | Context writes nothing | Use `start` |
| `start` without reading files | Skill requires evidence | Full start protocol |
| Omitting commit message from report | Violates skill | Always show ### Commit message |

---

## Start protocol (detailed)

<a id="start-protocol-detailed"></a>

### S1 — Baseline reads (mandatory)

Read these files **in full** (or confirm missing). Record `pass` only after reading.

| # | File (repo-root path) | Pass criteria |
|---|----------------------|----------------|
| 1 | `.cursorrules` | Can state: identity, core principles, memory boundary (`.work.cto/`-only writes), no-commit rule |
| 2 | `.work.cto/context/HANDOFF.md` | Know: Session state, Latest action, Active focus, Carry-forward |
| 3 | `.work.cto/plans/NEXT.md` | Know: immediate next action + queue + blocked |
| 4 | `.work.cto/plans/UNKNOWNS.md` | Know: every open unknown + how to resolve; cross-check against HANDOFF Carry-forward — stale entries must be noted in the start report |
| 5 | `.work.cto/context/PROFILE.md` **(training sessions)** | Know: learner level, primary goal; unfilled `REPLACE:` tokens are a *note*, not a trigger to bootstrap |
| 6 | Active program `.work.cto/programs/<slug>/PROGRAM.md` + `progress.md` **(if HANDOFF names one)** | Know: current module, task ledger Done/Total |

Framework-dev sessions: rows 5–6 are `skip` — read rows 1–4 only.

### S2 — Conditional reads (goal-based)

If the goal names a domain, read the binding standard/program file before claiming start complete:

| Goal touches | Read |
|--------------|------|
| Mentoring / teaching | `standards/mentoring.md` (binding protocol) |
| Drill | `standards/mentoring.md` + `drills/case-library.md` (if case-based) |
| Consultancy / decision | `standards/decision-record.md` |
| Assessment / gates | `standards/assessment.md` |
| Program progress | active program `progress.md` (task ledger) |
| Framework-dev | only the framework files the task touches |

In targets, framework paths resolve via the source-resolution rule in `.cursorrules` (`$TRAINER_CTO_SOURCE/…` for thin, `.ai.cto/…` for fat, repo root for self-hosted).

### S3 — Environment snapshot (evidence)

```bash
git status -sb
git log -1 --oneline
```

Record: branch, clean/dirty, last commit, **repo mode** (per `skill.md` § Repo mode — it decides the commit scope later). Not a git repo → say so; start still works (git modes will report the skip).

### S4 — Session goal (interaction)

Capture goal from (in order): text after `start -`, else HANDOFF Latest action / NEXT immediate action, else ask **once**:

**Q:** What is the goal for this session? (one line — mentor / drill / consult / assess / framework task)

Do **not** ask if the goal is already clear from invocation or HANDOFF. Store in the start report only; do not rewrite HANDOFF beyond S5.

### S5 — Mark session active (HANDOFF)

Update **only** the top of `{HANDOFF}`:

- `**Last updated:**` → today
- `**Session state:**` → `active`
- `## Latest action` → Date today, Request = the invocation (incl. goal)

Preserve all other sections. Do not mark `active` on `status` / `context`.

### S6 — Start report (mandatory output)

```markdown
## Session started — <Project Name>

**Date:** <ISO date> · **Branch:** <branch> · **Working tree:** clean | dirty
**Session type:** training | framework-dev · **Repo mode:** self-hosted source | thin target | fat target

### Completion checklist
| # | Check | Result | Evidence |
|---|-------|--------|----------|
| 1 | .cursorrules read | pass/fail | |
| 2 | HANDOFF read | pass/fail | Session state: active/idle |
| 3 | NEXT read | pass/fail | |
| 4 | UNKNOWNS read | pass/fail | |
| 5 | PROFILE read | pass/skip | skip on framework-dev |
| 6 | Active program read | pass/skip | <slug> or none |
| 7 | Conditional reads | pass/skip | <paths> |
| 8 | Git snapshot + repo mode | pass/skip | <one-liner + mode> |
| 9 | Session goal captured | pass | <goal> |
| 10 | HANDOFF marked active | pass/skip | |

### Cleared to work when
All mandatory checks (1–4, 7–9) are **pass**; rows 5–6 **pass** or **skip** (framework-dev / no active program — note in report).

### Pick up here
<quote immediate next action from NEXT.md>

### Open blockers
<from NEXT.md / UNKNOWNS.md, or none>

### Proposed first action
<one concrete invoke — @cto-mentor run / @cto-drill run - <type> / @cto-consult memo / framework task; never a learner-pipeline proposal on framework-dev sessions>

### Principles reminder (3 bullets max)
<from .cursorrules — not a full paste>
```

---

## Status protocol (detailed)

Read-only. No writes, no checklist. Output shape in `skill.md` § Status protocol (includes the repo-mode line). Readiness comes from the gate state in HANDOFF/`.work.cto/` artifacts (`profile-ready` → `assessed` → `program-active` → `mentoring-loop`); on framework-dev sessions state `framework-dev` instead.

---

## Context protocol (detailed)

<a id="context-protocol-detailed"></a>

### X1 — Mandatory context reads (read in full)

Same set as [S1](#s1--baseline-reads-mandatory) (including PROFILE + active program on training sessions). Conditional reads per [S2](#s2--conditional-reads-goal-based) only when the operator named a domain.

### X2 — Uncommitted-aware snapshot (evidence)

Run:

```bash
git status -sb
git diff --stat
git diff --cached --stat
git log -1 --oneline
```

Classify the working tree:
- **clean:** state explicitly; report last commit only.
- **dirty:** summarize by top-level area (e.g. `3 files .work.cto/programs/`, `1 file skills/cto-session/`); list staged vs unstaged vs untracked counts. **Do not** paste full diffs — file paths + per-area counts only (per `.cursorrules` no-PII/scope discipline). Flag any path matching the secrets scan patterns ([C1](#c1--working-tree-audit-mandatory)) without printing content.

### X3 — Context report (mandatory output)

```markdown
## Session context — <Project Name>

**Date:** <ISO date> · **Branch:** <branch> · **Working tree:** clean | dirty (N files)
**Repo mode:** self-hosted source | thin target | fat target · **Last commit:** <sha — subject>

### Context loaded
| # | File | Result | Note |
|---|------|--------|------|
| 1 | .cursorrules | pass | |
| 2 | .work.cto/context/HANDOFF.md | pass (or missing) | Session state: active|idle … |
| 3 | .work.cto/plans/NEXT.md | pass (or missing) | |
| 4 | .work.cto/plans/UNKNOWNS.md | pass (or missing) | |
| 5 | PROFILE / active program | pass/skip | |

### Uncommitted status (read-only)
- Staged: <N files> · Unstaged: <N files> · Untracked: <N files>
- Areas touched: <top-level dirs with counts>
- Commit scope if committed now: repo-wide | .work.cto/ (per repo mode)
- Secrets scan: clean | <flagged paths (not printed)>
- (Clean tree → omit this section; state "working tree clean".)

### Pick up here
<quote immediate next action from NEXT.md, or "no NEXT.md">

### Open blockers
<from HANDOFF / NEXT, or none>

### No files written
This mode is read-only: HANDOFF, NEXT, and UNKNOWNS are **not** modified. To open a session bookend, run `@cto-session start`.
```

### Anti-patterns (context)

- Treating `context` as `start` (writing the HANDOFF "active" line) — `context` writes nothing.
- Pasting raw `git diff` output (use per-area counts; respect no-PII/scope).
- Skipping the secrets-flag pass on a dirty tree.
- Claiming "context loaded" without reading the full S1 set every time the verb runs.

---

## Commit protocol (detailed)

<a id="commit-protocol-detailed"></a>

**Execution order:** M1 → M2 → M3 → M4 → M5 → M6.

### M1 — Working tree audit (same as C1)

Same as [C1](#c1--working-tree-audit-mandatory). On secrets **fail**, stop.

### M2 — Verification gate (same as C2)

Same as [C2](#c2--verification-gate-this-session).

### M3 — Follow-ups

Same as [C3](#c3--follow-ups-required).

### M4 — Commit message (always)

**Always** produce the commit message block — even when the tree is clean (`none - working tree clean`).

Format per `.cursorrules` (plain text, no surrounding quotes; subject ≤72 chars, imperative):

- Ref known (see [Ref prefix](#ref-prefix-optional-auto-detect)): `<REF>: <subject>`
- No ref: `docs: cto session <YYYY-MM-DD>` / `docs: cto session <YYYY-MM-DD>: <note>` (targets), or a real type prefix matching the framework change (self-hosted source).

Body optional — **why**, not file list. Label in report: **Commit message (draft)** vs **Commit message (used)**.

### M5 — Git actions (modifiers only)

Same as [C4b](#c4b--git-actions-modifiers-only) — repo-mode default scope, HEREDOC commit, post-commit verification, push if modifier includes `push`.

**Hard rule — agent MUST execute git:** Typing `@cto-session commit` does not commit by itself. The agent **MUST** run the shell commands. The checklist git item is **fail** if the tree still has unstaged safe in-scope changes and no commit SHA was produced.

**Hard rule — no Co-authored-by:** Never add `Co-authored-by:` trailers or `git commit --trailer`.

**Clean tree + `commit`:** skip commit; report `Commit message (used): none - working tree clean`. Never create an empty commit.

### M6 — Commit report (mandatory output)

```markdown
## Commit completed — <Project Name>

**Date:** <ISO date> · **Branch:** <branch> · **Repo mode:** <mode> (scope: repo-wide | .work.cto/)

### Checklist
| # | Check | Result | Evidence |
|---|-------|--------|----------|
| 1 | Git audit | pass/fail | clean / N files changed |
| 2 | Secrets safe | pass/fail | |
| 3 | Verification honest | pass/fail | |
| 4 | Follow-ups listed | pass | |
| 5 | Commit message shown | pass | always |
| 6 | Git commit | pass/fail/skip | SHA + `git status` evidence |
| 7 | In-scope tree staged | pass/fail/skip | leftover safe in-scope paths listed |
| 8 | Git push (if requested) | pass/fail/skip | modifier `push` |

### Commit message
**Status:** draft | used
**Message:**

    docs: cto session 2026-08-14

    Optional body.

**Git:** committed \<sha\> | push \<remote/branch\> result

**Session:** still active — no HANDOFF or NEXT changes.
```

---

## Close protocol (detailed)

<a id="close-protocol-detailed"></a>

**Execution order:** C1 → C2 → C3 → C4 (draft message) → C5 (HANDOFF) → C6 (NEXT) → C4b (git, if `commit`/`push`) → C7 (report).

If C1 secrets **fail**, **stop** — do not run C5, C6, or C4b; report failure in C7.

### C1 — Working tree audit (mandatory)

```bash
git status
git diff --stat
git diff --cached --stat
```

Detect the repo mode (`skill.md` § Repo mode), then classify:

| Finding | Action |
|---------|--------|
| Uncommitted changes in `{SCOPE}` | Summarize by area; draft commit message |
| Uncommitted changes outside `{SCOPE}` (targets only — impossible in source mode) | Out of scope — list as follow-up only |
| Untracked files in `{SCOPE}` | Include in default commit scope; flag if unexpected |
| Staged only | Note ready to commit |
| Clean tree | State explicitly |

Not a git repo → record `git unavailable: not a repository`; git checklist items become `skip` with that evidence.

**Secrets scan (mandatory):** Before summarizing diffs, confirm `git status` does not list paths matching: `credentials/`, `.env`, `.env.*` (except `.env.example`), `*.pem`, `*.p12`, `*.key`, `*.pfx`, `*.p8`, `*id_rsa*`, `*.token`, `*.secret`. If any match → checklist **fail**, **halt close** (no HANDOFF/NEXT/git); tell the user to unstage/remove and never commit content.

### C2 — Verification gate (this session)

Per `.cursorrules` core principles — answer honestly:

| Question | Answer |
|----------|--------|
| Learner artifacts produced this session? | yes / no — list paths under `.work.cto/` |
| Claims of progress backed by an artifact path? | yes / no |
| Framework files changed? (`skills/`, `curricula/`, `standards/`, `templates/`, `scripts/`, `.cursorrules`) | yes / no — if yes: `bash scripts/framework-verify.sh` run? result? |
| Assessments/drills scored with evidence? | yes / no / n/a |
| What remains unverified? | list |

Do not claim "all good" if a check failed. Never mark a drill or gate PASSED without its artifact.

### C3 — Follow-ups required

Detect and list:

- [ ] Uncommitted work in `{SCOPE}` needing commit (or intentional WIP)
- [ ] Targets only: changes outside `.work.cto/` the user must commit themselves
- [ ] HANDOFF / NEXT out of date vs actual state
- [ ] Program task ledger (`progress.md`) not ticked for completed deliverables
- [ ] Session notes missing under `.work.cto/sessions/<program>/` for a session that ran
- [ ] Open unknowns blocking the next step (owner + how to resolve)
- [ ] Owner actions (learner homework, stakeholder conversations, readings)
- [ ] Temp files under `tmp/` / `.tmp/` created this session

### C4 — Commit message (always)

**Always** produce the commit message block in the close report — even when the tree is clean (`none - working tree clean`).

Format and ref-prefix rules: [Commit message rules](#commit-message-rules-summary). One message if changes are cohesive; suggest a **split** with multiple message blocks if not (the session commit itself stays a single in-scope commit).

### C4b — Git actions (modifiers only)

| Modifier | Action |
|----------|--------|
| *(none)* | Message only. User runs `git commit` themselves. |
| `commit` | Only if C1 secrets **pass**. After C5/C6 (close) **or** after M4 (standalone commit): stage per **default scope** → `git commit` (HEREDOC) → verify tree → record SHA. |
| `commit scoped` | After C5/C6: stage only `{HANDOFF}`, `{NEXT}`, and paths explicitly tied to this session in the close report. |
| `commit push` | After successful commit: `git push` (current branch). Never force-push. |
| `push` (bare) | No commit — push existing commits only; warn if the in-scope tree is dirty. |

**Hard rule — agent MUST execute git:** Typing `@cto-session close commit` or `@cto-session commit` does not commit by itself. The agent **MUST** run the shell commands below. The checklist git item is **fail** if the tree still has unstaged safe in-scope changes and no commit SHA was produced.

**Default commit scope** (when modifier is `commit` or `commit push`, not `scoped`):

1. Run `git status --porcelain` (from C1).
2. Stage list = every path **in `{SCOPE}`** with status `M`, `A`, `D`, `R`, `C`, or `??` (untracked — includes **new untracked files/dirs**) **except** paths matching:
   - Secrets scan patterns (C1) — never add; flag as follow-up
   - `tmp/`, `.tmp/` — never add unless the user explicitly named them for commit
3. Stage the scope:
   ```bash
   # self-hosted source (repo-wide):
   git add -A
   # thin/fat target (.work.cto/ only):
   git add -A -- .work.cto
   ```
   In targets the explicit pathspec guarantees nothing outside `.work.cto/` is staged. In the self-hosted source `git add -A` intentionally covers **all** modified/added/deleted files repo-wide — framework dirs, docs, scripts, and `.work.cto/` together. (`-A` picks up modifications, deletions, and new untracked files; empty dirs are never tracked by git.)
4. **Do not** default to HANDOFF + NEXT only — that is **`commit scoped`**, not default `commit`.
5. If the only remaining dirty paths are excluded (secrets / tmp) or out of scope (targets), commit what was staged and report exclusions.
6. If `git diff --cached --quiet` reports no staged changes → report `nothing to commit in scope` and stop — never create an empty commit.

**Commit command shape:**

```bash
git add -A                 # or: git add -A -- .work.cto  (target mode)
git commit -m "$(cat <<'EOF'
<exact message from C4>
EOF
)"
git status -sb
git log -1 --oneline
```

**Post-commit verification (mandatory):**

| Check | pass when |
|-------|-----------|
| Commit created | `git log -1` shows new SHA |
| Staging complete | No remaining `M`/`D`/`??` in safe in-scope paths from step 2, **or** report lists each leftover path and why (secrets, tmp, out of scope, intentional WIP) |

**On commit failure:** report hook output; do not claim the git step complete; HANDOFF/NEXT updates still stand if already written.

**Push:** `git push` the current branch to its upstream. No upstream → report it and give the exact `git push -u origin <branch>` command for the user — do not run it (that modifies git config). Never force-push.

**Never:** `git commit --no-verify`, `git push --force`, amend, or co-author trailers unless the user explicitly requests in the same message (amend/force-push: not even then without restating the risk).

### C5 — Update HANDOFF (mandatory on close)

Rewrite the top sections (keep history; never delete past Latest-action content without carrying it forward):

1. `**Last updated:**` → today.
2. `**Session state:**` → `idle`.
3. `## Latest action` — Date, Request (the invocation), Executed (numbered list of what actually happened, with artifact paths), Blockers, Next recommended → `see .work.cto/plans/NEXT.md`.
4. `## Active focus` — refresh program / module / open consultancy.
5. `## Carry-forward` — refresh: unresolved items, stale-unknown notes, next-session reminders.

An `idle` HANDOFF must not say "in progress". Do not drop historical context the next session still needs.

### C6 — Update NEXT.md (mandatory on close)

- `**Updated:**` → today.
- Move completed items out of the queue (note done + date where the file tracks it).
- Set **one** clear `## Immediate next action` (a concrete skill invoke).
- Refresh `## Queue` and `## Blocked` (owner + how to unblock).

### C7 — Close report (mandatory output)

```markdown
## Session closed — <Project Name>

**Date:** <ISO date> · **Branch:** <branch> · **Repo mode:** <mode> (scope: repo-wide | .work.cto/)

### Completion checklist
| # | Check | Result | Evidence |
|---|-------|--------|----------|
| 1 | Git audit | pass/fail/skip | clean / N files changed / not a repo |
| 2 | Secrets safe | pass/fail | |
| 3 | Verification honest | pass/fail | |
| 4 | Follow-ups listed | pass | |
| 5 | Commit message shown | pass | always |
| 6 | Git commit (if requested) | pass/fail/skip | modifier `commit`; SHA + `git status` evidence |
| 6b | In-scope tree staged (default `commit`) | pass/fail/skip | not `scoped`; leftover safe in-scope paths listed |
| 7 | Git push (if requested) | pass/fail/skip | modifier `push` |
| 8 | HANDOFF updated | pass/fail | Session state: idle |
| 9 | NEXT updated | pass/fail | |

### Commit message
**Status:** draft | used
**Message:** (plain text below — always present)

    docs: cto session 2026-08-14

    Optional body — why, not what.

**Git:** no commit (default) | committed \<sha\> | push \<remote/branch\> result

### Follow-ups before next session
<ordered list>

### Next session should
<one line from NEXT.md>
```

---

## Critical interactions

| When | Ask / do |
|------|----------|
| **Start** | Prior HANDOFF says `idle` → treat as new session; do not assume prior chat memory |
| **Start** | Missing HANDOFF → offer `@cto-bootstrap init` (training) or minimal HANDOFF (framework-dev) |
| **Start** | Dirty tree at start → note in report; ask if continuing WIP |
| **Start** | HANDOFF already `active`, new `start -` goal differs | Update Latest action with new goal + date |
| **Start** | PROFILE has unfilled `REPLACE:` tokens | Note only — never auto-propose `@cto-bootstrap init` unless the stated goal is setting up training |
| **Close** | Large uncommitted diff → suggest commit split |
| **Close** | User says "close without updating HANDOFF" → only allowed if they confirm; mark checklist item `skip` with reason |
| **Close** | Protected files changed → flag for explicit owner review |
| **Close** | `close commit` / `close commit push` → run C4b in shell after HANDOFF/NEXT; stage the **repo-mode scope** |
| **Close** | User expected commit but in-scope tree still dirty → **fail** item 6/6b |
| **Commit** | `@cto-session commit` → run Commit protocol; **do not** update HANDOFF or NEXT |
| **Push** | Bare `push`, in-scope tree dirty → warn changes are excluded; recommend `commit push` |

---

## Anti-patterns

- Claiming "context loaded" without reading HANDOFF and NEXT
- Closing a session without updating HANDOFF and NEXT
- Committing on plain `close` (without the `commit` modifier)
- **`close commit` with only HANDOFF/NEXT staged** while other safe in-scope paths remain dirty
- **Staging outside `.work.cto/` in a target repo** — target session commits are `.work.cto/`-scoped
- **Committing only `.work.cto/` in the self-hosted source** while other safe repo files remain dirty — source-mode commits are repo-wide
- **Reporting close commit done without running `git commit`** or without a new SHA
- Omitting the commit message block from the close report
- Putting secrets or PII in HANDOFF
- Marking a checklist `pass` without evidence
- Continuing close after a secrets scan **fail**
- Running HANDOFF/NEXT updates on standalone `commit` / `commit push`
- Creating an empty commit when nothing in scope changed
- Routing a framework-dev session into `@cto-bootstrap init` / `@cto-assess run` unprompted
- Adding `Co-authored-by:` trailers or using `git commit --trailer`

---

## Project layout (convention)

**`{WORK_ROOT}` = `.work.cto/`** at the repo root (thin-client, fat-client, or self-hosted — the learner-memory path and the write scope are always the same). Commit scope is repo-mode dependent: repo-wide in the self-hosted source, `.work.cto/` in targets.

```
.work.cto/                      ← {WORK_ROOT}
  context/HANDOFF.md            ← cto-session ({HANDOFF})
  context/PROFILE.md            ← cto-bootstrap / cto-assess ({PROFILE})
  plans/NEXT.md                 ← cto-session ({NEXT})
  plans/UNKNOWNS.md             ← cto-session + all skills ({UNKNOWNS})
  programs/<slug>/              ← installed programs + task ledgers
  sessions/<slug>/              ← per-program session notes
skills/                         ← framework (read-only for sessions in targets; committable in source mode)
```

Targets without `.work.cto/context/HANDOFF.md`: run `@cto-bootstrap init` (training intent) or create a minimal HANDOFF (framework-dev).
