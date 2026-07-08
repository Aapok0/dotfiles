# Kubernetes Deep Checklist

Read when reviewing production cluster manifests or Kustomize overlays.

## Pod security

- [ ] `runAsNonRoot: true` with explicit `runAsUser`
- [ ] `readOnlyRootFilesystem: true` with writable volumes where needed
- [ ] `allowPrivilegeEscalation: false`
- [ ] `capabilities.drop: ["ALL"]` — add only required caps
- [ ] No `privileged: true` or `hostPID/hostNetwork` without justification

## Probes & lifecycle

- [ ] `livenessProbe` — detects deadlock, not dependency failure
- [ ] `readinessProbe` — gates traffic until ready
- [ ] `startupProbe` for slow-starting containers
- [ ] `terminationGracePeriodSeconds` matches drain time
- [ ] `preStop` hook for graceful shutdown

## Resources & scaling

- [ ] `requests` and `limits` set on all containers
- [ ] HPA configured with appropriate metrics
- [ ] PDB ensures minimum availability during disruptions
- [ ] Topology spread for zone redundancy

## RBAC

- [ ] Dedicated ServiceAccount per workload
- [ ] Role scoped to namespace; ClusterRole only when necessary
- [ ] No `verbs: ["*"]` on sensitive resources
- [ ] `automountServiceAccountToken: false` when not needed

## Networking

- [ ] NetworkPolicy restricts ingress/egress
- [ ] Ingress with TLS termination
- [ ] Internal services ClusterIP unless external access required
- [ ] No exposed NodePort for admin interfaces

## Config & secrets

- [ ] Secrets in external secret manager or sealed secrets
- [ ] ConfigMaps for non-sensitive config only
- [ ] Resource limits on ConfigMap/Secret volume mounts

## Operations

- [ ] Standard labels: `app.kubernetes.io/name`, `instance`, `version`
- [ ] Annotations for tooling (prometheus scrape, etc.)
- [ ] Kustomize overlays per environment, not copy-paste
