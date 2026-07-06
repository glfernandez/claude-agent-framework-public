---
name: framework-consistency-check
description: Verify that the project's ontology and terminology in docs/CONTEXT.md is still consistent with the codebase after a refactor. Check that module names, function names, and domain terms align with the canonical glossary.
---

# Framework Consistency Check

After a refactor, verify the codebase terminology still matches `docs/CONTEXT.md`.

## Process

1. Read `docs/CONTEXT.md` — collect all canonical terms and their definitions.
2. Search the codebase for each term (and common misspellings or synonyms).
3. Flag any place where code uses a term that contradicts or drifts from the canonical definition.
4. Flag any domain concept used widely in code that is missing from `CONTEXT.md`.

## Output

Report findings as:
- **Consistent** — term used correctly everywhere
- **Drift** — term used inconsistently; show file and line
- **Missing** — concept in code with no `CONTEXT.md` entry; suggest adding it

Do not edit any files. Report only. The user decides whether to update `CONTEXT.md` or rename code.
