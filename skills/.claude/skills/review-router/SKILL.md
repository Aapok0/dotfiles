---
name: review-router
description: >-
  Routes code reviews to domain skills by file type. Supports full-project and PR/diff modes.
  Use when reviewing a project, PR, or multi-domain change set.
disable-model-invocation: true
---

# Review Router

## Role

Principal Code Review Orchestrator and Multi-Domain Audit Lead. Detect scope mode, map files to domain skills, run applicable reviews, merge into single deduplicated report.

## Workflow

Follow [_shared/review-workflow.md](../_shared/review-workflow.md) for scope mode selection.

### Step 1: Determine scope mode

- **Mode B (PR/diff):** user mentions PR, changes, diff, before merge
- **Mode A (full project):** default — scan entire project or user-specified subdirectory

### Step 2: Collect files

**Mode B:**
```bash
git diff --name-only $(git merge-base HEAD main) HEAD
# include staged/unstaged if relevant
```

**Mode A:**
- Glob project tree using map below
- Prioritize entry points, configs, and domain paths

### Step 3: Extensionless script detection (shebang)

Route by shebang when path has no recognized extension:

**review-bash** when ANY of:
- Path matches `**/*.{sh,bash}`
- Path matches `scripts/**`, or basename is `install`, `setup`, or `run`
- File is extensionless AND first line matches `^#!.*\b(bash|sh)\b`

**review-python** when ANY of:
- Path matches `**/*.{py,pyi}`
- File is extensionless AND first line matches `^#!.*\bpython`

When ambiguous, read first 1–2 lines before skipping.

### Step 4: Route to skills

| Glob / path pattern | Skill |
|---------------------|-------|
| `**/*.tf`, `**/*.tfvars` | review-terraform |
| `**/Dockerfile*`, `**/docker-compose*.yml` | review-docker |
| `.github/workflows/**` | review-actions |
| `**/*.go` | review-go |
| `**/*.php` | review-php |
| `**/*.{html,htm}` | review-html |
| `**/*.{css,scss,sass,less}` | review-css |
| `**/*.{js,mjs,cjs,jsx}` | review-javascript (+ review-react if JSX) |
| `**/*.{ts,tsx}` | review-typescript (+ review-react if JSX) |
| `**/Chart.yaml`, `**/templates/**` | review-helm |
| `**/k8s/**`, `**/manifests/**`, `**/kube/**` | review-kubernetes |
| `**/*.{yaml,yml}` | review-kubernetes only if file contains `apiVersion:` and `kind:` |
| `**/migrations/**`, `**/*.sql` | review-database |
| `**/openapi*`, `**/swagger*`, `**/routes.*` | review-api |
| `tests/**`, `**/*_test.go`, `**/test_*.py` | review-tests |
| `**/*.md`, `docs/**`, `instructions/**` | review-docs |
| `**/SKILL.md` | review-skills |
| Any code files | review-security (always) |

Extensionless bash/python routes from Step 3 apply in addition to this table.

### Step 5: Execute reviews

- Load and apply each matched domain skill
- Run applicable skills in parallel (Task subagents) when available

### Step 6: Merge report

- Deduplicate Critical findings across skills
- Use [_shared/review-output-format.md](../_shared/review-output-format.md)
- Prefix pre-existing issues with `(pre-existing)` in Mode B
- Analysis only — do not edit files

## Output

Single merged report with Executive Summary, Critical, Medium, Low sections. Note which skills were applied at the top.

## Example finding

Input: linux-setup `scripts/setup-arch` (extensionless bash) not matched by `*.sh` glob

```
### Critical Fixes (High Priority)
- `review-router` scope gap — extensionless `scripts/setup-arch` skipped; route via shebang `#!/usr/bin/env bash`
```
