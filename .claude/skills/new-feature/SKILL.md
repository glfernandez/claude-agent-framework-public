---
name: new-feature
description: Take a READY idea from docs/research/ through to implementation-ready — grilling, domain modeling, interface design, PRD, issues, and TDD. Use when the user is ready to advance a draft idea into a buildable spec. Requires explicit user approval at each gate before advancing.
---

# New Feature

Advance a READY idea from `docs/research/` through the full specification pipeline. No code is written in this skill — the output is a filed PRD, GitHub issues, and a TDD plan ready for a dev agent.

## Process

### 1. Orient

Run `/project-status-audit` to confirm current sprint state and what is already in flight.

Read `docs/agents/active-work.md` — note any active sessions.

Show the user the ideas in `docs/research/` with status `READY`. Ask: "Which idea do you want to advance?"

Read the selected idea file fully before proceeding.

### 2. Grill

Run `/grill-with-docs` — stress-test the idea against `docs/CONTEXT.md` and `docs/adr/`. All terminology decisions and architectural constraints must be resolved here.

**Gate:** Do not proceed until the grill session is complete and the user confirms decisions are locked.

### 3. Domain modeling (if needed)

If the grill session introduced new concepts not in `docs/CONTEXT.md`, run `/domain-modeling` to sharpen the terminology.

Skip if no new concepts emerged.

### 4. Interface design (if needed)

If the feature requires a new module, function, or API shape, run `/codebase-design` or `/design-an-interface` to produce 2–3 candidate interface shapes before committing to one.

Skip if the interface is already defined by an existing seam.

**Gate:** User picks an interface shape before proceeding.

### 5. PRD

Run `/to-prd` — synthesise the grill session into a PRD written to `docs/prds/<epic>.md` and filed as a GitHub Issue.

Update the idea file in `docs/research/<slug>.md` — change its status to `ADVANCED` and add a link to the PRD.

**Gate:** User approves the PRD before proceeding.

### 6. Issues

Run `/to-issues` — break the PRD into vertical slice issues written to `docs/issues/<epic>/NN-slug.md` and filed to GitHub.

**Gate:** User approves the issue breakdown before proceeding.

### 7. TDD

Run `/tdd` — write the test plan for the first issue slice. Output to `docs/issues/<epic>/tdd/NN-slug-tdd.md`.

**Gate:** User approves the test plan before any implementation begins.

### 8. Hand off to dev

Tell the user the feature is implementation-ready. Remind the dev agent to:

1. Read `docs/agents/active-work.md`
2. Register its claim before touching any file
3. Implement against the TDD plan
4. Clear its claim when done

### 9. Update run registry

After the feature ships, append a row to `docs/run_registry.md` under the Sprint Log table:

```
| <sprint_id> | product | <one-line description of what shipped> | <start date> | <end date> | completed | pass — <deployment revision or test result> |
```

This is a completion gate — the feature is not done until the registry is updated.

### 10. Clear active-work.md

Remove or mark COMPLETE all entries belonging to this session in `docs/agents/active-work.md`.

### 11. After ship — review backlog

Return to `docs/research/` and show remaining READY ideas. Ask: "What's next?"

## Rules

- Never skip a gate. Each step requires explicit user confirmation before the next begins.
- Never write to code files — this skill is specification-only.
- Only advance ideas with status `READY` in `docs/research/`. If the idea is not ready, send the user back to `/new-idea`.
- If `/grill-with-docs` reveals the idea is not ready, write the open questions back to the research file and stop. Do not force a PRD from an incomplete grill.
