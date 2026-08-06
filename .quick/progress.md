# Progress — what's done, what's pending

## Ask

```text
@cto-review status          # short: Completed / Pending / Deferred / Next / Assessment
@cto-review tasks           # same thing
@cto-review status --full   # adds readiness, competency, unknowns
```

## Where it comes from

One file: `.work.cto/programs/<slug>/progress.md` — the **task ledger**. Every assigned
deliverable is a row. Counted items ("≥3 ADRs") stay one row with `Done/Total`.

If status looks wrong, fix the ledger, not the report.

## The done rule

`done` requires an evidence path under `.work.cto/`. No path, not done — regardless of what
a session log says. A book with no filed notes is `reading`, not `read`.

## What updates it

| Event | Updates |
|-------|---------|
| Program install | Seeds every row from module drills, sources, and exit checks |
| `@cto-mentor run` | Ticks closed items; adds anything newly assigned |
| `@cto-drill` | Ticks the drill row, or bumps its count |
| `@cto-sources` | Keeps reading rows in step with source status |

## Reading the pace line

Status compares your actual rate against what the remaining window needs:

```text
required = (total - done) / weeks_remaining
actual   = done / weeks_elapsed
```

Behind means the report tells you the rate that now clears the gate, and whether it fits your
ratified weekly budget. If it does not fit, you get three options: raise the budget, cut scope,
or move the date. Deferred tasks never count as slippage.

## Common fixes

| Symptom | Fix |
|---------|-----|
| Status says the ledger is unseeded | Ask for a back-fill; do not let the agent narrate from prose |
| Work you did is not listed | It has no ledger row — add one, with the evidence path |
| Pending list is enormous | It should show the current module only; later modules collapse to one line each |
