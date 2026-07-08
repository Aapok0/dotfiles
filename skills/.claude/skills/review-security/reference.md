# Security Deep Checklist

Read when reviewing auth flows, sensitive data, or production-facing code.

## OWASP Top 10 mapping

- [ ] **A01 Broken Access Control** — authZ on every endpoint, no IDOR
- [ ] **A02 Cryptographic Failures** — TLS everywhere, no weak algorithms
- [ ] **A03 Injection** — parameterized queries, no shell interpolation
- [ ] **A04 Insecure Design** — threat model for new features
- [ ] **A05 Security Misconfiguration** — debug off in prod, defaults changed
- [ ] **A06 Vulnerable Components** — dependencies scanned and pinned
- [ ] **A07 Auth Failures** — MFA, session expiry, brute-force protection
- [ ] **A08 Integrity Failures** — signed artifacts, CI/CD pipeline security
- [ ] **A09 Logging Failures** — security events logged, no secrets in logs
- [ ] **A10 SSRF** — URL fetch validated, internal network blocked

## Secrets management

- [ ] No secrets in source, configs, or CI logs
- [ ] `.env` in `.gitignore`; `.env.example` without real values
- [ ] Rotation path documented for leaked credentials
- [ ] `gitleaks` or equivalent in CI

## Authentication

- [ ] Passwords hashed with bcrypt/argon2/scrypt
- [ ] JWT: short expiry, proper algorithm (RS256/ES256), no `none`
- [ ] Session tokens httpOnly, secure, sameSite
- [ ] OAuth state parameter validated

## Input & output

- [ ] All user input validated and sanitized at boundary
- [ ] Output encoded for context (HTML, URL, JS)
- [ ] File upload: type, size, and path validated
- [ ] Rate limiting on auth and expensive endpoints

## Infrastructure

- [ ] Containers non-root
- [ ] Network policies restrict pod traffic
- [ ] IAM least privilege
- [ ] Security headers (CSP, HSTS, X-Frame-Options)
