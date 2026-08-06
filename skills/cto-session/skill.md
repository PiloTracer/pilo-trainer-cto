---
name: cto-session
description: >-
  Session bookends for CTO training. Modes: start, status, close; optional
  git flags commit / push. Loads/writes HANDOFF and NEXT under .work.cto/.
  Every action is scoped to .work.cto/ in the target repo/dir.
---

# cto-session

## Parse

Any combination of `start`, `status`, `close`, `commit`, `push` — order-insensitive.

| Invoke | Action |
|--------|--------|
| `@cto-session start` | Load context; set session active |
| `@cto-session status` | Read-only orientation |
| `@cto-session close` | Refresh HANDOFF + NEXT; summarize |
| `@cto-session close commit` | close, then git commit of `.work.cto/` changes (incl. untracked) |
| `@cto-session close push` | close, then git push of current branch |
| `@cto-session close commit push` | close, then commit, then push |
| `@cto-session commit` | git commit of `.work.cto/` changes only |
| `@cto-session push` | git push of current branch |
| `@cto-session commit push` | commit `.work.cto/` changes, then push |

**Mode resolution (order-independent):** if `start` is present → start; else if `status`
present → status; else if `close` present → close; else → git-only (`commit` / `push`).
`commit` and `push` are git flags: with `close` they run after the close bookkeeping;
without `close` (or without `start`/`status`) they run standalone. `commit` and `push`
together always run commit first, then push. On `start`/`status`, `commit`/`push` flags
are ignored — say so.

Git is strictly opt-in: `commit`/`push` run only when the user typed the flag in this
invocation (matching the `.cursorrules` git rule — the flag *is* the explicit request).

## start

0. **Classify session type first:** framework-dev (the request is about editing/improving `skills/`, `curricula/`, `standards/`, `templates/`, `scripts/`, or `.cursorrules` themselves) vs training (a learner using the pipeline). If framework-dev, stop here — there is no learner session to open; say so and hand off to the framework task instead of steps 1-4.
1. Read `{HANDOFF}`, `{NEXT}`, `{PROFILE}`, `{UNKNOWNS}`, active program if any.
2. Summarize: readiness state, active program/module, top next action, blockers.
3. Update HANDOFF session state → `active`, date today.
4. Propose one concrete action for this session (mentor / drill / consult / assess). **Never default to `@cto-bootstrap init` solely because `{PROFILE}` has unfilled `REPLACE:` tokens** — only propose it if the user's stated goal for this session is actually starting/setting up a training project.

## status

Read-only version of the summary. No writes.

## close

1. Ask (or infer from chat) what was accomplished; write Latest action block into HANDOFF.
2. Update NEXT with the single best next skill invoke.
3. Set session state → `idle`.
4. If `commit` / `push` flags are present, run them now, in order (see Git actions below).

## Git actions

Both actions are **scoped to `.work.cto/`** — the working directory of this framework in
the target repo. Nothing outside `.work.cto/` is ever staged or committed by this skill.

### commit

1. If the target is not a git repo, report `commit skipped: <target> is not a git repository` and stop (no partial work).
2. `git add -A -- .work.cto` — stages modified, deleted, **and new untracked files/dirs** under `.work.cto/` (empty dirs are never tracked by git; only files inside them are added). This pathspec guarantees nothing outside `.work.cto/` is staged.
3. If `git diff --cached --quiet` reports no staged changes, report `nothing to commit under .work.cto/` and stop — never create an empty commit.
4. Commit message (subject ≤72 chars, `type: description` per `.cursorrules`):
   - Default: `docs: cto session <YYYY-MM-DD>` (e.g. `docs: cto session 2026-08-06`)
   - With a closing note supplied in the invocation: `docs: cto session <YYYY-MM-DD>: <note>` (truncate to 72 chars)
5. `git commit -m "<message>"` — plain commit, no amend, no hooks bypass, no co-author trailers.
6. Report the commit: `git log -1 --oneline` + `git status -sb`; no "committed" claim without a SHA.

### push

1. If the target is not a git repo, report `push skipped: <target> is not a git repository` and stop.
2. `git push` the current branch to its upstream. Never force-push.
3. If there is no upstream, report it and give the exact command to set one (`git push -u origin <branch>`) — do not run it (that would modify git config).
4. If `push` runs without `commit` and `git status --porcelain` shows uncommitted changes under `.work.cto/`, state plainly that those changes are **not** included in the push and recommend `@cto-session commit push`.

## Rules

- **Write scope (mandatory):** `start` / `status` / `close` write only under `.work.cto/` (HANDOFF, NEXT, session files). Never create, edit, stage, move, or delete files outside `.work.cto/` as part of a cto-session action — `.work.cto/` is the full domain of this framework in the target repo.
- **Git scope (mandatory):** `git add` uses the explicit pathspec `-- .work.cto` only. Never `git add .` / `git add -A` without a pathspec, never stage, amend, rebase, or force-push anything outside a `.work.cto/`-scoped commit.
- Files outside `.work.cto/` may only be *referenced* — read, or mentioned in HANDOFF/NEXT — when they are already part of the changes in the current session context (e.g. code the learner worked on). Even then, cto-session never modifies them.
- Never claim progress without referencing an artifact path under `.work.cto/`.
