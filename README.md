# Claude Multi-Agent Framework

A portable framework for running multiple Claude Code agents in parallel on the same codebase without conflicts. Includes an optional user identity layer so teams can tailor agent behaviour to a project or operator.

## What this gives you

- **Concurrency lock** — agents register file claims before touching anything; hooks block writes to files claimed `IN PROGRESS` by another agent
- **Safety hooks** — dangerous git commands blocked at the tool level
- **3 bundled custom skills** — idea memory, feature pipeline, architecture track
- **Canonical doc structure** — consistent locations every agent reads before starting work
- **Triage workflow** — GitHub Issues state machine with five labels
- **Optional identity overlay** — agents can load user- or team-specific working preferences

---

## Bundled skills (no install needed)

| Skill | Role |
|-------|------|
| `/new-idea` | Capture ideas in `docs/research/`; detects connections to older ideas; promotes to `/new-feature` when ready |
| `/new-feature` | Grill → PRD → issues → TDD; user approval required at each gate |
| `/optimise-codebase` | Background architecture health; never blocks the feature track |

**Workflow:**
```
/new-idea  →  (when READY)  →  /new-feature  →  dev agent executes
                                                 /optimise-codebase runs in parallel anytime
```

---

## External skills to install

```bash
# Required — core engineering workflow
claude skills install https://github.com/mattpocock/skills

# Then run once to wire up issue tracker, labels, domain docs
# /setup-matt-pocock-skills

# Optional — ML / systems projects
claude skills install https://github.com/multica-ai/andrej-karpathy-skills
```

See `docs/agents/skills-setup.md` for the full skill list and setup sequence.

---

## Directory structure

```
.claude/
  user-identity-template.md  ← optional identity/profile template
  settings.json              ← hooks wired to PreToolUse events
  hooks/
    block-dangerous-git.sh   ← blocks push/reset/clean/force
    block-concurrent-writes.sh ← enforces active-work.md concurrency lock
  skills/
    new-idea/                ← bundled: idea memory layer
    new-feature/             ← bundled: full feature pipeline
    optimise-codebase/       ← bundled: architecture track

docs/
  research/                  ← ideas live here (managed by /new-idea)
  agents/
    active-work.md           ← live concurrency registry (read + write every session)
    issue-tracker.md         ← gh CLI conventions + issue body format
    triage-labels.md         ← label strings + bootstrap commands
    domain.md                ← where agents find authoritative docs
    skills-setup.md          ← what to install and in what order
  adr/                       ← architectural decision records
  prds/                      ← one file per epic
  issues/                    ← issue specs + TDD plans
  methodology/               ← locked reference docs

CLAUDE.md                    ← agent operating manual
```

---

## How to adopt in a new project

1. Clone or copy this framework in
2. `chmod +x .claude/hooks/*.sh`
3. `claude skills install https://github.com/mattpocock/skills`
4. Run `/setup-matt-pocock-skills`
5. Fill in the "Project context" section of `CLAUDE.md`
6. Write `docs/CONTEXT.md` — your domain glossary
7. Run the `gh label create` commands from `docs/agents/triage-labels.md`

---

## Session start (every agent, every time)

1. Ask the operator: "What is my role this session — Dev 1, Dev 2, Architect, Designer, or Auditor?"
2. Read `docs/agents/active-work.md`
3. Check for `IN PROGRESS` conflicts on target files
4. Register claim before touching anything
5. Read required docs listed in `CLAUDE.md`

---

## Hook behaviour

Two hooks run automatically via `PreToolUse`.

`block-dangerous-git.sh` — fires on every `Bash` call. Blocks `git push`, `reset --hard`, `clean -f`, `branch -D`, `checkout .`, `restore .`, `push --force`. Prevents irreversible git mistakes without explicit user approval.

`block-concurrent-writes.sh` — fires on every `Write` and `Edit` call. Before writing, reads `docs/agents/active-work.md` and blocks if the target file is claimed `IN PROGRESS` by another agent. This is what makes the concurrency lock real — without it, `active-work.md` is just a document agents can ignore.

Both hooks use `$CLAUDE_PROJECT_DIR` — portable across any project path.
