# [Project Name] — Agent Operating Manual

Read this before touching anything.

---

## Base Layer — always active

These rules apply in every session, on every task.

**Surgical changes only.** Edit only lines directly related to the task. Do not touch adjacent formatting, unrelated code, or surrounding style. One task = one scope.

**Think before coding.** State assumptions and flag ambiguities before proposing a solution. If the question is underspecified, push back — do not answer the wrong question.

**Simplicity first.** Write the minimum code required. No speculative abstractions, no unrequested configuration, no future-proofing unless explicitly asked.

**No drive-by improvements.** If you notice a bug adjacent to your task, note it in chat. Do not fix it inline.

**State constraints before solutions.** Lead with what is fixed, what the boundary is, what must not change — then propose the approach.

**Iterate, don't present.** Your first response is rarely your final position. Push back, refine, confirm before committing to implementation.

---

## Concurrency lock — mandatory at session start

1. Ask the user: **"What is my role this session — Dev 1, Dev 2, Architect, Designer, or Auditor?"** Do not proceed until answered.
2. Read `docs/agents/active-work.md`.
3. If another agent has marked overlapping files as `IN PROGRESS` → halt and report the conflict.
4. If clear → register your Role, Session ID, timestamp, scope, and file paths with status `IN PROGRESS` before touching any file.
5. Update to `COMPLETE` or `PARKED` when done.

---

## Agent skills

### Engineering skills — Matt Pocock suite (bundled in `.claude/skills/`)

Bundled directly — no install needed. Run `/setup-matt-pocock-skills` first time in a new project to wire up issue tracker, labels, and domain docs.

| Skill | Purpose |
|-------|---------|
| `/improve-codebase-architecture` | Scan for structural friction; output deepening opportunities |
| `/tdd` | Write tests first against a spec |
| `/to-prd` | Turn a grilled idea into a PRD |
| `/to-issues` | Decompose a PRD into GitHub issues |
| `/triage` | File a bug or adjacent finding as an issue |
| `/grill-with-docs` | Stress-test a plan against project docs |
| `/codebase-design` | Architecture vocabulary and module-depth analysis |
| `/domain-modeling` | Extract domain model from code or docs |
| `/implement` | Implement an issue spec |
| `/prototype` | Fast proof-of-concept spike |
| `/diagnosing-bugs` | Structured bug diagnosis |
| `/ask-matt` | Opinionated engineering advice |

Source: `https://github.com/mattpocock/skills` — re-fetch to update.

### Domain-specific skills (optional) — Andrej Karpathy suite
ML, training pipelines, systems reasoning. Relevant for RL/MPC phases.
Fetch: `curl -sf https://raw.githubusercontent.com/multica-ai/andrej-karpathy-skills/main/skills/<name>/SKILL.md`

### Bundled custom skills (in `.claude/skills/`)

These are included in this repo — no install needed:

| Skill | When to use |
|-------|-------------|
| `/new-idea` | Capture ideas in `docs/research/`; scans for connections to older ideas; lets you revisit and add new perspectives; promotes to `/new-feature` when ready |
| `/new-feature` | Advance a ready idea through grill → PRD → issues → TDD; requires explicit user approval at each gate |
| `/optimise-codebase` | Background architecture track — scan, refactor, review; coordinates with active-work.md so it never touches claimed files |

### Project-specific skills
Add to `.claude/skills/<skill-name>/SKILL.md`. Document them here when added.

---

## Required reading before any build session

1. `docs/CONTEXT.md` — canonical terminology
2. `docs/run_registry.md` — sprint log, where we are, what's next
3. `docs/artifact_manifest.md` — which files are live vs stale
4. `docs/execution_governance.md` — rules, session checklist, what needs approval
5. `docs/agents/active-work.md` — concurrency registry

---

## Mandatory execution sequence

No code may be written until this chain is verified:

1. **Grill** — stress-test the plan against `docs/CONTEXT.md` and ADRs
2. **PRD** — write and file it in `docs/prds/<epic>.md`
3. **Issue decomposition** — break into GitHub issues via `gh issue create`
4. **TDD** — write tests first, file in `docs/issues/<epic>/tdd/`
5. **Execute** — implement against the tests

**Exceptions:** AFK cleanup tasks and research audits only.

---

## Output locations — where things go

| Artifact | Destination |
|---|---|
| Ideas and research | `docs/research/<slug>.md` — managed by `/new-idea` |
| PRDs | `docs/prds/<epic-name>.md` |
| Issue specs | `docs/issues/<epic>/NN-slug.md` |
| TDD plans | `docs/issues/<epic>/tdd/NN-slug-tdd.md` |
| Methodology notes | `docs/methodology/<topic>.md` |
| Architecture decisions | `docs/adr/NNNN-slug.md` |
| Sprint log | `docs/run_registry.md` (update in place) |

---

## Safety hooks (active via .claude/settings.json)

Two hooks enforce safety on every tool call:

- `block-dangerous-git.sh` — blocks `git push`, `reset --hard`, `clean -f`, `branch -D`, `checkout .`, `restore .`, `push --force`
- `block-concurrent-writes.sh` — blocks Write/Edit to any file claimed `IN PROGRESS` in `docs/agents/active-work.md`

Do not disable or work around these hooks.

---

## Coordination rules (from docs/agents/active-work.md)

**Rule A — Dependency interrogation is mandatory at grill time.**
Before any issue spec is written, explicitly answer: does this issue produce an artifact a downstream issue will consume? Does it consume an artifact a not-yet-complete upstream issue will produce? Both directions, before PRD.

**Rule B — Research deliverables are not implementation specs.**
Anything only in `docs/research-deliverables/` is frozen reference. To implement it, file a proper issue first.

**Rule C — PARKED is a required status.**
If implementation started but can't reach deploy-ready without an upstream change, mark it `PARKED` in `active-work.md` with an explicit `Blocked By`. `COMPLETE` means fully correct for its intended purpose.

---

## Project context

> **Replace this section** with your project's purpose, live deployment URL, demo accounts, workspace layout, and any critical rules specific to your stack.

---

## Optional Identity Layer

If this project uses a user- or team-specific identity overlay, reference it here.
Otherwise leave this section empty or point it at a neutral template.
