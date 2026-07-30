# Changelog

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
