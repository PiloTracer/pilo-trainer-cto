# Changelog

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
