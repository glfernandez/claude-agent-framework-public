# Agent Skills Setup

This framework has two layers of skills: bundled (in this repo) and external (installed via CLI).

---

## Bundled skills (already in this repo — no install needed)

| Skill | Purpose |
|-------|---------|
| `/new-idea` | Capture ideas in `docs/research/`; scans for connections to older ideas; lets you add new perspectives over time; promotes to `/new-feature` when ready |
| `/new-feature` | Advance a ready idea through grill → PRD → issues → TDD; explicit user approval required at each gate |
| `/optimise-codebase` | Background architecture track — scan, refactor, review; coordinates with `active-work.md` so it never touches files claimed by another agent |

---

## External Package 1 — Matt Pocock Engineering Skills (required)

**Repo:** https://github.com/mattpocock/skills

Core engineering workflow: grilling, PRDs, issue decomposition, TDD, code review, architecture, refactoring, triage.

### Install

```bash
claude skills install https://github.com/mattpocock/skills
```

### First-run setup

Run `/setup-matt-pocock-skills` once after installing. It will:
1. Detect your issue tracker (GitHub / GitLab / local markdown)
2. Confirm your triage label vocabulary
3. Confirm your domain doc layout (single-context vs monorepo)
4. Write `docs/agents/issue-tracker.md`, `docs/agents/triage-labels.md`, `docs/agents/domain.md`
5. Add an `## Agent skills` block to your `CLAUDE.md`

### Key skills from this package

| Skill | When to use |
|-------|-------------|
| `/setup-matt-pocock-skills` | Run once — scaffolds issue tracker, labels, domain docs |
| `/grill-with-docs` | Stress-test a plan against CONTEXT.md and ADRs |
| `/to-prd` | Turn grilled context into a filed PRD |
| `/to-issues` | Break a PRD into GitHub issues |
| `/tdd` | Build a feature or fix a bug test-first |
| `/review` | Code review on a diff |
| `/triage` | Issue state machine (needs-triage → ready-for-agent) |
| `/diagnosing-bugs` | Diagnosis loop for hard bugs and regressions |
| `/prototype` | Build throwaway UI or logic before committing |
| `/domain-modeling` | Sharpen terminology into CONTEXT.md |
| `/codebase-design` | Design deep modules |
| `/design-an-interface` | Generate multiple interface designs to compare |
| `/improve-codebase-architecture` | Deep architecture scan (called by `/optimise-codebase`) |
| `/request-refactor-plan` | Break a refactor into safe incremental commits |
| `/resolving-merge-conflicts` | Resolve in-progress merge/rebase conflicts |
| `/project-status-audit` | Session start — get current state from docs/ |
| `/ask-matt` | Router — asks which skill fits your situation |

---

## External Package 2 — Andrej Karpathy Skills (optional)

**Repo:** https://github.com/multica-ai/andrej-karpathy-skills

ML, training pipelines, and systems reasoning. Add if your project involves model training, data pipelines, or deep technical reasoning.

```bash
claude skills install https://github.com/multica-ai/andrej-karpathy-skills
```

Check the repo README for the current skill list before installing.

---

## Project-specific skills

Skills specific to your domain go in `.claude/skills/<skill-name>/SKILL.md`. Document them in your `CLAUDE.md` when added.

```
.claude/skills/
  my-skill/
    SKILL.md        ← skill definition (frontmatter + instructions)
```

---

## Setup sequence for a new project

1. Clone or copy this framework into your project
2. `chmod +x .claude/hooks/*.sh`
3. `claude skills install https://github.com/mattpocock/skills`
4. Run `/setup-matt-pocock-skills` to wire up issue tracker, labels, domain docs
5. (Optional) `claude skills install https://github.com/multica-ai/andrej-karpathy-skills`
6. Fill in the "Project context" section of `CLAUDE.md`
7. Write `docs/CONTEXT.md` — your domain glossary
8. Run `gh label create` commands from `docs/agents/triage-labels.md`
