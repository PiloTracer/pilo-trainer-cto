# Deploy to a project

**Target directory must already exist** (`mkdir -p /abs/path/to/target && git -C /abs/path/to/target init -q` for a brand-new repo) — deploy scripts scaffold *into* an existing directory; neither creates the repo itself. Run deploy from the **source** repo/chat, not from inside the target — only the source session inherently knows its own path.

## Thin-client (preferred)

```bash
bash scripts/deploy-basic.sh /abs/path/to/target
# or from another machine after clone:
bash /path/to/pilo-trainer-cto/scripts/deploy-basic.sh /abs/path/to/target
```

From source chat: `@deploy-basic - /abs/path/to/target`

Creates: `.cursorrules` (`TRAINER_CTO_SOURCE=...`) + `.training.cto/`

## Fat-client

```bash
bash scripts/deploy-files.sh /abs/path/to/target
```

Creates: `.ai.cto/` + `.training.cto/`

## Then (inside the target project chat)

```text
@session-cto start
@cto-bootstrap init
@cto-assess run
```

`@cto-bootstrap init` here only tops up `.training.cto/` and fills PROFILE — the thin-client pointer was already wired by `@deploy-basic` above. Running `@cto-bootstrap init` standalone in a target that has never been deployed to (no `.cursorrules` yet) needs an explicit source: `@cto-bootstrap init - /path/to/pilo-trainer-cto`.

## Status / update

```bash
bash scripts/deploy-basic.sh --status /abs/path/to/target
bash scripts/deploy-basic.sh /abs/path/to/target --update
```
