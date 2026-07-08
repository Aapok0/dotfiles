# Documentation Review Deep Checklist

Read when reviewing install runbooks, migration guides, or technical README files.

## Structure & clarity

- [ ] Title and purpose clear in first paragraph
- [ ] Prerequisites listed before any commands
- [ ] Steps numbered and ordered logically
- [ ] Verification step after each major phase
- [ ] "What changes" summary for migration docs
- [ ] Scope boundaries stated (what is NOT covered)

## Command accuracy

- [ ] Every command verified against repo (paths, flags, binary names)
- [ ] Placeholders explained (`<disk>`, `$VAR`)
- [ ] `sudo` usage consistent and justified
- [ ] Package manager commands match target distro
- [ ] No references to files or scripts that don't exist

## Safety & recovery

- [ ] Backup step before destructive operations
- [ ] Rollback procedure for each irreversible step
- [ ] Warnings before data-loss operations (format, delete, subvolume move)
- [ ] Clean shutdown / unmount requirements stated
- [ ] Live system vs live ISO context explicit

## Runbook quality

- [ ] Failure symptoms and recovery for common errors
- [ ] Expected output shown for verification commands
- [ ] Time estimates or downtime notes where relevant
- [ ] Post-migration cleanup steps included
- [ ] "Delete this doc after migration" noted for one-time guides

## Consistency

- [ ] Terminology matches codebase (subvolume names, config paths)
- [ ] Cross-references between related docs are correct
- [ ] Version or phase numbers consistent across doc set
- [ ] Commands in prose match commands in code blocks
