# Active Work Registry

This file is a live synchronization lock. Every parallel agent session must:
1. **Ask the user** for their role at session start (Dev 1, Dev 2, Architect, Designer, Auditor)
2. **Read this file** before touching any code or docs
3. **Register their claim** before modifying any file
4. **Clear or complete** their entry when done

## Status definitions

| Status | Meaning |
| :--- | :--- |
| `IN PROGRESS` | Agent is actively working on this scope. File is claimed — do not touch. |
| `COMPLETE` | Work is done. Artifact is correct for its intended purpose. |
| `PARKED` | Work has started but is blocked by an upstream dependency. See `Blocked By`. File may not be edited until the blocking issue is resolved. |

## Active and historical entries

| Role | Agent Session ID | Timestamp | Scope / Ticket | Files Claimed (Paths) | Status | Blocked By |
| :--- | :--- | :--- | :--- | :--- | :--- | :--- |
| — | — | — | — | — | — | — |

---

## Pipeline Sequence

Document your issue dependency chain here. No issue may begin implementation until all upstream issues are COMPLETE.

```
Issue 01 (...)
  → Issue 02 (...)
  → Issue 03 (...)
```

---

## Coordination rules

**Rule A — Dependency interrogation is mandatory at grill time.**
Before any issue spec is written, the grill session must explicitly answer: "Does this issue produce an artifact that a downstream issue will consume? Does it consume an artifact that a not-yet-complete upstream issue will produce?" Both directions must be checked before proceeding to PRD.

**Rule B — Research deliverables are not implementation specs.**
Work that exists only in `docs/research-deliverables/` is frozen reference, not an engineering requirement. If a finding must be implemented, it must be filed as an issue in `docs/issues/` before any downstream issue may claim it as a satisfied dependency.

**Rule C — PARKED is a required status.**
Any issue where implementation has started but cannot reach deploy-ready state without an upstream change must be marked `PARKED` with an explicit `Blocked By`. `COMPLETE` means the artifact is fully correct for its intended purpose — not merely that the code compiles and tests pass.
