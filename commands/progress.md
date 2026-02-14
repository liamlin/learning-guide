---
description: Check dual-track learning progress (learning milestones + project deliverables)
argument-hint: ""
model: haiku
---

# Check Learning Progress

Read `.learning/progress.md` from the project root.
Also read the **Learner Profile** section from `.learning/plan.md` to identify the **preferred language**. Present the progress summary in that language.

**If no file exists:**
Inform: "No learning plan found. Run `/lg:init` to create one."
Stop here.

**If file exists:**

Present a clear progress summary in this format:

```
## 📊 Learning Progress — [Project Name]

**Overall:** [X]/[Y] phases completed | Current: Phase [N] — [Name]
**Design Decisions:** [Z] recorded

---

### Completed Phases
[For each completed phase, show one-line summary]
✅ Phase 1: [Name] — [Design/Architecture topic]
✅ Phase 2: [Name] — [Design/Architecture topic]

### Current Phase: Phase [N] — [Name]

🎓 Learning Track: [X]/[Y] checkpoints
[List each with status]
- ✅ [completed checkpoint]
- ⬜ [pending checkpoint]

📦 Delivery Track: [X]/[Y] checkpoints
[List each with status]
- ✅ [completed deliverable]
- ⬜ [pending deliverable]

### Available Phases (Prerequisites Met)
🔓 Phase [N]: [Name] — [Design/Architecture topic] ([X] checkpoints)

### Locked Phases
🔒 Phase [N]: [Name] — Blocked by: Phase [X], Phase [Y]
```

After showing the summary, suggest next actions:
- If current phase has pending items: "Continue working on Phase [N], or run `/lg:next` to see the detailed tasks."
- If current phase is complete but not reviewed: "Run `/lg:review` to complete Phase [N] and unlock dependent phases."
- If all phases are complete: "Congratulations! All phases complete. Consider reviewing your .learning/progress.md to reflect on what you've learned."
