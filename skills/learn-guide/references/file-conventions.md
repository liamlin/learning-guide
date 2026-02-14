# File Conventions

All learning state is stored in a `.learning/` directory in the project root.

## .learning/plan.md

Generated during `/lg:init`. Contains the full phased curriculum. Structure:

```markdown
# Learning Plan — [Project Name]

## Learner Profile
- Background: [from init interview]
- Goals: [from init interview]
- Preferred language: [from init interview — e.g., "English", "日本語", "繁體中文"]
- Phase depth: [Light / Standard / Deep]
- Tech Stack: [detected from codebase with versions — e.g., "NestJS 10.3, TypeORM 0.3, PostgreSQL 16"]

## Phase Overview
| # | Phase | Design/Architecture Topic | Prerequisites | Checkpoints |
|---|-------|--------------------------|---------------|-------------|
| 1 | ...   | ...                      | none          | 4           |

## Phase 1: [Name]
### Learning Objectives
### Design/Architecture Topic: [Name]
### Prerequisites: [Phase numbers, or "none"]
### Implementation Tasks
### Design Decision Points
### Checkpoints
#### Learning Checkpoints
#### Deliverable Checkpoints
### Verification

[Repeat for each Phase]
```

## .learning/progress.md

Created during `/lg:init`, updated throughout. Structure:

```markdown
# Learning Progress — [Project Name]

## Learner Goals
- [Goal 1]
- [Goal 2]

## Overall Progress
- Phases completed: X/Y
- Current phase: Phase N — [Name]
- Design decisions made: Z

---

## Phase 1: [Name] [STATUS_EMOJI] [Status]

### Learning Checkpoints
- [x] Concept checkpoint
- [x] Design decision: [description] -> Choice: [X], Rationale: [why]
- [x] Concept checkpoint (skipped — already familiar)

### Deliverable Checkpoints
- [x] Deliverable item
- [x] Verification passed
```

Status indicators: `Completed`, `In Progress`, `Pending`

## Glossary & Extended Reading Template

Present this block after the Insight block during each phase. Write in the learner's preferred language, keeping technical terms in English.

```
📚 Glossary & Extended Reading ─────────────────
• **[Term 1]** — [concise definition in 1-2 sentences]
• **[Term 2]** — [concise definition in 1-2 sentences]
• **[Term 3]** — [concise definition in 1-2 sentences]

🔗 Dive Deeper:
- [Topic/resource title 1] — [1-sentence description of what it covers]
- [Topic/resource title 2] — [1-sentence description of what it covers]
─────────────────────────────────────────────────
```

Guidelines:
- Include 3-6 key terms per phase, focusing on concepts introduced or heavily used in that phase
- Terms should be listed in the order they appear during implementation, not alphabetically
- Definitions should be practical ("what it means for your code") rather than academic
- Extended reading links should point to official documentation or authoritative sources discovered by the research sub-agent
- If no reliable external links are found, omit the "Dive Deeper" section rather than guessing URLs

## .learning/journal.md

Compact, append-only record of completed phase summaries and session snapshots. Created at phase completion (via `/lg:review`). Each entry targets 15-25 lines.

### Phase Completion Entry

```markdown
## Phase N: [Name] — Completed

### Key Concepts Learned
- [Concept 1 with brief explanation]
- [Concept 2]

### Decisions Made
1. [Decision]: Chose [X] because [rationale]

### Code Changes
- Created: [file paths]
- Modified: [file paths]

### Open Questions
- [Anything to revisit in later phases]
```

### Adjustment Entry

When a plan adjustment is made (via `/lg:adjust`), append an entry:

```markdown
## Adjustment: [Description] — [Date]
- Reason: [learner's stated reason]
- Changes: [what was modified in plan.md]
- Impact: [phases affected]
```

### Exploration Note

Appended during a phase when the agent provides a substantive explanation in response to a learner's question. Lightweight — 2-3 lines each. These notes preserve Q&A knowledge that would otherwise be lost after context compaction.

```markdown
### Exploration: [brief topic]
- Question: [what the learner asked, 1 sentence]
- Key takeaway: [1-2 sentence summary of the explanation provided]
```

### Journal Usage

This file is used by:
- **SessionStart hook** — loads last entry to give Claude session context
- **PreCompact hook** — injects current state before context compaction
- **`/lg:next`** — reads journal entries for prerequisite phases instead of loading full phase details
