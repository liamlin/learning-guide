---
description: Review a completed phase — confirm knowledge and record design decisions
argument-hint: "[phase-number] (optional, defaults to current phase)"
---

# Phase Review

Load the `lg:learn-guide` skill using the Skill tool before proceeding.

## Step 1: Identify Phase to Review

Read `.learning/progress.md` from the project root.
Read the **Learner Profile** section from `.learning/plan.md` to identify the learner's **preferred language**. Present all review content (questions, summaries, explanations) in the preferred language.

If `$ARGUMENTS` contains a phase number, review that phase.
Otherwise, find the current "In Progress" phase.

Read the phase details from `.learning/plan.md`.

## Step 2: Verify Deliverables

Spawn a checkpoint verifier sub-agent using the Task tool (haiku model) with this prompt:
"Verify these deliverable checkpoints for [Phase name]. For each checkpoint, check if the expected files, code patterns, or test results exist. Return a pass/fail report.

Checkpoints to verify:
[list all deliverable checkpoints from the phase]

Use Glob to check file existence, Grep to check code patterns, and Bash to run any verification commands."

If the Task tool is not available, verify the checkpoints directly using Glob, Grep, and Bash.

Review the sub-agent's report. For any failed deliverable, inform the learner and suggest fixes. Do NOT mark the phase as complete if deliverables are missing.

## Step 3: Knowledge Check

Present the learning checkpoints as questions. Use AskUserQuestion to engage the learner:

**For each conceptual checkpoint:**
Ask the learner to explain the concept in their own words. For example:
- "Can you explain why we chose [approach A] over [approach B]?"
- "What would happen if we used [alternative] instead?"
- "In what scenario would [the other option] be better?"

**CRITICAL: Always wait for the learner's actual response.** Do NOT infer understanding from prior conversation or design decisions made earlier. The learner must articulate the concept themselves — that is the learning moment. If a context compaction occurs while waiting for a response, re-present the unanswered questions and wait again.

This is NOT a test — it's a reflection exercise. If the learner struggles, provide a brief explanation and discuss it with them before marking the checkpoint as completed.

**For checkpoints marked "(skipped — already familiar)":**
Do a brief confirmation rather than a full explanation request. Example: "You skipped [X] — can you confirm in one sentence why [approach] was chosen?" If they can, move on. The review should be lighter for skipped items.

## Step 4: Record Design Decisions

For each design decision point in this phase:

1. Confirm which option the learner chose
2. Ask them to articulate the rationale (or help them formulate it)
3. Record in .learning/progress.md:
   ```
   - [x] Design decision: [description] -> Choice: [option], Rationale: [why]
   ```

## Step 5: Exploration Review

Read exploration notes for this phase from `.learning/journal.md` — look for entries matching `### Exploration:` that were appended after this phase started.

If exploration notes exist, present them:

```
### 💡 Discoveries from Exploration
During this phase, you explored beyond the syllabus:
- [Topic]: [Key takeaway]
- [Topic]: [Key takeaway]
```

Ask the learner: "Any of these topics you'd like to explore further in a future phase?" If yes, note them in "Open Questions" for the journal entry.

If no exploration notes exist, skip this step.

## Step 6: Phase Summary

Present a summary:

```
## Phase [N] Review Summary

### What You Learned (Curriculum)
- [Key concept 1 from the design/architecture topic]
- [Key concept 2]
- [Design decision insight]

### What You Discovered (Exploration)
- [Topic from Q&A]: [key takeaway]
(omit this section if no exploration notes exist)

### What You Built
- [Deliverable 1]
- [Deliverable 2]

### Design Decisions Made
1. [Decision]: Chose [X] because [rationale]
2. [Decision]: Chose [Y] because [rationale]
```

## Step 7: Update Progress

Update .learning/progress.md:
- Mark ALL checkpoints (both tracks) as completed
- Change phase status to "Completed"
- Update "Phases completed" counter in Overall Progress
- Set "Current phase" to the newly unlocked phase (if exactly one is unlocked), or clear it to "None — multiple phases available" (if several are unlocked). Step 8 will present the choices.

### Write Journal Entry

After updating `.learning/progress.md`, append a phase summary to `.learning/journal.md`:

```markdown
## Phase [N]: [Name] — Completed

### Key Concepts Learned
- [Key concept 1 from the phase's design/architecture topic]
- [Key concept 2]

### Discoveries from Exploration
- [Topic]: [key takeaway from Q&A]
(omit this section if no exploration notes exist for this phase)

### Decisions Made
1. [Decision title]: Chose [option] because [learner's rationale]

### Code Changes
- Created: [list new files]
- Modified: [list modified files]

### Open Questions
- [Anything to revisit in later phases, or "None"]
```

Target 15-25 lines. This journal entry is what future sessions and phases will load instead of re-reading the full phase details.

## Step 8: Transition

If there are more phases:
Check which phases are now unlocked by this completion (their prerequisites are all met). Show:
"Phase [N] complete! The following phases are now available:"
- [List newly unlocked phases with names and topics]
"Run `/lg:next` to continue."

If only one phase is unlocked, you can simplify: "Phase [N] complete! Phase [M]: [Name] is now unlocked. Run `/lg:next` to continue."

If all phases are complete, present a comprehensive learning journey recap:

```
🎓 Learning Journey Complete

### Curriculum Mastery
- [Summary of all planned topics covered across all phases]

### Discoveries from Exploration
- [Aggregated highlights from exploration notes across all phases]

### Design Decisions Portfolio
- [All design decisions made with rationales, across all phases]

### What You Built
- [All deliverables across all phases]
```

Suggest: "Your complete learning journey is recorded in `.learning/journal.md`. You can review it anytime to recall what you learned."
