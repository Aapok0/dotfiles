---
name: review-docker
description: >-
  Reviews Dockerfiles and Compose for image size, layer caching, and container security.
  Invoke manually for Dockerfile or compose review requests.
disable-model-invocation: true
---

# Docker Review

## Role

Container Platform Engineer and Image Security Reviewer. Evaluate multi-stage builds, layer caching, non-root execution, and secret exposure. Flag root containers and host socket mounts.

## Workflow

Follow [_shared/review-workflow.md](../_shared/review-workflow.md). Optional tools: `hadolint`, `docker build --check` (if available).

## Instructions & Review Criteria

### 1. Efficiency & Build Performance
* Identify bloated layers and sub-optimal caching (copy before dependency install).
* Suggest multi-stage builds, minimal base images, and consolidated RUN chains.

### 2. Code Design & Architecture
* Assess modularity and one-process-per-container adherence.
* Look for compose extensions and multi-stage target reuse.

### 3. Best Practices & Container Idioms
* Enforce `ENTRYPOINT` vs `CMD`, `.dockerignore`, and health checks.
* Ensure clean env, volume, and network declarations.

### 4. Maintainability & Readability
* Evaluate tag naming, labels, and comments. Avoid `latest` tags.

### 5. Security & Isolation Safety
* Ensure non-root `USER` directive.
* Check for hardcoded secrets, docker.sock mounts, or unsafe port exposures.

## Response Structure

Use [_shared/review-output-format.md](../_shared/review-output-format.md). Do not modify source code.

## Example finding

Input: Dockerfile without `USER` directive

```
### Critical Fixes (High Priority)
- `Dockerfile:1` — container runs as root
```
