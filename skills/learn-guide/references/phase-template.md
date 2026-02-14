# Phase Design Template

Use this template when designing individual phases for a learning plan.

## Phase Structure

Each Phase follows this structure:

```markdown
## Phase N: [Descriptive Name]
Prerequisites: [Phase numbers, or "none"]

### Learning Objectives
What the learner will understand after completing this phase. Write as "able to..." statements (adapt to the learner's preferred language — see Principle 8):
- Able to explain how [concept] works
- Able to compare trade-offs between [option A] vs [option B]
- Able to independently implement [specific pattern]

### Design/Architecture Topic: [Topic Name]

**Concepts to study before coding (time estimate):**
- [Concept 1]: Brief explanation
- [Concept 2]: Brief explanation
- [Key insight that connects theory to practice]

**Familiar concept analogy:** [Map to a concept from the learner's existing expertise]

### Key Terms (for Glossary)
Terms to include in the Glossary & Extended Reading block during `/lg:next`:
- **[Term 1]** — [concise definition]
- **[Term 2]** — [concise definition]
- **[Term 3]** — [concise definition]

### Implementation Tasks

Step-by-step implementation. Include:
- Package installations
- File creation with key code snippets
- Configuration changes
- Integration with existing code

### Design Decision Points

**Decision Point 1 — [Short Description]**

Context: [Why this decision matters]

Options:
| Option | Pros | Cons |
|--------|------|------|
| A      | ...  | ...  |
| B      | ...  | ...  |
| C      | ...  | ...  |

Location: `src/path/to/file.ts` — function/method name

What to write: [Description of the 5-10 lines the learner implements]

Trade-off to consider: [The key question they should think about]

### Checkpoints

#### Learning Checkpoints
Adapt descriptions to the learner's preferred language (see Principle 8):
- [ ] Can explain [concept 1]
- [ ] Understands trade-offs of [concept 2]
- [ ] Completed design decision [N] with recorded rationale
- [ ] Can articulate in own words why [approach] was chosen

#### Deliverable Checkpoints
- [ ] [File/module] created and error-free
- [ ] [Endpoint] working as expected (describe expected behavior)
- [ ] [Test] passing
- [ ] [Integration] verified successfully

### Verification
Specific commands or steps to verify the phase is complete:
1. `command to run` — expected output
2. Manual test: [description] — expected behavior
3. Check: [what to verify in database/logs/etc.]
```

## Phase Design Guidelines

### Sequencing Phases

Order phases by dependency and complexity:

1. **Foundation phases first** — Project setup, basic CRUD, database design
2. **Security early** — Authentication/authorization before advanced features
3. **Complexity builds** — Each phase adds one major concept
4. **Production concerns later** — Caching, logging, monitoring after core features
5. **Design/architecture theory interwoven** — Not saved for the end

### Sizing a Phase

Size phases by checkpoint count, matching the learner's chosen depth:
- **Light** (1-2 checkpoints per track): Fast overview, minimal decision points
- **Standard** (3-4 checkpoints per track): Balanced learning with 1-2 design decisions
- **Deep** (5-6 checkpoints per track): Thorough mastery with multiple decision points

A well-sized phase:
- Has 1 major learning objective
- Pairs with 1 Design/Architecture topic
- Contains 1-2 design decision points (Standard/Deep)
- Produces a verifiable deliverable
- Declares its prerequisites explicitly

If a phase feels too large, split it. If too small, combine with the next.

### Designing Decision Points

Good decision points have these qualities:

1. **No obvious right answer** — The "best" choice depends on context
2. **Visible consequences** — The learner will see the impact of their choice
3. **Transferable knowledge** — The trade-off applies beyond this specific code
4. **Appropriate scope** — 5-10 lines of code, not a whole module

Examples of good decision points:
- CASCADE vs SET NULL on foreign key delete
- 404 vs 403 for unauthorized resource access
- LIKE vs full-text search for filtering
- Eager vs lazy loading for relationships
- Per-IP vs per-user rate limiting
- Sync vs async for side effects
- Cache TTL duration and invalidation strategy

Examples of bad decision points (avoid):
- Variable naming (too trivial)
- Choosing between npm packages (not about code design)
- Formatting decisions (not educational)
- Boilerplate structure (no trade-off involved)

### Adapting to Existing Codebases

When the project already has code, adapt phases to include refactoring:

**Pattern: Refactor-as-Learning**

```markdown
### Implementation Tasks

**Step 1: Audit current implementation**
Read `src/existing-file.ts` and identify:
- What pattern is currently used?
- What are the limitations?
- Where does it deviate from best practices?

**Step 2: Learn the target pattern**
★ Insight: [Explain the better pattern and why it's better]

**Step 3: Design the migration**
[Design decision point: how to migrate without breaking existing functionality]

**Step 4: Implement the refactoring**
[Specific code changes with the learner writing the key logic]

**Step 5: Verify backwards compatibility**
[Tests that confirm nothing broke]
```

### Mapping Design/Architecture Topics

Each phase should have a Design/Architecture topic that naturally connects to the implementation work:

| Implementation Work | Natural Design/Architecture Topic |
|--------------------|-----------------------------|
| First CRUD endpoint | REST API design principles |
| Database entities + relations | Schema design, normalization, indexing |
| Authentication | Auth patterns, JWT vs sessions, OAuth |
| Pagination, filtering, sorting | API design, pagination strategies |
| Caching | Cache strategies, invalidation, stampede |
| Rate limiting | Rate limiting algorithms, API protection |
| Background jobs | Message queues, event-driven architecture |
| Logging + monitoring | Observability, 12-factor app |
| Docker + deployment | Container orchestration, CI/CD, scaling |
| Error handling | Fault tolerance, circuit breakers |
| Testing | Testing pyramid, test strategies |
| Database optimization | Query optimization, N+1, connection pooling |
