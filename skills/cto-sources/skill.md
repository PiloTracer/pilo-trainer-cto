---
name: cto-sources
description: >-
  Curate and cite publicly available books, articles, talks, and docs into
  .training.cto/sources/. Never invent citations.
---

# cto-sources

## Parse

| Invoke | Action |
|--------|--------|
| `@cto-sources add - <title or URL>` | Add one source |
| `@cto-sources curate - <topic or program>` | Build a shortlist |
| `@cto-sources list` | Show backlog |
| `@cto-sources status` | Coverage vs active program |

## Rules (binding — see standards/citation.md)

1. Every entry needs **title** + (**author** or **URL**).
2. Prefer primary/public sources. If unsure a work exists, mark **Unverified** or omit.
3. Add Why (1 line) tied to learner goal.
4. Update the `.training.cto/sources/README.md` table (canonical). Use `sources/<topic>.md` only for long annotated lists, and keep a README row pointing to it.
5. `Status` is one of `assigned` · `reading` · `read` · `dropped`.

## Reading is a task

A source assigned by the active program also has a `reading` row in that program's
`progress.md` task ledger. Keep the two in step: moving a source to `read` means ticking
its ledger row `done` with the notes path as Evidence. A book with no filed notes is not
read — leave it `reading`.

## curate

Produce 5–12 items max, mixed formats (book / article / talk). Link to active program modules when possible.
