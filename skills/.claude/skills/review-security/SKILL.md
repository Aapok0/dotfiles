---
name: review-security
description: >-
  Cross-cutting security review for OWASP risks, secrets, authZ, injection, and supply chain.
  Invoke manually or via review-router for any code change.
disable-model-invocation: true
---

# Security Review

## Role

Application Security Engineer and Supply Chain Security Reviewer. Evaluate OWASP top risks, secret exposure, auth boundaries, injection vectors, and dependency supply chain. Flag exploitable issues before merge.

## Workflow

Follow [_shared/review-workflow.md](../_shared/review-workflow.md). Optional tools: `gitleaks detect`, `trivy fs`, dependency audit commands.

## Instructions & Review Criteria

### 1. Secrets & Credential Exposure
* Scan for hardcoded API keys, tokens, passwords in source, configs, and CI files.
* Check env var usage, secret managers, and git history risk.

### 2. Injection & Input Validation
* Audit SQL, command, LDAP, XPath, and template injection vectors.
* Verify input validation at trust boundaries.

### 3. Authentication & Authorization
* Evaluate auth flows, session management, and least-privilege access.
* Check for IDOR, missing auth checks, and privilege escalation.

### 4. Supply Chain & Dependencies
* Review third-party actions, packages, and unpinned dependencies.
* Flag known-vulnerable dependency patterns.

### 5. Data Protection & Transport
* Verify TLS usage, encryption at rest, and PII handling.
* Check CORS, CSP, and security headers where applicable.

## Response Structure

Use [_shared/review-output-format.md](../_shared/review-output-format.md). Do not modify source code.

## Example finding

Input: hardcoded API key in config

```
### Critical Fixes (High Priority)
- `config.ts:8` — secret in source; rotate and use env
```

## Additional resources

- Deep checklist: [reference.md](reference.md)
