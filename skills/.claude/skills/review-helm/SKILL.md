---
name: review-helm
description: >-
  Reviews Helm charts for template safety, values abstraction, probes, and cluster security.
  Invoke manually for Chart.yaml, values.yaml, or template review requests.
disable-model-invocation: true
---

# Helm Review

## Focus

Helm charts and Go templates only — not raw Kubernetes manifests (use `review-kubernetes`).

## Role

Staff Helm reviewer. Evaluate template modularity, values decoupling, probe requirements, and security contexts. Flag YAML-breaking templates and missing rollout guardrails.

## Workflow

Follow [_shared/review-workflow.md](../_shared/review-workflow.md). Optional tools: `helm lint`, `helm template` dry-run.

## Instructions & Review Criteria

### 1. Efficiency & Resource Optimization
* Identify missing resource requests/limits that trigger OOMKills or starvation.
* Suggest HPA metrics, replica spreads, and scheduling optimization.

### 2. Code Design & Architecture
* Assess template modularity, DRY compliance, and sub-chart usage.
* Verify abstractions avoid unnecessary configuration complexity.

### 3. Best Practices & Helm Idioms
* Enforce standard label/annotation schemas.
* Ensure proper Go template actions, pipelines, and deterministic conditions.

### 4. Maintainability & Readability
* Evaluate `values.yaml` grouping and inline documentation.
* Check chart naming and `_helpers.tpl` organization.

### 5. Security & Cluster Safety
* Scan for RBAC escalation, missing network policies, or unsafe host volumes.
* Verify security contexts, dropped capabilities, and health probes.

## Response Structure

Use [_shared/review-output-format.md](../_shared/review-output-format.md). Do not modify source code.

## Example finding

Input: deployment template without livenessProbe

```
### Critical Fixes (High Priority)
- `templates/deployment.yaml:22` — no livenessProbe; broken rollouts undetected
```
