---
name: traceability-check
description: Verify that data flow links — from entry point through processing to output — are intact after a refactor. Ensures no broken call chains or missing wiring introduced during structural changes.
---

# Traceability Check

After a refactor, verify that the data flow from inputs to outputs is still intact end-to-end.

## Process

1. Identify entry points (CLI args, config loading, bar loop start).
2. Trace the data flow forward through key processing stages to final outputs (trade records, metrics, CSV files).
3. Check that no call in the chain was accidentally severed, renamed without updating callers, or left unwired.

## Output

For each chain traced:
- **Intact** — all links present and connected
- **Broken** — specific function or handoff that is severed; show file and line
- **Suspect** — link exists but signature changed in a way that may silently mismatch

Do not edit any files. Report only.
