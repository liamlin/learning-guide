# Learning Progress — Task Manager API

## Learner Goals
- Build a production-quality REST API with NestJS
- Learn database design and query optimization
- Understand authentication and caching patterns

## Skill Goals
- Independently design and implement REST APIs
- Make informed architectural decisions with clear rationale
- Debug and optimize database queries

## Overall Progress
- Phases completed: 1/7
- Current phase: Phase 2 — Database Layer
- Design decisions made: 1

---

## Phase 1: Project Setup & First Endpoint ✅ Completed

### Learning Checkpoints
- [x] Can explain REST constraints and why APIs use resource-based URLs
- [x] Understands trade-offs between different error response formats
- [x] Design decision: Validation error format -> Choice: Field-level errors object, Rationale: Better DX for frontend consumers who need to highlight specific form fields

### Deliverable Checkpoints
- [x] NestJS project initialized and running on port 3000
- [x] `GET /tasks` returns empty array, `POST /tasks` creates a task
- [x] Invalid POST requests return structured validation errors
- [x] All endpoints verified with curl

---

## Phase 2: Database Layer 🔄 In Progress

### Learning Checkpoints
- [x] Can explain normalization (1NF, 2NF, 3NF) and when to denormalize
- [ ] Understands trade-offs between CASCADE vs SET NULL on foreign key delete
- [ ] Completed design decision on delete behavior with recorded rationale

### Deliverable Checkpoints
- [x] PostgreSQL database connected via TypeORM
- [x] Task entity with proper column types and constraints
- [ ] Category entity with one-to-many relationship to tasks
- [ ] Migration files generated and applied successfully

---

## Phase 3: Authentication ⏳ Pending

### Learning Checkpoints
- [ ] Can explain JWT structure and token-based auth flow
- [ ] Understands trade-offs between JWT vs session-based auth
- [ ] Completed design decision on auth strategy with recorded rationale

### Deliverable Checkpoints
- [ ] User entity with hashed passwords (bcrypt)
- [ ] Login endpoint returns JWT access token
- [ ] Auth guard protects task endpoints
- [ ] Unauthorized requests return 401

---

## Phase 4: CRUD Operations ⏳ Pending

### Learning Checkpoints
- [ ] Can explain pagination strategies and their trade-offs
- [ ] Understands proper use of HTTP status codes for different scenarios
- [ ] Completed design decision on 404 vs 403 for unauthorized resource access

### Deliverable Checkpoints
- [ ] Full CRUD for tasks (GET, POST, PUT, DELETE)
- [ ] Pagination with configurable page size
- [ ] Users can only access their own tasks
