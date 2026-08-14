# Changelog

## Unreleased

**`cto-session` aligned with Agent OS `session-control`.** The session skill now speaks the
same verb set and enforces the same evidence discipline as its `.ai` sibling, adapted to the
`.work.cto/` learner-memory scope.

- **New verbs and modifiers.** `context` (read-only full context load with uncommitted-aware,
  secrets-flagged snapshot — writes nothing), `push` standalone (warns when `.work.cto/` is
  dirty), `close commit scoped` (bookend files only), and aliases `begin`/`open`/`end`/`handoff`.
  Parsing stays order-insensitive; `commit`/`push` on `start`/`status`/`context` are ignored with
  a note.
- **Detailed protocols in `skills/cto-session/reference.md`.** Start (S1–S6), status, context
  (X1–X3), commit (M1–M6), and close (C1–C7) protocols mirroring `session-control`: mandatory
  baseline reads, working-tree audit with secrets scan (halts the run on match), verification
  gate (framework changes require `framework-verify.sh`), follow-ups detection, mandatory
  completion checklists with evidence, and a commit message block in every close/commit report.
- **Git contract kept, hardened, and repo-mode aware.** Commit scope follows the repo the skill
  runs in: **repo-wide** (`git add -A` — every safe modified/added/untracked file) in the
  self-hosted framework source, and `.work.cto/`-only (`git add -A -- .work.cto`) in deployed
  thin/fat targets — never HANDOFF-only, never the full target repo tree. Empty commits are
  skipped; push reports a missing upstream instead of setting one; optional `REF-123:` prefix
  auto-detected from HANDOFF goal, branch, or last commit — otherwise the `docs: cto session
  <date>` default. Git remains strictly opt-in.
- **Session-type classification.** Framework-dev sessions bookend normally but skip
  PROFILE/program reads and never route into the learner pipeline unprompted.

**Deploy verification + flag equivalence.** Any deploy now proves the target's wiring instead of
assuming it, and deploy modes/flags parse identically with or without the `--` prefix.

- **New `scripts/verify-target.sh`** — canonical audit of a deploy target's `.cursorrules`:
  mode detection (thin / fat / self-hosted), `TRAINER_CTO_SOURCE` reachable + matching the current
  source location (stale-pointer warning after a source move/rename), remaining `REPLACE:` tokens
  classified (operator-filled vs auto-discovered `*_PATH`), frameworks-registry sister discovery
  (`.ai`, `.ai.ui`, `.ai.biz`, `.ai.soc` — filled path cell wins, otherwise sibling auto-discovery),
  `.work.cto/` skeleton, and fat-client-leak detection in thin targets. FAIL items exit 1.
- **Automatic verify at deploy end.** `deploy-basic.sh` and `deploy-files.sh` close every
  deploy/update with `verify-target.sh`; a FAIL aborts with "DEPLOY INCOMPLETE" (e.g. an existing
  non-CTO `.cursorrules` that still needs a rules-aware merge).
- **Flag equivalence everywhere.** `update` ≡ `--update`, `force` ≡ `--force`, `status` ≡ `--status`,
  `verify` ≡ `--verify`, `--clone` ≡ `clone`, `--archive` ≡ `archive` across all three deploy scripts.
- **New `verify` canonical verb** (`@cto-deploy-basic verify - /path`,
  `@cto-deploy-files verify - /path`), documented in the deploy skills, `skills/README.md`,
  `PROCESS_ROUTER.md`, and `.quick/`.
- **`framework-verify.sh`** gained smokes: verify passes on fresh thin+fat deploys, bare/`--` forms
  are interchangeable, an unreachable pointer fails verify, and `update` re-syncs it back to green.

## v0.2.0 — 2026-08-06

**Naming standardization + working-directory scope.** All skills now carry the `cto-` domain prefix
(the sibling `mlt-*` / `flutter-*` frameworks already do); the learner-memory root is renamed to
`.work.cto/` to match the `.work.flutter` convention; the session skill owns a tighter, explicit
git contract scoped to that directory.

- **Skill renames (folders, `name:` frontmatter, `@` handles, and every reference):**
  `deploy-basic` → `cto-deploy-basic`, `deploy-files` → `cto-deploy-files`,
  `deploy-repo` → `cto-deploy-repo`, `session-cto` → `cto-session`. Updated across `.cursorrules`,
  `skills/README.md`, `SKILL_DEPENDENCIES.md`, `README.md`, `START_HERE.md`, `PROCESS_ROUTER.md`,
  `CONTRIBUTING.md`, `.quick/`, scripts, templates, curricula, and standards. Script filenames
  (`scripts/deploy-*.sh`) are unchanged — they are shell files, not skill ids.
- **Working root renamed `.training.cto/` → `.work.cto/`** everywhere (skills, scripts, templates,
  `.gitignore`, docs, curricula, standards); placeholder `{TRAINING_ROOT}` → `{WORK_ROOT}`.
  *Upgrade note:* existing deployments must rename their learner-memory dir once
  (`mv .training.cto .work.cto`) — the session skill and deploy scripts now look for `.work.cto/`.
- **`cto-session` scope + git contract.** Every action is limited to `.work.cto/` in the target
  repo/dir. The skill parses any combination of `commit` / `close` / `push` order-independently;
  `commit` stages via the explicit pathspec `git add -A -- .work.cto` (new untracked files/dirs
  included), uses a `docs: cto session <date>` message, skips empty commits, and reports SHA +
  status; `push` pushes the current branch and reports a missing upstream instead of setting one.
  Git stays strictly opt-in — flags in the invocation are the explicit request.

## v0.0.4 — 2026-07-30

**Contract completion pass.** v0.0.3 added capability; this closes the gaps that audit exposed,
including several carried over unfixed from the original review.

- **Gate contracts are now uniform and enforced.** Every gated skill declares `Requires:`, emits the canonical BLOCKED report, and documents its `-y` waiver. `@cto-director` checks each step's gate before proposing a chain instead of routing past it. Verify parses the gate table and fails on any skill that drifts.
- **`mentoring-loop` reconciled.** Three files disagreed on what certifies it; the strict reading wins — a prep file alone is not a session, and an intention recorded in NEXT is not evidence.
- **`decision-case` drill type defined.** Two curricula and the case library referenced a type the drill skill never listed. Verify now fails on any drill type a curriculum uses but `@cto-drill` does not define.
- **`notes.md.template`** — the retrieval queue introduced in v0.0.3 was read by the mentoring protocol but seeded by nothing; program install created an empty file. Both install skills now seed it.
- **Artifact shapes** for `@cto-update` reports, `@cto-review certify`, and `@cto-curriculum design` — each previously named an output path with no section contract.
- **`deploy-files` and `deploy-repo`** grew parse tables, failure handling, and output contracts; both were stubs whose scripts had outrun their specs, and `deploy-files copy` was a verb the router told users to type but the skill never documented.
- **Case 11, tech debt with a price on it** — closes the last curriculum drill reference with no case behind it.
- Cross-reference and catalog sync across `.quick/`, `START_HERE.md`, `CONTRIBUTING.md`, `skills/README.md`, and `PROCESS_ROUTER.md`: the eighth curriculum, `references/` and `drills/`, the `update` verb, `deploy-repo`, and the new `@cto-review` modes.

Every new guard was confirmed to fail when its invariant is broken. Verify: **PASS**.

## v0.0.3 — 2026-07-30

**Ten improvements to training quality.** Every source added here was checked against a live
public page; anything unconfirmed is labelled Unverified rather than dropped or asserted.

1. **`references/` source library** — verified sources by competency area, ending the cold start where every learner began with an empty reading list and the agent improvised one
2. **`standards/decision-record.md`** — Nygard's five sections plus the MADR additions, requiring ≥3 options with a genuine defer, decision drivers, and an observable reversal trigger. Two-option records are now a named structural failure
3. **`drills/case-library.md`** — ten runnable cases built on real public incidents and decisions, each with a pre-read boundary and time-box, replacing scenario improvisation
4. **Retrieval-based session openings** — sessions now begin closed-book, with a spaced retrieval queue, grounded in the spacing and retrieval-practice literature rather than intuition
5. **`standards/metrics.md`** — DORA four keys and SPACE, with the corrections a professor should make on sight: the Elite tier disappeared in 2022, reliability was added as a fifth metric in 2021, and change fail rate resists compositing
6. **Pace detection in `@cto-review status`** — computes required against actual delivery rate, says plainly when a gate has become unreachable at the current budget, and ranks risk by external clock rather than by size of gap
7. **Anchored competency levels** — 1–5 now means something: scope of effect and whether the behaviour survives pressure. Self-report caps at 3; 3 → 4 needs a second context. Score movement is logged with its artifact
8. **`standards/anti-patterns.md`** — a catalogue of CTO failure modes with the tell and the challenge for each, so "correct the learner" has something concrete behind it
9. **`ai-engineering-leadership` curriculum** — built on DORA's 2025 amplifier finding: AI magnifies existing strengths and existing dysfunction alike
10. **Curricula rebuilt on verified frameworks** — Team Topologies, NIST CSF 2.0, DORA/SPACE, ADR practice. All eight catalog programs now satisfy `program-spec.md`, enforced in `framework-verify.sh`

Also: verify now fails on an orphaned standard, an unregistered curriculum, a curriculum missing
a SPEC section, or a fat-client deploy that drops a framework directory.

## v0.0.2 — 2026-07-30

**Task ledger — progress is now reportable.**

Programs tracked module status only, so `@cto-review status` had to re-derive "what's done"
by parsing session logs and memos every time. The result was long and unreliable.

- New `templates/training/programs/progress.md.template` — per-program task ledger with one
  row per deliverable, `Done/Total` for counted exit-check items, and a mandatory evidence
  path for anything marked done
- `@cto-program-standard` / `@cto-program-custom` seed the ledger and `sources/` at install,
  so readings and drills are trackable from day one
- `@cto-mentor run` and `@cto-drill` tick the ledger with evidence paths; new mid-session
  assignments are added in the same pass
- `@cto-review status` rewritten to a fixed short shape (Completed / Pending / Deferred /
  Next / Assessment) read solely from the ledger; the old wide snapshot moved behind
  `--full`; `@cto-review tasks` added as an alias
- `@cto-mentor run` now specifies its session-log filename (previously only `prepare` did)
- `@cto-sources` gains a status vocabulary kept in step with the ledger's reading rows
- `@cto-program-standard` install now checks the copied SPEC against `standards/program-spec.md`
- `framework-verify.sh` guards the ledger contract end to end

**Earlier, unreleased (2026-07-18):** thin-client bootstrap wiring and framework-dev routing
fixes; `.cursorrules` hardened with anti-destructive safety rules.

## v0.0.1 — 2026-07-17

Initial public release of **Pilo Trainer CTO** (CTO Professor OS).

- Thin-client `@deploy-basic` and fat-client `@deploy-files` / `@deploy-repo`
- Learner memory under `.training.cto/`
- Gated pipeline: profile-ready → assessed → program-active → mentoring-loop / consultancy-ready
- 17 skills: deploy trio, bootstrap, session, director, router, assess, program-standard/custom, curriculum, mentor, consult, drill, sources, update, review
- Seven standard curricula under `curricula/`
- Standards for mentoring, citation, assessment, and program SPECs
- Quick-reference sheets under `.quick/`
