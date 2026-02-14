# System Design Topics Catalog

A reference catalog of System Design topics suitable for pairing with backend implementation phases. Each topic includes key concepts, common interview questions, and suggested learning activities.

> **Note:** This catalog focuses on backend/system design topics as an example. For other learning domains (frontend architecture, DevOps, data engineering, mobile development, etc.), the `/lg:init` flow will generate domain-appropriate topics based on the learner's specific goals.

## Tier 1: Fundamentals (Pair with early phases)

### API Design
- REST constraints: stateless, uniform interface, resource-based URLs
- HTTP methods as verbs: GET (idempotent read), POST (create), PUT/PATCH (update), DELETE
- Status codes: 2xx success, 3xx redirect, 4xx client error, 5xx server error
- Idempotency: why PUT is idempotent but POST is not
- Resource naming: plural nouns, nesting for relationships
- HATEOAS: hyperlinks in responses for discoverability

### Database Schema Design
- Normalization: 1NF, 2NF, 3NF — eliminate redundancy
- Denormalization: when to intentionally duplicate for read performance
- Foreign keys and referential integrity
- Index types: B-tree, hash, composite, partial
- When indexes help (reads) vs hurt (writes)
- N+1 query problem and solutions (eager loading, batch queries)

### Authentication & Authorization
- Session-based vs token-based auth
- JWT structure: header.payload.signature
- Access tokens vs refresh tokens pattern
- OAuth 2.0 flows: authorization code, client credentials
- Password hashing: bcrypt, argon2, why never plaintext
- RBAC vs ABAC: role-based vs attribute-based access control
- OWASP top 10 auth vulnerabilities

## Tier 2: Performance (Pair with middle phases)

### Caching
- Cache-aside (lazy loading) pattern
- Write-through vs write-behind patterns
- Cache invalidation strategies: TTL, event-based, version-based
- Cache stampede / thundering herd problem
- Cache layers: application, database query, CDN, browser
- Redis data structures: strings, hashes, sorted sets, pub/sub

### Rate Limiting
- Fixed window: simple but bursty at window boundaries
- Sliding window: smoother but more memory
- Token bucket: allows controlled bursts
- Leaky bucket: smooth, constant output rate
- Distributed rate limiting with Redis
- Rate limit dimensions: IP, user, API key, endpoint

### Query Optimization
- EXPLAIN ANALYZE: reading query plans
- Index usage and selection
- JOIN strategies: nested loop, hash join, merge join
- Connection pooling: why and how (pgBouncer)
- Read replicas for read-heavy workloads
- Materialized views for expensive aggregations

## Tier 3: Production (Pair with later phases)

### Observability
- Three pillars: logs, metrics, traces
- Structured logging: JSON with consistent fields
- Log levels: debug, info, warn, error — when to use each
- Distributed tracing: correlation IDs across services
- Health checks: liveness vs readiness probes
- Alerting: what to alert on, alert fatigue

### The 12-Factor App
1. Codebase: one codebase, many deploys
2. Dependencies: explicitly declare and isolate
3. Config: store in environment variables
4. Backing services: treat as attached resources
5. Build/release/run: strictly separate stages
6. Processes: stateless, share-nothing
7. Port binding: export services via port
8. Concurrency: scale via process model
9. Disposability: fast startup, graceful shutdown
10. Dev/prod parity: keep environments similar
11. Logs: treat as event streams
12. Admin processes: run as one-off processes

### Background Jobs & Message Queues
- Synchronous vs asynchronous processing
- Queue patterns: work queue, pub/sub, routing
- Delivery guarantees: at-most-once, at-least-once, exactly-once
- Dead letter queues: handling permanent failures
- Backpressure: when producers outpace consumers
- Idempotent consumers: handling duplicate messages
- CRON jobs vs event-driven triggers

## Tier 4: Scaling (Pair with advanced phases or theory sessions)

### Horizontal vs Vertical Scaling
- Vertical: bigger machine, simpler, has ceiling
- Horizontal: more machines, requires statelessness
- Stateless services: why JWT enables horizontal scaling
- Session affinity (sticky sessions): when needed, trade-offs
- Auto-scaling: metrics-based (CPU, request count, queue depth)

### Load Balancing
- Algorithms: round-robin, least connections, IP hash, weighted
- Layer 4 (TCP) vs Layer 7 (HTTP) load balancing
- Health checks at the LB level
- SSL termination at load balancer
- Geographic load balancing (DNS-based)

### Database Scaling
- Read replicas: write to primary, read from replicas
- Replication lag and eventual consistency
- Connection pooling at scale
- Sharding: horizontal partitioning by shard key
- Shard key selection: high cardinality, even distribution
- Cross-shard queries: why they're expensive
- CAP theorem: Consistency, Availability, Partition tolerance

### Event-Driven Architecture
- Event sourcing: store events, derive state
- CQRS: separate read and write models
- Saga pattern: distributed transactions
- Event bus vs message queue
- Eventual consistency and compensating transactions
- Domain events vs integration events

## How to Use This Catalog

### During /lg:init

When analyzing a project and user goals, match implementation tasks to System Design topics:

1. List all planned implementation tasks
2. For each task, find the closest System Design topic from this catalog
3. Ensure topics progress from Tier 1 → Tier 4 across phases
4. Each phase should have exactly ONE primary System Design topic

### During Phase Execution

When presenting a System Design topic:

1. Start with the "Frontend analogy" to ground the concept
2. Present 2-3 key concepts from the topic (not the entire list)
3. Use the Insight format for educational content
4. Connect the theory to the specific code being written
5. Add relevant concepts as Learning Checkpoints

### For Design Decision Points

System Design topics naturally generate decision points:

- Caching → "What TTL should we use? What invalidation strategy?"
- Auth → "JWT vs sessions? 404 vs 403 for unauthorized?"
- Database → "CASCADE vs SET NULL? Which columns to index?"
- Scaling → "Sync vs async? Background job vs inline processing?"
