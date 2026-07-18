---
name: deploy-files
description: >-
  Fat-client deploy: vendor full CTO Professor OS into target as .ai.cto/,
  then scaffold .training.cto/. Use when offline/local skills are required.
---

# deploy-files

**Shell:** `bash <source>/scripts/deploy-files.sh <target-path> [--force]`

## Protocol

1. Confirm target path.
2. Run deploy-files script (rsync into `.ai.cto/`).
3. Ensure `.training.cto/` scaffolded; `.cursorrules` created only if missing (leave `TRAINER_CTO_SOURCE=REPLACE_BASICSOURCE` for fat-client).
4. Tell user to fill REPLACE tokens and run `@session-cto start`.
