---
name: cto-sources
description: >-
  Curate and cite publicly available books, articles, talks, and docs into
  .work.cto/sources/. Never invent citations.
---

# cto-sources

**Requires:** scaffold (`.work.cto/` exists). No waiver — run `@cto-bootstrap init` first.

On failure emit the canonical BLOCKED report from `skills/SKILL_DEPENDENCIES.md`.

- **Operator handoff:** every response that ends a turn follows the [Operator handoff contract](../SKILL_DEPENDENCIES.md#operator-handoff-contract) — terse output; approvals under `**Needs your approval:**` citing `path:L<n>`; questions numbered under `**Needs your answer:**`; exactly one `**Next step:**` command; one line when nothing is needed (Form A). Decisions and questions never mixed; empty sections omitted.
- **Document clarity:** every generated document follows the [Document clarity contract](../SKILL_DEPENDENCIES.md#document-clarity-contract) — Status + Needs header, separate Decisions/Open questions lists, one `## Next action`, no placeholder scaffolding left behind.

## Parse

| Invoke | Action |
|--------|--------|
| `@cto-sources add - <title or URL>` | Add one source |
| `@cto-sources curate - <topic or program>` | Build a shortlist |
| `@cto-sources list` | Show backlog |
| `@cto-sources status` | Coverage vs active program |

## Start from the framework library

`references/core-library.md` holds verified sources by competency area. Draw from it first and
search the web only for genuine gaps — its *Gaps worth filling* section names the areas where
nothing is verified yet.

New material earns a place in the learner's `sources/` only after the same verification bar:
a live public page, or an explicit **Unverified** label.

## Rules (binding — see standards/citation.md)

1. Every entry needs **title** + (**author** or **URL**).
2. Prefer primary/public sources. If unsure a work exists, mark **Unverified** or omit.
3. Add Why (1 line) tied to learner goal.
4. Update the `.work.cto/sources/README.md` table (canonical). Use `sources/<topic>.md` only for long annotated lists, and keep a README row pointing to it.
5. `Status` is one of `assigned` · `reading` · `read` · `dropped`.

## Reading is a task

A source assigned by the active program also has a `reading` row in that program's
`progress.md` task ledger. Keep the two in step: moving a source to `read` means ticking
its ledger row `done` with the notes path as Evidence. A book with no filed notes is not
read — leave it `reading`.

## curate

Produce 5–12 items max, mixed formats (book / article / talk). Link to active program modules when possible.
