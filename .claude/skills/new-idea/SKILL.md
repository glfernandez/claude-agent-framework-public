---
name: new-idea
description: Capture, research, and connect ideas before they are ready to become features. Detects when a new idea is related to or a new perspective on an older one. Lives in docs/research/. Promotes to /new-feature only when the operator says it's ready.
---

# New Idea

The idea memory layer. Ideas live here — some for days, some for months. They accumulate research, get revisited with new perspectives, and get connected to each other. Nothing gets implemented from here. The only exit is `/new-feature` when the operator decides an idea is ready.

## Where ideas live

All idea files go in `docs/research/<slug>.md`. This is not `docs/planning/` — that is for PRD-ready work. This is earlier: raw thinking, open questions, evolving understanding.

## Idea file format

```markdown
---
status: CAPTURING | RESEARCHING | READY | ADVANCED | PARKED
created: <date>
last-updated: <date>
related: [<slug>, <slug>]
---

# <Idea title>

## The idea
<One paragraph. What it is, why it matters, what problem it solves.>

## Open questions
<What is still unknown. What needs to be true before this can be grilled.>

## Research log
<!-- Append-only. Never edit past entries. -->

### <date>
<Finding, reference, or new perspective. What changed in understanding.>

## Connections
<Links to related ideas and how they connect — same problem different angle, subset, extension, contradiction.>

## Why not yet
<What would need to be true before this is ready to advance to /new-feature.>
```

## Status definitions

| Status | Meaning |
|--------|---------|
| `CAPTURING` | Just landed — idea recorded, not yet researched |
| `RESEARCHING` | Active research in progress |
| `READY` | Open questions resolved, the operator has said it's ready to advance |
| `ADVANCED` | Promoted to `/new-feature` — link to PRD added |
| `PARKED` | Set aside deliberately — reason in "Why not yet" |

## Process

### New idea comes in

1. Read every file in `docs/research/` — scan the idea statement, open questions, and research log for each
2. Check `docs/run_registry.md` for anything similar in-flight or already shipped
3. Check `docs/prds/` for any PRD that covers the same territory

4. **If overlap or connection found:** surface it before creating anything
   - "This connects to your idea `<slug>` from `<date>` — same problem, different angle. Do you want to add this as a new perspective on that idea, or is this genuinely separate?"
   - If same thread → append to existing file as a dated research log entry, note the new angle
   - If related but distinct → create new file, add cross-reference in `Connections` section of both

5. **If no overlap:** create `docs/research/<slug>.md` with status `CAPTURING`
6. Ask the operator: "What are the open questions on this?" — record them
7. Stop. Do not research unless the operator asks.

### Revisiting an existing idea

1. Read the target file fully
2. Present: current status, open questions remaining, research log summary, connected ideas
3. Ask: "New perspective to add? Research finding? Ready to advance? Or just reviewing?"
4. Update accordingly — research log entries are always appended with today's date, never edited

### Reviewing the idea backlog

1. Read all files in `docs/research/`
2. Group and display by status: READY → RESEARCHING → CAPTURING → PARKED → ADVANCED
3. For each: title, one-line summary, date created, open question count, connected ideas
4. Highlight any ideas that share connections — show the cluster
5. Ask: "Which one do you want to work on?"

### Promoting to /new-feature

1. Confirm status is `READY` — if not, show remaining open questions and stop
2. Update file: status → `ADVANCED`, add link to where PRD will be written
3. Hand off to `/new-feature` — pass the idea file as context so the grill session starts informed

## Rules

- Always scan for connections before creating a new file — never duplicate silently
- Research log is append-only and dated — past entries are never edited
- Never delete an idea — set status to `PARKED` with a reason
- Never advance to `/new-feature` without the operator explicitly saying it's ready
- `docs/research/` is the operator's thinking space — do not clean it up, reorganise it, or summarise away detail without being asked
