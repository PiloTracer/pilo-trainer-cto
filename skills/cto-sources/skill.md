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
4. Update `.training.cto/sources/README.md` table or `sources/<topic>.md`.

## curate

Produce 5–12 items max, mixed formats (book / article / talk). Link to active program modules when possible.
