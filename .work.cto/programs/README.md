# Programs

Installed and custom programs live here as folders:

```text
programs/<slug>/
  PROGRAM.md      # SPEC (outcomes, modules, drills)
  progress.md     # module status + task ledger (every assigned deliverable)
  notes.md        # learner notes
```

`progress.md` is the single source of truth for "what is done / what is pending".
`@cto-review status` reads it and nothing else for the task list.

Install catalog: `@cto-program-standard install - <slug>`  
Custom: `@cto-program-custom - <request>`
