# Skills Authoring Deep Checklist

Read when creating or overhauling agent skills.

## Required structure

- [ ] Directory name matches `name` in frontmatter
- [ ] `description` under 1024 chars, third person
- [ ] `disable-model-invocation: true` for all skills unless auto-invoke is explicitly wanted
- [ ] SKILL.md under 500 lines

## Description quality

- [ ] States WHAT the skill does
- [ ] Includes invoke context ("Invoke manually for...")
- [ ] Key trigger terms for discovery UI

## Content efficiency

- [ ] Role uses 2–3 domain-relevant titles plus Evaluate sentence with constraints
- [ ] No explaining basics the model already knows
- [ ] Deep content in `reference.md`, not SKILL.md

## Workflow integration

- [ ] Links to `_shared/review-workflow.md` for review skills
- [ ] Links to `_shared/review-output-format.md` for output structure
- [ ] Clear boundary: analysis-only vs implementation
- [ ] Domain-specific tools listed as optional, non-blocking

## Quality gates

- [ ] One `## Example finding` with realistic input/output
- [ ] Response structure matches domain (not copy-pasted from another skill)
- [ ] No time-sensitive version pins without deprecation note
- [ ] Cross-tool deploy documented if not auto-discovered

## Anti-patterns to flag

- Duplicate content across skill, AGENTS.md, user rules without sync note
- Skill in non-standard path not reachable via stow
- Missing `name`/`description` frontmatter
- Workflow skill without safety rules (git, push, commit)
