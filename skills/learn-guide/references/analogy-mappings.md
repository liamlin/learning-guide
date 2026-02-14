# Background-Specific Analogy Mappings

These mappings are starting points for Principle 5. Always adapt to the specific learner's background as captured in `.learning/plan.md` under "Learner Profile".

## Frontend Engineer Learning Backend

| Backend Concept | Frontend Analogy |
|----------------|------------------|
| NestJS Module | React Context Provider |
| NestJS Controller | Next.js API Route handler |
| NestJS Service | Custom React Hook (business logic) |
| NestJS Guard | Route middleware / Auth wrapper |
| NestJS Pipe | Zod/Yup validation schema |
| Cache TTL | stale-while-revalidate in SWR/React Query |
| Rate Limiting | Debounce/throttle on user input |
| Message Queue | Web Worker for background processing |
| Database Transaction | Batched state updates (unstable_batchedUpdates) |
| Middleware Pipeline | Express/Koa middleware ≈ React HOC chain |

## Backend Engineer Learning Frontend

| Frontend Concept | Backend Analogy |
|-----------------|-----------------|
| React Component | Controller action that returns a view |
| useState | In-memory session state |
| useEffect | Middleware / lifecycle hooks |
| Context API | Dependency injection container |
| React Router | Server-side routing table |
| Virtual DOM | Diff-based database migration |
| Component Props | Function parameters / DTO |
| Event Handlers | Controller action handlers |

## Other Common Transitions

**Data Scientist Learning Web Development:**
- API Endpoint = Function that takes input and returns output (like a model.predict())
- Database Schema = DataFrame column definitions
- Authentication = Access control to notebooks/data
- REST API = Similar to calling a model inference API

**Mobile Developer Learning Backend:**
- API Endpoint = ViewController action
- Middleware = App delegate lifecycle methods
- ORM = Core Data / Realm model layer
- WebSocket = Push notification channel

## When No Mapping Exists

If the learner's background doesn't match any common transition above:
1. Ask the learner: "What concepts from your field could we use as analogies?"
2. Use real-world non-code analogies when technical mappings aren't available
3. Build a custom mapping table during `/lg:init` and reference it throughout the guide
