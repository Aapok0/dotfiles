# Terraform Deep Checklist

Read when reviewing complex modules or production infrastructure.

## State & backends

- [ ] Remote state backend configured (S3/GCS/Azure/blob + locking)
- [ ] State bucket encryption and versioning enabled
- [ ] No local state in CI or team workflows
- [ ] `terraform.workspace` usage documented if multi-env
- [ ] State migration path defined for renames

## Module design

- [ ] Modules expose outputs consumers need; no leaky internals
- [ ] Variable defaults safe for all environments
- [ ] `for_each` preferred over `count` when resource identity matters
- [ ] Module version pinned in caller (`source` ref or registry version)

## IAM

- [ ] No `*` actions on `*` resources unless justified
- [ ] Service-specific policies over `AdministratorAccess`
- [ ] IAM roles use trust policy condition keys (OIDC, source account)
- [ ] PassRole scoped to required roles only

## Networking

- [ ] No `0.0.0.0/0` on admin ports (22, 3389, DB ports)
- [ ] Private subnets for workloads; public only for load balancers/bastions
- [ ] Security groups follow least privilege per tier

## Lifecycle & safety

- [ ] `prevent_destroy` on stateful resources (DB, buckets) where appropriate
- [ ] `ignore_changes` only for externally managed attributes
- [ ] `create_before_destroy` on resources that can't tolerate gap

## CI/CD integration

- [ ] `terraform plan` in CI on every PR
- [ ] Apply gated to protected branches
- [ ] Provider versions locked in `required_providers`
