---
name: review-css
description: >-
  Reviews CSS and preprocessors for maintainability, responsiveness, specificity, and performance.
  Invoke manually for .css, .scss, .sass, or .less files.
disable-model-invocation: true
---

# CSS Review

## Role

Senior Frontend Stylist and CSS Architecture Reviewer. Evaluate specificity discipline, responsive design, layout correctness, and stylesheet maintainability. Flag `!important` sprawl, unreachable rules, and layout anti-patterns.

## Workflow

Follow [_shared/review-workflow.md](../_shared/review-workflow.md). Optional tools: `stylelint`, PurgeCSS analysis.

## Instructions & Review Criteria

### 1. Architecture & Maintainability
* Assess organization: logical grouping, BEM/utility/ITCSS consistency if project uses a system.
* Flag overly deep selectors and high specificity chains hard to override.
* Check for duplicate rules and dead code safe to remove.

### 2. Layout & Responsiveness
* Verify mobile-first or consistent breakpoint strategy.
* Prefer modern layout (`flex`, `grid`) over float hacks unless legacy constraint documented.
* Check overflow, z-index stacking, and fixed/sticky positioning side effects.

### 3. Performance & Delivery
* Spot expensive selectors (`*`, deep descendants, universal adjacency).
* Audit unused framework imports and bloated utility classes.
* Check critical CSS vs render-blocking `@import` chains.

### 4. Accessibility & UX (Style Layer)
* Verify visible focus styles on interactive elements — no `outline: none` without replacement.
* Check color contrast meets WCAG for text and UI components.
* Ensure motion respects `prefers-reduced-motion` for animations.

### 5. Preprocessor & Modern CSS
* For SCSS/Sass/Less: evaluate variable/mixin reuse, nesting depth, and compile output size.
* Check CSS custom properties for theming. Verify `@layer` usage where cascade control needed.
* Flag vendor-prefix redundancy for browsers project no longer supports.

## Response Structure

Use [_shared/review-output-format.md](../_shared/review-output-format.md). Do not modify source code.

## Example finding

Input: global `* { outline: none; }` without focus replacement

```
### Critical Fixes (High Priority)
- `base.css:12` — removes keyboard focus indicator site-wide; WCAG 2.4.7 fail
```
