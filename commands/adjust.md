---
description: Adjust your learning plan — change depth, reorder phases, update goals, or modify tasks
argument-hint: "[description of adjustment] (optional)"
---

# Adjust Learning Plan

Load the `lg:learn-guide` skill using the Skill tool before proceeding.

## Step 1: Load Current State

Read `.learning/progress.md` and the **Learner Profile** section from `.learning/plan.md`.

**If no `.learning/plan.md` exists:**
Inform: "No learning plan found. Run `/lg:init` to create one."
Stop here.

Identify the learner's **preferred language** and present all adjustment content in that language.

## Step 2: Identify the Adjustment

If `$ARGUMENTS` provides a description, use that to determine the adjustment type.

Otherwise, use AskUserQuestion to ask the learner what they want to adjust:

Options:
- **Change phase depth** — Switch between Light/Standard/Deep for the current or a future phase
- **Add or remove a phase** — Insert a new phase or remove a future pending phase
- **Update goals** — Goals have shifted — update Learner Profile and optionally regenerate future phases
- **Pause current phase** — Set current phase aside and switch to a different unlocked phase
- **Modify current phase tasks** — Pivot implementation tasks within the current phase while preserving learning objectives

## Step 3: Analyze Impact

Based on the adjustment type, analyze the impact on the existing plan:

### Change Phase Depth
- Read the target phase from `.learning/plan.md`
- Show current checkpoint count vs proposed checkpoint count
- For deeper: describe what additional checkpoints and decision points would be added
- For lighter: describe what would be condensed or removed

### Add or Remove a Phase
- **Add:** Ask the learner to describe the phase topic. Design the new phase following `references/phase-template.md`. Show where it fits in the dependency graph and what prerequisites it should have.
- **Remove:** Confirm the phase is still Pending (cannot remove Completed or In Progress phases). Check if other phases depend on it — if so, show the dependency impact and propose alternatives.

### Update Goals
- Show current goals from Learner Profile
- Ask the learner for updated goals
- Analyze which future Pending phases are still relevant and which might need adjustment
- Propose specific changes to the remaining plan

### Pause Current Phase
- Check which other phases are unlocked (prerequisites met)
- If none are available, explain why and suggest completing current phase first
- If phases are available, present the choices

### Modify Current Phase Tasks
- Read the current phase details from `.learning/plan.md`
- Ask the learner what they want to change about the implementation tasks
- Ensure Learning Objectives remain achievable with the modified tasks
- Preserve any existing Design Decision Points unless the learner explicitly removes them

## Step 4: Confirm with Learner

Present the proposed changes clearly:

```
## 🔄 Proposed Adjustment

### What Changes
- [Specific change 1]
- [Specific change 2]

### What Stays the Same
- [Unchanged element — e.g., "Prerequisites and dependency graph unchanged"]
- [Unchanged element — e.g., "Dual-track checkpoints still required"]

### Impact on Plan
- [Phase(s) affected]
- [Estimated change in total checkpoints, if applicable]
```

Use AskUserQuestion to confirm: "Apply these changes?"

## Step 5: Apply Changes

On confirmation:

1. **Update `.learning/plan.md`** with the approved modifications
2. **Update `.learning/progress.md`** if phase status or checkpoints changed
3. **Append an adjustment entry to `.learning/journal.md`:**

```markdown
## Adjustment: [Description] — [Date]
- Reason: [learner's stated reason]
- Changes: [what was modified in plan.md]
- Impact: [phases affected]
```

## Step 6: Show Updated Status

After applying changes, run the equivalent of `/lg:progress` to show the updated plan state. Suggest next steps:
- If a phase was paused and another started: "Run `/lg:next` to begin the new phase."
- If depth was changed: "Continue working on the current phase with the updated depth."
- If goals were updated: "Review the updated plan, then run `/lg:next` to continue."

## Guardrails

These constraints preserve framework integrity and cannot be bypassed:
- **Dual-track required** — Both Learning and Delivery checkpoints must exist for every phase
- **Prerequisites enforced** — Cannot start a phase whose prerequisites are incomplete
- **History preserved** — Completed phases cannot be removed or un-completed
- **Core methodology intact** — All teaching principles defined in the skill are immutable
