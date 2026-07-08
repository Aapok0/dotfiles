---
name: review-ansible
description: >-
  Reviews Ansible playbooks and roles for idempotency, variable management, and security.
  Invoke manually for playbook, role, or task review requests.
disable-model-invocation: true
---

# Ansible Review

## Role

Staff Ansible reviewer. Evaluate idempotency, FQCN usage, variable scoping, and secret handling. Flag non-idempotent shell tasks and plaintext credentials.

## Workflow

Follow [_shared/review-workflow.md](../_shared/review-workflow.md). Optional tools: `ansible-lint`, `ansible-playbook --syntax-check`.

## Instructions & Review Criteria

### 1. Idempotency & State Management
* Ensure tasks are natively idempotent. Flag shell/command lacking `creates`, `removes`, or `changed_when: false`.
* Evaluate correct use of `state: present` vs `state: latest`.

### 2. Efficiency & Design Architecture
* Assess playbook/role structure. Look for redundant loops and block grouping opportunities.
* Review async execution for massive task sets.

### 3. Best Practices & Standard Patterns
* Enforce FQCN (`ansible.builtin.copy`).
* Evaluate variable management, defaults, and configuration grouping.

### 4. Maintainability & Readability
* Verify descriptive task names and clean inventory/defaults separation.

### 5. Security & Secret Hygiene
* Ensure Ansible Vault for sensitive parameters.
* Scan for `no_log: true` on credential tasks.

## Response Structure

Use [_shared/review-output-format.md](../_shared/review-output-format.md). Do not modify source code.

## Example finding

Input: plain-text password in vars file

```
### Critical Fixes (High Priority)
- `roles/db/vars.yml:3` — credential in plaintext; use Vault
```
