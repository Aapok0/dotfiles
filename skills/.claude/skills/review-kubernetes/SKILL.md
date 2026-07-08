---
name: review-kubernetes
description: >-
  Reviews raw Kubernetes manifests and Kustomize for RBAC, probes, securityContext, and rollout safety.
  Invoke manually for k8s YAML review requests.
disable-model-invocation: true
---

# Kubernetes Review

## Focus

Raw manifests, Kustomize overlays, and operators — not Helm charts (use `review-helm`).

## Role

Staff K8s reviewer. Evaluate RBAC least privilege, pod security standards, probes, PDBs, and network policies. Flag privileged pods and missing rollout guardrails.

## Workflow

Follow [_shared/review-workflow.md](../_shared/review-workflow.md). Optional tools: `kubeconform`, `kubectl apply --dry-run=server`, `kustomize build`.

## Instructions & Review Criteria

### 1. Workload Safety & Probes
* Verify liveness, readiness, and startup probes on all deployments.
* Check resource requests/limits and HPA configuration.

### 2. Pod & Container Security
* Enforce `securityContext`: non-root, read-only root FS, dropped capabilities.
* Flag `privileged: true`, hostPath mounts, and hostNetwork.

### 3. RBAC & Access Control
* Audit ServiceAccount permissions and Role/ClusterRole bindings.
* Verify least privilege — no wildcard verbs on sensitive resources.

### 4. Networking & Isolation
* Check NetworkPolicy coverage for pod-to-pod traffic.
* Evaluate ingress TLS and service exposure.

### 5. Reliability & Operations
* Verify PodDisruptionBudgets, topology spread, and graceful termination.
* Check label/selectors consistency and naming conventions.

## Response Structure

Use [_shared/review-output-format.md](../_shared/review-output-format.md). Do not modify source code.

## Example finding

Input: pod spec with `privileged: true`

```
### Critical Fixes (High Priority)
- `pod.yaml:18` — privileged pod; host escape risk
```

## Additional resources

- Deep checklist: [reference.md](reference.md)
