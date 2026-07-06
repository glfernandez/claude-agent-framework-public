# Domain Docs

Tells every agent where to find authoritative knowledge before writing code, naming modules, or filing issues.

## Layout

| Resource | Path | Purpose |
|----------|------|---------|
| Domain glossary | `docs/CONTEXT.md` | Canonical product and engineering terminology. Read before writing code or filing issues. |
| ADRs | `docs/adr/` | Architectural decisions. Check before proposing changes — don't re-litigate closed decisions. |
| Sprint log | `docs/run_registry.md` | Current sprint, what's done, what's next. Source of truth for backlog. |
| Artifact manifest | `docs/artifact_manifest.md` | Every live file, its path, and whether it's active or stale. |
| Execution governance | `docs/execution_governance.md` | What requires human approval, session checklist, non-negotiable rules. |

## Rules for agents reading this

- Always read `docs/CONTEXT.md` before proposing names for new modules or features.
- Always read `docs/adr/` before proposing architectural changes.
- If a term is undefined in `docs/CONTEXT.md`, stop and ask the user to define it before proceeding.
- Do not invent terminology. If the codebase uses a specific word for a concept, use that word.
