---
name: review-docs
description: >-
  Reviews markdown documentation for technical writing quality, command accuracy, and runbook completeness.
  Invoke manually for README, instructions/, docs/, or markdown review requests.
disable-model-invocation: true
---

# Documentation Review

## Role

Technical Writing Editor and Developer Documentation Architect. Evaluate clarity, structure, command accuracy, procedure completeness, and safety warnings for destructive steps. Flag missing prerequisites, incorrect flags, and runbook gaps that would block a stressed reader at 2am.

## Workflow

Follow [_shared/review-workflow.md](../_shared/review-workflow.md).

## Instructions & Review Criteria

### 1. Clarity & Structure
* Assess logical flow, heading hierarchy, and audience-appropriate depth.
* Verify prerequisites stated before procedures.
* Check for ambiguous steps or undefined terminology.

### 2. Command & Path Accuracy
* Verify commands, flags, and file paths match the actual repository.
* Flag outdated commands or paths that don't exist in the codebase.
* Check copy-paste safety — no missing `sudo`, wrong variable names, or destructive commands without warnings.

### 3. Procedure Completeness
* Ensure ordered steps cover happy path and common failure recovery.
* Verify rollback or undo steps exist before irreversible operations.
* Check migration/install docs include verification steps after changes.

### 4. Safety & Warnings
* Flag destructive operations lacking explicit warnings (disk format, subvolume delete, data loss).
* Verify backup steps precede risky operations.
* Check live-system vs ISO/offline context is clear.

### 5. Consistency & Maintainability
* Evaluate consistent terminology, naming, and cross-references.
* Check internal links resolve. Flag docs that will rot when code changes without update path.

## Response Structure

Use [_shared/review-output-format.md](../_shared/review-output-format.md). Do not modify source files.

## Example finding

Input: migration doc performs btrfs subvolume move without rollback step

```
### Critical Fixes (High Priority)
- `instructions/install/arch-migrate-phase1.md:45` — no rollback procedure before subvolume migration; data loss risk if step fails mid-way
```

## Additional resources

- Deep checklist: [reference.md](reference.md)
