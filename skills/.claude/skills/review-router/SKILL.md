---
name: review-router
description: >-
  Routes code reviews to domain skills by file type. Supports full-project and PR/diff modes.
  Use when reviewing a project, PR, or multi-domain change set.
disable-model-invocation: true
---

# Review Router

## Role

Review orchestrator. Detect scope mode, map files to domain skills, run applicable reviews, merge into single deduplicated report.

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

### Step 3: Route to skills

| Glob / path pattern | Skill |
|---------------------|-------|
| `**/*.tf`, `**/*.tfvars` | review-terraform |
| `**/Dockerfile*`, `**/docker-compose*.yml` | review-docker |
| `.github/workflows/**` | review-actions |
| `**/*.go` | review-go |
| `**/*.{py,pyi}` | review-python |
| `**/*.{ts,tsx}` | review-typescript (+ review-react if JSX) |
| `**/*.{sh,bash}` | review-bash |
| `**/Chart.yaml`, `**/templates/**` | review-helm |
| `**/k8s/**`, `**/manifests/**`, `**/*.{yaml,yml}` with `kind:` | review-kubernetes |
| `**/migrations/**`, `**/*.sql` | review-database |
| `**/openapi*`, `**/swagger*`, `**/routes.*` | review-api |
| `**/SKILL.md` | review-skills |
| Any code files | review-security (always) |

### Step 4: Execute reviews

- Load and apply each matched domain skill
- Run applicable skills in parallel (Task subagents) when available

### Step 5: Merge report

- Deduplicate Critical findings across skills
- Use [_shared/review-output-format.md](../_shared/review-output-format.md)
- Prefix pre-existing issues with `(pre-existing)` in Mode B
- Analysis only — do not edit files

## Output

Single merged report with Executive Summary, Critical, Medium, Low sections. Note which skills were applied at the top.
