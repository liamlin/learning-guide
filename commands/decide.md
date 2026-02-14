---
description: Get guided help with a design decision — analyze trade-offs and record your choice
argument-hint: "[description of the decision] (optional)"
---

# Design Decision Guide

Load the `lg:learn-guide` skill using the Skill tool before proceeding.

## Purpose

This command helps the learner think through a design decision that has meaningful trade-offs. It presents options, analyzes consequences, and records the decision and rationale.

## Step 1: Identify the Decision

Read the **Learner Profile** section from `.learning/plan.md` to identify the learner's **preferred language**. Present all decision analysis content (context, trade-offs, analogies, questions) in the preferred language.

**If no `.learning/plan.md` exists:**
Inform: "No learning plan found. Run `/lg:init` to create one."
Stop here.

If `$ARGUMENTS` provides a description, use that as the decision topic.

Otherwise, check .learning/plan.md for the next pending design decision point in the current phase.

If neither provides a clear decision, ask the learner: "What design decision are you facing? Describe the choice you need to make."

## Step 2: Analyze the Context

Read the relevant code files to understand the current implementation context. Identify:
- What code is affected by this decision
- What constraints exist (existing patterns, dependencies, performance requirements)
- What the decision impacts downstream

## Step 3: Present the Trade-off Analysis

**Verify code examples via sub-agent:**
Spawn a research sub-agent using the Task tool (haiku model) with this prompt:
"Look up documentation for [library/framework] version [version]. Verify the correct API for [specific pattern or method being discussed]. Return the current API signature, a brief code example, and the source URL. Use Context7 first (resolve-library-id then query-docs), fall back to WebSearch if needed."

If the Task tool is not available, use WebSearch directly. If neither is available, present content based on training knowledge and note: "Based on general knowledge — verify against current docs."

Use the sub-agent's verified code examples in the trade-off analysis below.

Use this format:

```
## 🔀 Design Decision: [Short Title]

### Context
[1-2 sentences about why this decision matters and what it affects]

### Options

**Option A: [Name]**
```[language]
// Code example showing this approach
```
✅ Pros: [list]
❌ Cons: [list]
📝 When to use: [scenario where this is the best choice]

**Option B: [Name]**
```[language]
// Code example showing this approach
```
✅ Pros: [list]
❌ Cons: [list]
📝 When to use: [scenario where this is the best choice]

**Option C: [Name]** (if applicable)
[same format]

### Familiar Concept Analogy
[Map this decision to a concept the learner already knows, based on their background from .learning/plan.md]

### What Would Production Systems Do?
Spawn a research sub-agent (Task tool, haiku model) to verify production claims:
"Search for how production systems handle [specific pattern]. Find 1-2 real examples with sources. Use WebSearch. Return bullet points with citations."

Use the sub-agent's findings. If a claim cannot be verified, mark it: "(unverified — based on general knowledge)"
```

**Glossary block** (present after the trade-off analysis):
```
📚 Glossary & Extended Reading ─────────────────
• **[Term 1]** — [concise definition relevant to this decision]
• **[Term 2]** — [concise definition relevant to this decision]

🔗 Dive Deeper:
- [Resource title] — [1-sentence description] ([URL if found by sub-agent])
─────────────────────────────────────────────────
```

Include 2-4 key terms that are central to the decision at hand. Use verified links from the sub-agent's findings only.

## Step 4: Let the Learner Decide

Use AskUserQuestion to present the options and let the learner choose. Include a brief reminder: "There's no single right answer — the best choice depends on your specific context."

## Step 5: Guide the Implementation

After the learner chooses:

1. Point to the exact file and location where the code should go
2. Describe what 5-10 lines the learner should write
3. Let them write it (do NOT auto-implement)
4. Review their implementation and provide feedback if needed

## Step 6: Record the Decision

Update .learning/progress.md with:
```
- [x] Design decision: [title] -> Choice: [selected option], Rationale: [learner's explanation]
```

Confirm: "Decision recorded! This will be part of your Phase [N] review."
