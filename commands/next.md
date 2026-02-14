---
description: Start or resume your current learning phase
argument-hint: "[phase-number] (optional, defaults to next incomplete phase)"
---

# Start or Resume Learning Phase

Load the `lg:learn-guide` skill using the Skill tool before proceeding.

## Step 1: Load Progress (Scoped)

Read `.learning/progress.md` from the project root.

**If no `.learning/progress.md` exists:**
Inform the learner: "No learning plan found. Run `/lg:init` first to create one."
Stop here.

**If `.learning/progress.md` exists:**
Read the Overall Progress section and identify all phase statuses (Completed, In Progress, Pending).

## Step 2: Determine Mode

### Mode A: Resume In-Progress Phase

**If a phase is already "In Progress" and `$ARGUMENTS` does not specify a different phase number:**

Enter Resume Mode — this is the primary way learners refocus after divergent Q&A or session breaks.

1. Read the **Learner Profile** section from `.learning/plan.md` (background, goals, preferred language, tech stack)
2. Read the **current phase's section** from `.learning/plan.md`
3. Read `.learning/progress.md` to identify completed vs remaining checkpoints
4. Read recent entries from `.learning/journal.md` — look for the latest exploration notes or session context

Present a **Resume Block** in the learner's preferred language:

```
📍 Resume — Phase [N]: [Name]
─────────────────────────────────────────────────

Progress: [X]/[Y] checkpoints completed
✅ Completed: [brief list of completed checkpoints]
⬜ Remaining: [brief list of remaining checkpoints]

Last activity: [summary of what was last worked on or discussed — from journal/progress]

▶ Next up: [specific next task/checkpoint to work on]
─────────────────────────────────────────────────
```

Rebuild TodoWrite items for the **remaining tasks only** (do not re-add completed items). Then jump directly to Step 6 to continue implementation from where the learner left off.

### Mode B: Start a New Phase

If `$ARGUMENTS` contains a phase number, validate that all its prerequisites are complete (read the phase's Prerequisites from `.learning/plan.md`), then use that phase. If prerequisites are not met, show what's blocking it.

Otherwise, read the Phase Overview table from `.learning/plan.md` (just the table, not full phase details). For each Pending phase, check if ALL prerequisite phases are Completed. Collect all unlocked phases.

**If no phases are unlocked:**
Show which phases are In Progress and their remaining checkpoints. Suggest: "Run `/lg:next` to resume your current phase."

**If exactly one phase is unlocked:**
Auto-select it. Proceed to Step 3.

**If multiple phases are unlocked:**
Present the choices to the learner using AskUserQuestion:
"Multiple phases are available. Which would you like to start?"
- [Phase N]: [Name] — [Design/Architecture topic] ([X] checkpoints)
- [Phase M]: [Name] — [Design/Architecture topic] ([X] checkpoints)

Wait for their choice, then proceed to Step 3.

## Step 3: Present the Design/Architecture Topic

**Load context efficiently:**
1. Read the **Learner Profile** section from `.learning/plan.md` (background, goals, preferred language, tech stack)
2. Read ONLY the **selected phase's section** from `.learning/plan.md` (not the full file)
3. Read `.learning/journal.md` entries for the **prerequisite phases only** — this gives compact context on what came before without loading full phase details

**Look up documentation via sub-agent:**
Spawn a research sub-agent using the Task tool (haiku model) with this prompt:
"Look up documentation for [library/framework] version [version] about [this phase's topic]. Use Context7 (resolve-library-id then query-docs) first. If Context7 doesn't cover it, use WebSearch for official docs. Return 3-5 bullet points of key findings with source citations."

If the Task tool is not available, use WebSearch directly. If neither is available, present content based on training knowledge and note: "Based on general knowledge — verify against current docs."

Then compose the Insight and Glossary using the sub-agent's findings. **Present all content in the learner's preferred language** (from Learner Profile), keeping technical terms in English.

**Insight block:**
```
★ Insight ─────────────────────────────────────
[Topic Name]

[2-3 key concepts, explained with analogies from the learner's background where applicable]

[Why this matters for the code we're about to write]

(source: [framework docs / official documentation])
─────────────────────────────────────────────────
```

If documentation is unavailable, state: "Based on general knowledge — verify against current docs."

**Glossary & Extended Reading block** (present immediately after the Insight — see `references/file-conventions.md` for the template format):

Include 3-6 key terms that are central to this phase's topic. Use the sub-agent's documentation findings to populate the "Dive Deeper" links. If no reliable links were found, omit the "Dive Deeper" section.

Encourage the learner to explore: "Feel free to ask about anything — related concepts, how this works in production, alternative approaches, or anything that sparks your curiosity. I'll look up documentation and explain until you're satisfied. When you're ready to move on, just type `/lg:next`."

## Step 4: Set Up Task Tracking

Create TodoWrite items for all implementation tasks in this phase:

```
- [ ] [Design/Architecture topic study]
- [ ] [Implementation task 1]
- [ ] [Implementation task 2]
- [ ] [Design Decision Point 1]
- [ ] [Implementation task 3]
- [ ] [Design Decision Point 2 (if applicable)]
- [ ] [Verification]
- [ ] [Phase review]
```

## Step 5: Update Progress File

Update .learning/progress.md:
- Change the phase status from "Pending" to "In Progress"
- Update "Current phase" in the Overall Progress section

## Step 6: Begin Implementation

Start working through the implementation tasks in order. Follow these rules:

1. **Present educational insights** before writing code (use Insight format). When verifying code examples against current documentation, spawn a research sub-agent (Task tool, haiku model) to keep doc lookups out of the main teaching context.
2. **Pause at design decision points** — Do NOT auto-implement. Use AskUserQuestion or suggest `/lg:decide` to guide the learner through the trade-off analysis.
3. **Mark TodoWrite items as complete** as each task finishes
4. **Update .learning/progress.md** checkpoints as they are completed (both tracks)
5. **Run verification steps** at the end

**Teaching dialogue:** When the learner asks questions during implementation — whether about the current task or tangentially related — act as a patient teacher:
- Answer thoroughly using background-specific analogies (Principle 5) and doc lookups via sub-agent (Principle 11)
- After providing a substantive explanation (not a simple yes/no), append an exploration note to `.learning/journal.md` (see format in `references/file-conventions.md`)
- Follow up: "Does that make sense? Any more questions, or shall we continue with [next task]?"
- Allow the conversation to go as deep as the learner wants — extended Q&A is natural and valuable, this IS the learning process
- Do NOT rush the learner back to the task list; let the dialogue reach a natural conclusion
- Remind the learner: "Whenever you're ready to continue, just type `/lg:next`."

**Skip mode:** If the learner indicates they're already familiar with a task (e.g., "I already know this", "just implement it", "skip this part"):
1. Ask 1-2 quick questions to verify understanding
2. If they answer correctly, implement the code directly (no decision point pause, no insight)
3. Mark the checkpoint as completed with "(skipped — already familiar)"
4. Move on to the next task

The learner can also pass `--skip [task-description]` as part of the `/lg:next` argument to pre-flag tasks they want to delegate.

**Adjustment requests:** If the learner requests a change to the plan during implementation (e.g., "I want to go deeper", "can we skip to a different topic?", "my goals have changed"), acknowledge the request and suggest `/lg:adjust` to make structured changes while preserving the framework's integrity.

When all tasks are done, suggest: "Run `/lg:review` to complete this phase!"
