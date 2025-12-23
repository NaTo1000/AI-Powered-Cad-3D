# AI-Powered-Cad-3D

Enterprise-ready blueprint for an AI-assisted 3D CAD platform with clear domain boundaries, scalable services, and a modern developer experience.

## Vision
- Accelerate 3D design with AI-driven feature suggestions, constraint solving, and generative geometry.
- Support collaborative workflows (design reviews, annotation, versioning) with auditable change history.
- Deliver a modular system that can scale from single-tenant pilots to multi-tenant production.

## Architecture at a glance
- **Experience**: Web/desktop UI built on WebGL/Three.js for interactive modeling and real-time previews.
- **Collaboration & API Gateway**: GraphQL/REST gateway for client access, session management, and auth (OIDC/JWT).
- **Design Core Services**: Domain services for sketching, constraints, parametric operations, and assembly management.
- **AI Services**: Model-serving endpoints for generative geometry, feature ranking, and auto-dimensioning (batch & realtime).
- **Data Plane**:
  - PostgreSQL (metadata)
  - Object storage/S3 (assets)
  - Redis (caching)
  - Event bus: Kafka for durable ordered streams; NATS for low-latency fan-out
- **Domain boundaries**: Domain-Driven Design (DDD) bounded contexts isolate Modeling, Projects, Identity, and AI concerns.
- **Orchestration & Ops**: Kubernetes for deployments, OpenTelemetry for tracing/metrics/logs, Argo/Temporal for long-running jobs.

## Core domains & responsibilities
| Domain | Responsibility |
| --- | --- |
| **Identity & Access** | OIDC/JWT auth, RBAC/ABAC policies, tenant scoping |
| **Projects & Versions** | Project lifecycle, immutable versions, branching/merging, approvals |
| **Modeling** | Sketching, constraints, parametric features, assembly relationships |
| **AI Suggestions** | Feature ranking, generative proposals, safety/guardrails, human-in-the-loop feedback |
| **Rendering & Export** | Progressive loading, LOD strategies, export to STEP/OBJ/GLTF |
| **Observability** | Usage analytics, performance traces, quality signals for AI models |

## Example service interaction flow
1. Client authenticates via gateway → receives scoped JWT.
2. Modeling requests hit the gateway → routed to Modeling/Constraint services.
3. Changes emit domain events → persisted in event store and published on Kafka/NATS.
4. AI service consumes events → produces ranked suggestions → pushed to clients via WebSocket/SSE.
5. Long-running exports handled via workflows (Argo/Temporal) with status callbacks.

## Suggested tech stack (opinionated, replace as needed)
- **Frontend**: React + Three.js (or Babylon.js), Zustand/Redux for state, Vite for builds.
- **Services**:
  - TypeScript/Node.js for gateway & orchestration
  - Python for AI inference
  - Rust for safety-critical geometry kernels
  - Go for scalable concurrency and service ergonomics
- **Data**: PostgreSQL + PostGIS (spatial), Redis, MinIO/S3, Kafka/NATS.
- **Infra**: Kubernetes + Helm, cert-manager, OpenTelemetry, Prometheus/Grafana, Vault for secrets.

## Repository layout proposal
```
apps/
  web/                # UI client
  desktop/            # Optional Electron shell
services/
  gateway/            # API gateway (REST/GraphQL)
  modeling/           # CAD domain services
  ai-suggestions/     # Model serving & ranking
  export/             # Format conversions & jobs
libs/                 # Shared libraries (types, telemetry, auth)
infra/                # IaC (Helm/Terraform), CI/CD, observability
docs/                 # ADRs, runbooks, onboarding
```

## Sample API shapes
```http
POST /api/v1/projects/{projectId}/designs
Authorization: Bearer <jwt>
{
  "name": "gearbox v2",
  "template": "blank",
  "metadata": { "units": "mm" }
}
```

```http
POST /api/v1/designs/{designId}/ai/suggestions
{
  "contextFeatures": ["extrude", "fillet"],
  "goal": "reduce weight by 10%"
}
```

## Quality, safety, and ops guardrails
- Enforce **Domain-Driven Design (DDD)** boundaries per service; share only stable contracts via protobuf/JSON schemas.
- Apply **circuit breakers, retries, and idempotency keys** on write paths.
- **RBAC/ABAC** at the gateway and per service, with audit trails for model suggestions and user overrides.
- **Observability-first**: traces for user actions, AI decisions, and geometry operations; SLOs on latency and error budgets.

## Next steps
- Scaffold the proposed folder layout with CI skeletons.
- Define API contracts (OpenAPI/GraphQL schemas) for gateway and domain services.
- Ship a thin vertical slice: create design → apply constraint → receive AI suggestion → persist version.
