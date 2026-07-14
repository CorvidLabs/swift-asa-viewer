---
spec: asa-viewer.spec.md
---

## Automated Testing
| Test File | Evidence |
|-----------|----------|
| `AssetModelTests.swift` | 7 model, nested-data, Hashable, Identifiable, and page tests. |
| `ASAViewerViewModelTests.swift` | 12 state, load, pagination, filter, error, and retry tests. |
| `ASAViewerIntegrationTests.swift` | 2 tagged read-only live Pera tests. |
| `Mocks/MockASAService.swift` | Deterministic pages, details, errors, resets, and page capture. |

## Manual Testing
- Review exact-head Trust/CodeQL, preserved Codecov, and DocC workflows.

## Edge Cases & Boundary Conditions
| Scenario | Expected Behavior |
|----------|-------------------|
| Optional JSON fields are absent | Decode nil while preserving required fields. |
| Search case differs | Match case-insensitively. |
| Query is empty | Return all loaded assets. |
| Next page loads | Append and retain prior assets. |
| Pera is unavailable | Live tests fail truthfully. |
