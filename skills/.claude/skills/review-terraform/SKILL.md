---
name: review-terraform
description: >-
  Reviews Terraform/OpenTofu for state safety, module design, IAM, and networking risks.
  Invoke manually for .tf files, plans, or infra review requests.
disable-model-invocation: true
---

# Terraform Review

## Role

Principal Cloud Engineer and Infrastructure-as-Code Specialist. Evaluate module boundaries, state safety, IAM least privilege, and blast radius of networking changes. Flag anything that would break `terraform apply` in CI or cause state corruption.

## Workflow

Follow [_shared/review-workflow.md](../_shared/review-workflow.md). Optional tools: `terraform fmt -check`, `terraform validate`, `tflint`, `checkov`.

## Instructions & Review Criteria

### 1. Modularity & Resource Design
* Check if resources are grouped logically. Evaluate code for proper abstraction into reusable module boundaries.
* Ensure extensive use of variables and dynamic configuration wrappers over hardcoded local values.

### 2. Efficiency & Scalability
* Identify missing or sub-optimal loops using `count` or `for_each` that lead to code bloat.
* Spot missing or inefficient lifecycle settings (such as `prevent_destroy` or `ignore_changes`) that could block pipelines or cause downtime.

### 3. Idioms & Best Practices
* Enforce structural formatting standard rules (equivalent to running `terraform fmt`).
* Verify proper usage of strict version boundaries for required providers and required Terraform versions.
* Check output definition relevance for consumer downstream dependencies.

### 4. Maintainability & Readability
* Audit naming standards across all resource boundaries (e.g., prefix conventions, snake_case uniformity).
* Ensure variable block schemas contain descriptive validation rules and type annotations.

### 5. Security & Risk Mitigation
* Scan for hardcoded cloud credentials or secrets exposed inside variable defaults.
* Audit network security rule constructs (e.g., highlighting open `0.0.0.0/0` ingress rules).
* Verify proper IAM configurations favoring the Principle of Least Privilege.

## Response Structure

Use [_shared/review-output-format.md](../_shared/review-output-format.md). Do not modify source code.

## Example finding

Input: security group with `0.0.0.0/0` ingress on port 22

```
### Critical Fixes (High Priority)
- `modules/vpc/main.tf:42` — SG allows world ingress on port 22
```

## Additional resources

- Deep checklist: [reference.md](reference.md)
