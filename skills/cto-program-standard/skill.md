---
name: cto-program-standard
description: >-
  List and install standard curricula from the framework catalog into
  .work.cto/programs/. Never mutate curricula/ in the framework for learner content.
---

# cto-program-standard

**Requires:** profile-ready (assessed recommended).
On failure emit the canonical BLOCKED report from `skills/SKILL_DEPENDENCIES.md`.

## Parse

| Invoke | Action |
|--------|--------|
| `@cto-program-standard list` | Show catalog |
| `@cto-program-standard install - <slug>` | Copy into programs/ |
| `@cto-program-standard status` | Active programs |

## Catalog slugs

| Slug | File |
|------|------|
| `cto-foundations` | `curricula/cto-foundations.md` |
| `engineering-leadership` | `curricula/engineering-leadership.md` |
| `delivery-systems` | `curricula/delivery-systems.md` |
| `product-stakeholder` | `curricula/product-stakeholder.md` |
| `governance-risk` | `curricula/governance-risk.md` |
| `strategy-scale` | `curricula/strategy-scale.md` |
| `ai-engineering-leadership` | `curricula/ai-engineering-leadership.md` |
| `continuous-edge` | `curricula/continuous-edge.md` |

Resolve curricula path via `$TRAINER_CTO_SOURCE/curricula/` (thin) or local / `.ai.cto/curricula/` (fat/self-hosted).

## install

1. Confirm slug exists.
2. Create `.work.cto/programs/<slug>/`.
3. Copy catalog → `PROGRAM.md` (adapt lightly to PROFILE: duration notes, company stage — do not gut outcomes). Verify the result carries every section required by `standards/program-spec.md` (binding); if the catalog file is missing one, fill it during the copy rather than installing a non-compliant SPEC.
4. Create `progress.md` from `templates/training/programs/progress.md.template` and seed the **task ledger** (see below). Create `notes.md` from `templates/training/programs/notes.md.template` — it carries the retrieval queue that `@cto-mentor` reads at every session opening, so an empty file breaks the retrieval protocol.
5. Set PROFILE active program; readiness → `program-active`.
6. Update NEXT → `@cto-mentor prepare` or `run`.
7. Seed `.work.cto/sources/README.md` from every `Sources:` line in the program (one row per work, `Status: assigned`), per `standards/citation.md`. Carry the verification status across from `references/core-library.md` rather than re-asserting it. Chain `@cto-sources curate` to enrich.

## Seeding the task ledger (binding)

The ledger is what `@cto-review status` reports. An unseeded ledger makes progress
unreportable, so this step is not optional.

Walk every module and emit one row per assigned deliverable:

| Source line in PROGRAM.md | Ledger row |
|---------------------------|------------|
| `Drill:` | one `drill` row per distinct drill |
| `Sources:` | one `reading` row per work listed |
| `Exit check:` counted item (e.g. "≥3 ADRs") | one `artifact` row with `Done/Total` = `0/3` |
| `Exit check:` boolean item | one row with `Done/Total` = `0/1` |

Set `Deliverables complete: 0 of <N>`. Modules whose premise is not yet satisfiable go in
the **Deferred** table with the unblocking condition — not in the pending list, where they
would read as learner slippage.

## Rules

**Never** edit framework `curricula/` for one learner. Always copy out.  
Waiver: `-y` proceeds without `profile-ready`; log the waiver in HANDOFF.
