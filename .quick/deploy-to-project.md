# Deploy to a project

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

## Then

```text
@session-cto start
@cto-bootstrap init
@cto-assess run
```

## Status / update

```bash
bash scripts/deploy-basic.sh --status /abs/path/to/target
bash scripts/deploy-basic.sh /abs/path/to/target --update
```
