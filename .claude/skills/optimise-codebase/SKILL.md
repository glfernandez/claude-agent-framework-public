---
name: optimise-codebase
description: Background architecture track — scan for structural problems, plan safe refactors, execute with review gates. Runs alongside the feature track without blocking it. Use when the user wants to clean up architecture, reduce coupling, improve testability, or keep the codebase healthy between sprints. Pass a path or module name to scope the scan (e.g. /optimise-codebase app/lib or /optimise-codebase gemini-client).
argument-hint: "[optional] path or module to scope the scan — e.g. app/lib, app/api, gemini-client, artifact-registry"
---

# Optimise Codebase

A safe, continuous background track for improving codebase health. Always coordinates with the feature track via `docs/agents/active-work.md` before writing anything.

## Scope

If an argument was passed (e.g. `/optimise-codebase app/lib`), restrict the entire scan to that path or module. Do not surface findings outside that scope.

If no argument was passed, scan the full codebase.

Either way, tell the user the scope before starting: "Scanning: `<scope>`"

## Process

### 1. Orient

Read `docs/agents/active-work.md` — note all files currently claimed IN PROGRESS by other agents. These are off-limits for this session.

Read `docs/run_registry.md` — understand what sprint is active and what is being built.

### 2. Scan

Run `/improve-codebase-architecture` — analysis phase only. Produce the HTML report of findings.

Do not write to any file during this phase.

### 3. Present and prioritise

Show the findings to the user. For each finding, note:

- Which files it touches
- Whether any of those files are claimed in `docs/agents/active-work.md`
- Risk level (high = touches active feature files, low = isolated utility code)

Ask the user to approve which findings to action this session. Skip any finding that touches claimed files.

**Gate:** User approves the action list before any refactor begins.

### 4. For each approved finding — claim, refactor, review

Repeat this loop for each approved finding:

**a. Claim**
Register in `docs/agents/active-work.md`:
- Session ID, timestamp, scope (finding description), files to be touched, status IN PROGRESS

**b. Plan**
Run `/implement` — break the finding into the smallest safe commits. One concern per commit. No commit touches more than 3 files unless unavoidable.

**Gate:** User approves the commit plan before execution.

**c. Execute**
Implement commits one at a time.

**d. Review**
Run `/review` on each commit diff before moving to the next commit. If `/review` flags a correctness issue, fix it before continuing.

**e. Clear**
Update `docs/agents/active-work.md` — change status to COMPLETE or remove the entry.

### 5. Consistency check (optional)

After refactors are complete, run `/framework-consistency-check` to verify the ontology is still consistent with `docs/CONTEXT.md`.

Run `/traceability-check` to verify screen→API→data links are intact.

### 6. Update run registry

Append a row to `docs/run_registry.md` under the Sprint Log table:

```
| <sprint_id> | architecture | <one-line summary: N refactors, files changed, findings deferred> | <start date> | <end date> | completed | pass |
```

This is a completion gate — the session is not done until the registry is updated.

### 7. Clear active-work.md

Remove or mark COMPLETE all entries belonging to this session in `docs/agents/active-work.md`.

### 8. Report

Tell the user:
- How many findings were actioned
- Which files were changed
- Any findings deferred due to active claims — these should be revisited next session

## Rules

- Never write to a file claimed by another agent in `docs/agents/active-work.md`.
- Never refactor files that are part of an active sprint issue unless the user explicitly approves.
- Always run `/review` after each commit — do not batch review.
- Do not update `docs/CONTEXT.md` or `docs/adr/` unless `/improve-codebase-architecture` specifically identified a terminology or decision inconsistency. Coordinate with the feature track before touching shared docs.
- If a refactor reveals a bug adjacent to its scope, note it in chat. Do not fix it inline — file it via `/triage` instead.
