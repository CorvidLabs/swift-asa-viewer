---
spec: asa-viewer.spec.md
---

## Key Decisions
- Keep networking behind `ASAServiceProtocol` for deterministic view-model tests.
- Preserve main-actor UI state, Pera pagination URLs, strict simulator verification, Codecov, and DocC.

## Files to Read First
- `Models/Asset.swift`, `ASAService.swift`, `ASAViewerViewModel.swift`, `ASAViewer.swift`, and `Tests/ASAViewerTests/`.

## Current Status
The implementation has 19 deterministic model/view-model tests and two tagged read-only live Pera tests. This migration changes governance and documentation only.

## Notes
The live tests use public endpoints without secrets and are reported as passing only after actual simulator execution.
