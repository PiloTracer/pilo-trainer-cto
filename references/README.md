# References — framework-owned source library

Verified, publicly available material the professor can assign without research overhead.

**Why this exists:** before this library, every learner started with an empty
`.training.cto/sources/` table and the agent had to invent a reading list on the spot —
the exact condition `standards/citation.md` warns about. These entries have been checked
against a live public page. Anything unverified is labelled, not quietly dropped.

| File | Contents |
|------|----------|
| [`core-library.md`](core-library.md) | Annotated sources by competency area, with verification status |

## How skills use this

| Skill | Use |
|-------|-----|
| `@cto-program-standard` / `@cto-program-custom` | Seed `.training.cto/sources/` at install from the areas the program covers |
| `@cto-sources curate` | Draw from here first; search the web only for gaps |
| `@cto-mentor` / `@cto-drill` | Cite pre-read material without re-verifying |
| `@cto-update` | Add *new* material here only after verifying a live page |

## Rules

- An entry needs title + (author or URL), per `standards/citation.md`.
- **Verified** means someone loaded the page or holds the book. Everything else is **Unverified** and says so.
- Chapter and page numbers are asserted only when confirmed — "the leverage chapters" beats a wrong chapter number.
- This is framework-owned and read-only for learners. Learner curation stays in `.training.cto/sources/`.
- Entries carry a `Checked` date. Anything older than a year should be re-checked by `@cto-update` before it is assigned again.
