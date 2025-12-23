# AI-Powered-Cad-3D

AI-Powered-Cad-3D is intended to be a professional-grade, AI-assisted 3D CAD tool. The repository currently contains documentation only; use the guidance below to build a safe, reliable, and accurate implementation.

## Status
- No application code has been committed yet.
- The priorities are accuracy, safety, and repeatability suitable for professional use.

## Objectives
- AI-assisted 3D modeling while keeping deterministic, verifiable outputs.
- Modern CAD UX with reliable import/export for standard formats.
- Built-in evaluation harnesses and regression tests to prevent accuracy drift.

## Quality and Safety Baseline
- **Validation-first**: every geometry operation should be validated (units, tolerances, solvability) before saving or exporting.
- **Determinism**: AI suggestions must be reproducible given the same inputs; capture seeds/configs for auditability.
- **Testing**: unit and integration tests for geometry kernels, exporters, and AI prompts/models; golden files for key outputs.
- **Security**: never commit secrets; isolate model/data access; run dependency and security scans in CI.
- **Reliability**: enforce linting, formatting, and CI gates (tests + CodeQL) before merges.

## Getting Started (current state)
1) Clone the repo.
2) Align on tech stack and scaffold the first implementation (frontend, backend, and CAD kernel bindings).
3) Add CI with lint/test/security checks before committing feature code.

## Proposed Next Steps
1) Create the initial project structure (e.g., client, server, shared kernel bindings).
2) Add automated quality gates (lint, tests, CodeQL, container/image scan).
3) Implement a minimal vertical slice: load a primitive, apply an AI-driven modification, export, and validate the result.
4) Document supported workflows, inputs, and safety constraints as features land.
