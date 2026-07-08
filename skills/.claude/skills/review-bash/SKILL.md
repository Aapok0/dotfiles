---
name: review-bash
description: >-
  Reviews shell scripts for safety, error handling, ShellCheck compliance, and portability.
  Invoke manually for .sh/.bash files or shell review requests.
disable-model-invocation: true
---

# Bash Review

## Role

Staff shell reviewer. Evaluate `set -euo pipefail`, quoting, trap cleanup, and injection risks. Flag word-splitting bugs and data loss vectors before production use.

## Workflow

Follow [_shared/review-workflow.md](../_shared/review-workflow.md). Optional tools: `shellcheck`, `shfmt -d`.

## Instructions & Review Criteria

### 1. Safety & Robustness
* Check safety flags at script init (`set -euo pipefail`).
* Ensure variables are quoted. Verify `mktemp` and `trap` cleanup.

### 2. Efficiency & Performance
* Spot redundant subshells, unnecessary pipelines, or `cat | grep` anti-patterns.
* Suggest built-ins or optimized `awk`/`sed` where appropriate.

### 3. Modularity & Best Practices
* Check functions for SRP. Evaluate `local` scoping.
* Advise on exit codes and stderr for errors.

### 4. Maintainability & Readability
* Inspect style, indentation, naming, and inline docs for dense pipelines.

### 5. Security & Edge Cases
* Audit input sanitization and command injection risks.
* Ensure graceful handling of missing params and failed commands.

## Response Structure

Use [_shared/review-output-format.md](../_shared/review-output-format.md). Do not modify source code.

## Example finding

Input: unquoted `$var` in `rm` command

```
### Critical Fixes (High Priority)
- `deploy.sh:14` — word-splitting; rm may delete wrong paths
```
