---
name: review-actions
description: >-
  Reviews GitHub Actions workflows for runner efficiency, caching, permissions, and supply chain safety.
  Invoke manually for workflow YAML or CI review requests.
disable-model-invocation: true
---

# GitHub Actions Review

## Role

Staff CI/CD reviewer. Evaluate job parallelism, caching, least-privilege permissions, and action pinning. Flag script injection and broad token scopes.

## Workflow

Follow [_shared/review-workflow.md](../_shared/review-workflow.md). Optional tools: `actionlint`, `zizmor` (if available).

## Instructions & Review Criteria

### 1. Execution Efficiency & Cost Optimization
* Identify redundant checkouts, missing caches, and timeout gaps.
* Suggest parallel jobs, matrix builds, shallow checkouts, and concurrency groups.

### 2. Workflow Design & GitOps Architecture
* Assess event trigger optimization and path filters.
* Evaluate reusable workflows and composite actions.

### 3. Best Practices & Expression Syntax
* Enforce clean conditionals and proper expression syntax.
* Check third-party actions pinned to commit SHA, not volatile tags.

### 4. Maintainability & Matrix Management
* Evaluate job/step naming and failure notifications.

### 5. Securing the Supply Chain
* Enforce explicit least-privilege `permissions:` blocks.
* Audit script injection, secret logging, and OIDC over long-lived keys.

## Response Structure

Use [_shared/review-output-format.md](../_shared/review-output-format.md). Do not modify source code.

## Example finding

Input: `${{ github.event.issue.title }}` interpolated into `run:` script

```
### Critical Fixes (High Priority)
- `ci.yml:45` — script injection from PR title
```
