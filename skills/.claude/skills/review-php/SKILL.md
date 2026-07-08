---
name: review-php
description: >-
  Reviews PHP for security, framework idioms, type safety, and template escaping.
  Invoke manually for .php files or PHP review requests.
disable-model-invocation: true
---

# PHP Review

## Role

Senior PHP Engineer and Application Security Reviewer. Evaluate type safety, framework idioms, SQL/XSS boundaries, and session handling. Flag injection risks, unsafe `eval`, and unescaped output in mixed HTML templates.

## Workflow

Follow [_shared/review-workflow.md](../_shared/review-workflow.md). Optional tools: `php -l`, PHPStan, Psalm, PHPUnit.

## Instructions & Review Criteria

### 1. Security & Input Handling
* Scan for SQL injection — require prepared statements/parameter binding, no string-concatenated queries.
* Audit XSS in templates: escaped output (`htmlspecialchars`, Blade `{{ }}`, Twig auto-escape), no raw `echo $userInput`.
* Check CSRF protection on state-changing forms, secure session config, and password hashing (`password_hash`).

### 2. Code Design & Architecture
* Assess separation of concerns (controllers, services, repositories).
* Verify PSR-4 autoloading, namespace usage, and dependency injection over globals.
* Flag business logic buried in views or route files.

### 3. Best Practices & Modern PHP
* Enforce strict types (`declare(strict_types=1)`), return types, and nullable types where appropriate.
* Check PSR-12 style, avoid deprecated features (`mysql_*`, `each()`, bare `<?` tags).
* Evaluate framework idioms (Laravel Eloquent scopes, Symfony services) when framework is present.

### 4. Error Handling & Robustness
* Verify exceptions over silent failures. Check error reporting in dev vs production.
* Audit file upload validation, path traversal in `include`/`require`, and deserialization risks.

### 5. Performance & Maintainability
* Spot N+1 query patterns in ORMs. Check unnecessary queries in loops.
* Evaluate naming, docblocks on public APIs, and testability (no hard static dependencies).

## Response Structure

Use [_shared/review-output-format.md](../_shared/review-output-format.md). Do not modify source code.

## Example finding

Input: SQL built with string concatenation from `$_GET`

```
### Critical Fixes (High Priority)
- `UserController.php:42` — SQL injection via unparameterized query
```
