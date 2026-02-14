# Progress Management

## TodoWrite Usage

Use TodoWrite to manage the CURRENT Phase's tasks during active work. Use .learning/progress.md for persistent cross-session tracking.

## Context-Efficient Loading

When loading context for a phase, do NOT read the entire `.learning/plan.md`. Instead:
1. Read the **Learner Profile** section (background, goals, preferred language, tech stack)
2. Read only the **current phase's section** from `.learning/plan.md`
3. Read `.learning/journal.md` entries for **prerequisite phases only** (compact context on what came before)
4. Skip all other phase details — they are not needed and waste context window

This scoped loading strategy keeps context usage proportional to the current phase, not the total curriculum size.

## Sub-Agent Delegation

Use sub-agents (Task tool) for isolated tasks that don't need the teaching conversation's full context:

- **Research agent** (haiku model) — Delegate documentation lookups to ground educational content in real documentation (Principle 11). Input: library name, version, specific question. Output: 3-5 bullet summary with source citations. Used in `/lg:next` Step 3 and `/lg:decide` Step 3.

  **Tool preference order:**
  1. **Context7** (`resolve-library-id` → `query-docs`) — Best for framework-specific APIs, code examples, and version-specific details
  2. **WebSearch** — Best for general best practices, architectural patterns, and "how do production systems handle X" claims

  **Citation format:** Note the source in Insight blocks and trade-off analyses: "(per NestJS v10 docs)" or "(source: PostgreSQL 16 documentation)"

  **When docs are unavailable:** Flag uncertainty: "I couldn't verify this against the current docs — this is based on general knowledge and may need checking."
- **Checkpoint verifier** (haiku model) — Delegate deliverable verification. Input: list of checkpoint descriptions and expected file paths/patterns. Output: pass/fail report with details for failures. Used in `/lg:review` Step 2.

These sub-agents keep documentation fetching and mechanical verification out of the main teaching context, preserving context window for the interactive learning dialogue.

## Phase Workflow

When starting work on a Phase:
1. Read .learning/progress.md to confirm prerequisite phases are complete
2. Read .learning/plan.md to get the current Phase details
3. Create TodoWrite items for the Phase's tasks
4. Present the design/architecture topic FIRST (Insight format)
5. Begin implementation, pausing at Design Decision Points
6. If learner requests skip mode for any task, follow Principle 6

When completing a Phase:
1. Run all verification steps from the plan
2. Update .learning/progress.md with completed checkpoints
3. Conduct a Phase review (trigger via /lg:review)
