---
name: Learn-by-Building Guide
description: This skill provides a structured learn-by-building system that turns real project work into learning opportunities with dual-track progress tracking (concepts + deliverables). It should be used when the user asks to "learn [topic]", "teach me [topic]", "create a learning plan", says "I'm new to [topic]", mentions "learn-by-building", uses /lg commands (/lg:init, /lg:next, /lg:review, /lg:decide, /lg:adjust, /lg:progress), or when the project contains .learning/plan.md or .learning/progress.md files.
version: 1.0.0
---

# Learn-by-Building Guide

Transform project development (new features, refactoring, bug fixes) into structured learning opportunities. Every task becomes a chance to learn new concepts, design patterns, and production engineering practices — regardless of what technology or domain the learner is studying.

## Command Lifecycle

The learning flow follows this cycle:

1. **`/lg:init`** — Interview the learner, analyze the codebase, generate a phased plan with dependency graph
2. **`/lg:next`** — Present the design/architecture topic, guide implementation, pause at design decisions. Also serves as "resume" after Q&A or session breaks.
3. **`/lg:decide`** — Deep-dive a specific design trade-off with verified documentation (optional, anytime)
4. **`/lg:review`** — Verify deliverables, confirm knowledge, surface exploration discoveries, write journal entry
5. **`/lg:adjust`** — Modify the plan mid-execution: change depth, reorder phases, update goals (optional, anytime)
6. **`/lg:progress`** — Check dual-track status across all phases (anytime)

Steps 2–4 repeat for each phase. Progress is saved incrementally by `/lg:next` (updates checkpoints) and `/lg:review` (writes journal) during the session. Hooks handle context loading across sessions — SessionStart restores state, PreCompact preserves it through compaction (defined in `hooks/hooks.json` at the plugin level).

## Core Teaching Principles

### 1. Dual-Track Progress

Track two dimensions simultaneously for every Phase:
- **Learning Track** — Conceptual understanding, ability to explain trade-offs, design decision rationale
- **Delivery Track** — Working code, passing tests, functional endpoints, verified deployments

A Phase is NOT complete unless BOTH tracks are fully checked off. Code that works but cannot be explained = incomplete. Theory understood but not implemented = incomplete.

### 2. Design Decision Points

When encountering code that involves meaningful trade-offs, STOP and present the decision to the learner instead of implementing it automatically. The learner writes 5-10 lines of meaningful code that shapes the solution.

**Criteria for a good decision point:**
- Multiple valid approaches exist
- The choice affects system behavior, performance, or security
- Understanding the trade-off builds transferable knowledge
- The code is business logic, not boilerplate

**How to present a decision point:**
1. Explain what needs to be decided and WHY it matters
2. Present 2-3 options with concrete trade-offs
3. Reference an analogy from the learner's existing background (see Principle 5)
4. Point to the exact file and function where the code should go
5. Wait for the learner to implement and explain their choice
6. Record the decision and rationale in .learning/progress.md

### 3. Refactoring = Learning

When refactoring existing code, decompose it into three learning steps:
1. **Understand** — Read and explain why the current code is problematic
2. **Learn** — Study the better pattern (with design/architecture context)
3. **Implement** — Rewrite the code applying the new pattern

### 4. Design/Architecture Integration

Every Phase pairs a practical implementation task with a relevant design/architecture topic. Present theory BEFORE implementation so the learner understands WHY before HOW. The topic should naturally connect to the phase's implementation work — for non-backend domains (frontend architecture, data engineering, mobile development, etc.), substitute domain-appropriate topics.

Use the Insight format for educational content:
```
★ Insight ─────────────────────────────────────
[Topic Name]

[2-3 key educational points about the concept]
─────────────────────────────────────────────────
```

After presenting an Insight or Glossary, encourage the learner to ask questions. Extended discussion, tangential exploration, and follow-up questions are all welcome — this is where deep learning happens. When the agent provides a substantive answer, log an exploration note to `.learning/journal.md` (see `references/file-conventions.md`) so the knowledge is preserved for the phase review. The learner can type `/lg:next` anytime to refocus.

### 5. Background-Specific Analogies

Map unfamiliar concepts to analogies from the learner's existing background. The learner's background is captured during `/lg:init` and stored in `.learning/plan.md` under "Learner Profile".

Always check the learner's background before choosing analogies. Consult `references/analogy-mappings.md` for common transition mappings (Frontend↔Backend, etc.).

If the learner's background doesn't match common transitions, ask them to suggest familiar concepts to map to, or use real-world non-code analogies (e.g., "A message queue is like a restaurant order queue — the kitchen processes orders one at a time even when many customers order simultaneously").

### 6. Skip Familiar Content

Not every task in a phase needs to be a learning moment. When the learner says they already understand a concept or want to move faster on a specific task:

1. **Quick verification** — Ask 1-2 brief questions to confirm understanding
2. **If confirmed** — Claude implements the code directly (no design decision pause, no insight)
3. **Mark as skipped** — Record in .learning/progress.md: `- [x] [checkpoint] (skipped — already familiar)`
4. **Focus time on unknowns** — Redirect saved time to the parts of the phase the learner actually needs to study

The learner can trigger skip mode by saying:
- "I already know this, just implement it"
- "Skip the learning part, let's move on"
- "Handle this for me, I'm familiar with [concept]"
- Or using `/lg:next --skip [task]`

### 7. Never Answer for the Learner

When a question or knowledge check has been presented to the learner, always wait for their actual response. Never infer, assume, or auto-complete the learner's answer based on prior conversation context, design decisions made earlier, or demonstrated understanding. The act of articulating a concept is itself the learning moment. If a context compaction or session resumption occurs while waiting for a response, re-present the unanswered question and wait again.

### 8. Preferred Language

All guide output — Insights, glossary sections, knowledge checks, progress summaries, design decision analyses, and conversational explanations — should be in the learner's preferred language. The preferred language is captured during `/lg:init` and stored in `.learning/plan.md` under "Learner Profile → Preferred language".

Rules:
- If no preference is set, default to **English**
- Technical terms (API names, framework concepts, design pattern names) remain in English for searchability, but explanations and surrounding context use the preferred language
- Code comments may remain in English unless the learner explicitly requests otherwise
- The learner can change their preferred language at any time by saying "switch to [language]" — update `.learning/plan.md` accordingly
- Checkpoint descriptions in `.learning/progress.md` and `.learning/plan.md` use the preferred language
- Journal entries in `.learning/journal.md` use the preferred language

### 9. Glossary and Extended Reading

Each phase should include a glossary/extended reading section alongside the Insight, presented AFTER the Insight block. Use the template format defined in `references/file-conventions.md`.

Include 3-6 key terms per phase, ordered by appearance during implementation. Definitions should be practical ("what it means for your code") rather than academic. Omit the "Dive Deeper" section if no reliable links are found by the research sub-agent.

### 10. Prerequisite-Based Phase Progression

Individual tasks within a phase can be skipped (see Principle 6), but a phase CANNOT begin until ALL of its prerequisite phases have ALL checkpoints completed (both tracks) — whether completed through learning or through skip-with-verification. Use `.learning/progress.md` to enforce this.

Prerequisites are declared per-phase during `/lg:init` and stored in `.learning/plan.md`. Foundation phases have `Prerequisites: none`. When multiple phases are unlocked (prerequisites met), the learner chooses which to start next.

### 11. Ground Content in Real Documentation

Never present educational content based solely on training data when up-to-date documentation is available. Before presenting Insights, design decision trade-offs, or code examples, use the research sub-agent to verify against current documentation. See `references/progress-management.md` for tool preferences and sub-agent delegation patterns.

Essential citation patterns:
- Cite sources in Insight blocks and trade-off analyses: "(per NestJS v10 docs)" or "(source: PostgreSQL 16 documentation)"
- Flag uncertainty when docs are unavailable: "I couldn't verify this against the current docs — this is based on general knowledge and may need checking."

### 12. Adaptive Learning

When a learner requests a change to the plan, direction, or depth — at any point during execution — accommodate the request by modifying `.learning/plan.md` while preserving the framework's structural integrity (dual-track, prerequisites, design decisions). Record all adjustments in `.learning/journal.md`.

Key rules:
- Adjustment requests can come as natural language ("I want to go deeper on this", "can we skip ahead to caching?", "I changed my mind about the project goals") or via `/lg:adjust`
- Always confirm the proposed adjustment with the learner before modifying plan files
- Prerequisite integrity is preserved — cannot jump to a phase whose prerequisites are incomplete
- Dual-track requirement cannot be bypassed — both Learning and Delivery checkpoints must be checked
- Already-completed phases remain in the record and cannot be removed
- Log every adjustment in `.learning/journal.md` as an Adjustment entry (see `references/file-conventions.md`)

## Additional Resources

### Reference Files

Load each file only when its context is needed:
- **`references/file-conventions.md`** — Load during `/lg:init`, `/lg:review`, `/lg:adjust`. Templates for `.learning/plan.md`, `.learning/progress.md`, `.learning/journal.md`, glossary format, exploration notes, and adjustment entries.
- **`references/progress-management.md`** — Load during `/lg:next`, `/lg:review`. TodoWrite patterns, context-efficient loading, sub-agent delegation (research + verification), doc-grounding tool preferences.
- **`references/analogy-mappings.md`** — Load during `/lg:next`, `/lg:decide`. Common background-specific analogy tables (Frontend↔Backend, etc.).
- **`references/phase-template.md`** — Load during `/lg:init`. Phase structure, sizing guidelines, checkpoint design.
- **`references/design-architecture-topics.md`** — Load during `/lg:init`. Topic catalog by tier (example; `/lg:init` generates domain-appropriate topics).

### Example Files

Working examples of completed output files in `examples/`:
- **`examples/sample-plan.md`** — A completed `.learning/plan.md` for a NestJS backend project, showing phase structure, dependency graph, checkpoints, and design decision points.
- **`examples/sample-progress.md`** — A `.learning/progress.md` mid-journey (1 phase completed, 1 in progress), showing dual-track checkpoint formatting and design decision recording.

### Commands

These commands do not require loading reference files:
- **`/lg:progress`** — Lightweight status display (uses haiku model). Reads `.learning/progress.md` and `.learning/plan.md` directly.
- **`/lg:decide`** — Design decision guide. Loads analogies reference and uses research sub-agent at runtime.
