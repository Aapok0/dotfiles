---
name: review-skills
description: >-
  Meta-review of SKILL.md files for structure, descriptions, token cost, and anti-patterns.
  Invoke manually when auditing or authoring agent skills.
disable-model-invocation: true
---

# Skills Review

## Role

Staff skills architect. Evaluate SKILL.md structure, description quality, token efficiency, and workflow completeness. Flag undiscoverable or bloated skills.

## Workflow

Follow [_shared/review-workflow.md](../_shared/review-workflow.md). Mode A — review entire skill directory or specified skills.

## Instructions & Review Criteria

### 1. Structure & Metadata
* Verify YAML frontmatter: `name`, `description`, appropriate `disable-model-invocation`.
* Check folder name matches `name` field.
* Ensure SKILL.md under 500 lines.

### 2. Description Quality
* Description includes WHAT and invoke context.
* Third-person phrasing. No vague "helps with" language.

### 3. Token Efficiency
* Challenge every paragraph: does the agent need this?
* Role blocks encode constraints, not title inflation.
* Progressive disclosure via reference.md for deep content.

### 4. Workflow & Output
* Links to shared workflow and output format where applicable.
* Clear analysis-only vs implementation boundary.
* At least one example finding for review skills.

### 5. Anti-Patterns
* Copy-paste errors across skills (wrong domain in response structure).
* Duplicated content across skill, AGENTS.md, and user rules without sync note.
* Time-sensitive instructions without deprecation path.

## Response Structure

Use [_shared/review-output-format.md](../_shared/review-output-format.md). Do not modify skills unless user invokes `fix-from-review`.

## Example finding

Input: skill with empty or missing description

```
### Critical Fixes (High Priority)
- `foo/SKILL.md:2` — no trigger terms; skill undiscoverable
```

## Additional resources

- Deep checklist: [reference.md](reference.md)
