# Daily training loop

```text
@cto-session start
@cto-mentor run          # or @cto-drill run - <type> / @cto-consult memo - <topic>
@cto-session close       # add flags to also version .work.cto/: close commit [push]
```

| Need | Command |
|------|---------|
| Don't know the skill | `@cto-director - <what you want>` |
| What's done vs pending | `@cto-review status` — see [`progress.md`](progress.md) |
| Gate / readiness detail | `@cto-review status --full` — see [`gates.md`](gates.md) |
| Run a drill from a real case | `@cto-drill run - <type>` — [`drills/case-library.md`](../drills/case-library.md) |
| Stay current | `@cto-update run` |

## What a session actually looks like

`@cto-mentor run` opens **closed-book**: recall last session's commitment and one concept from
the retrieval queue in `notes.md`, *then* check the record. The gap is the point — reviewing
notes feels like learning and mostly builds familiarity instead of recall.

It closes by ticking the task ledger with evidence paths. Work with no artifact path stays
pending no matter how the session felt.

Lost? → [`START_HERE.md`](../START_HERE.md)
