# Deploy to a project

**Target directory must already exist** (`mkdir -p /abs/path/to/target && git -C /abs/path/to/target init -q` for a brand-new repo) — deploy scripts scaffold *into* an existing directory; neither creates the repo itself. Run deploy from the **source** repo/chat, not from inside the target — only the source session inherently knows its own path.

## Thin-client (preferred)

```bash
bash scripts/deploy-basic.sh /abs/path/to/target
# or from another machine after clone:
bash /path/to/pilo-trainer-cto/scripts/deploy-basic.sh /abs/path/to/target
```

From source chat: `@cto-deploy-basic - /abs/path/to/target`

Creates: `.cursorrules` (`TRAINER_CTO_SOURCE=...`) + `.work.cto/`

## Fat-client

```bash
bash scripts/deploy-files.sh /abs/path/to/target
```

Creates: `.ai.cto/` + `.work.cto/`

## Then (inside the target project chat)

```text
@cto-session start
@cto-bootstrap init
@cto-assess run
```

`@cto-bootstrap init` here only tops up `.work.cto/` and fills PROFILE — the thin-client pointer was already wired by `@cto-deploy-basic` above. Running `@cto-bootstrap init` standalone in a target that has never been deployed to (no `.cursorrules` yet) needs an explicit source: `@cto-bootstrap init - /path/to/pilo-trainer-cto`.

## Status / update / verify

Modes and flags work with or without the `--` prefix (`update` ≡ `--update`).

```bash
bash scripts/deploy-basic.sh status /abs/path/to/target
bash scripts/deploy-basic.sh /abs/path/to/target update
bash scripts/deploy-basic.sh verify /abs/path/to/target   # deep .cursorrules wiring audit
```

Every deploy/update ends with an automatic verify: pointer reachable and matching the
current source location, remaining `REPLACE:` tokens, sister frameworks (the six `.ai.<fw>`
slots — legacy + family naming — plus the Agent OS anchor `.ai` / `pilo.ai.logicbison`)
resolvable, `.work.cto/` skeleton present. FAIL = deploy incomplete.
