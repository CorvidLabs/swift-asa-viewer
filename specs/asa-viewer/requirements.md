---
spec: asa-viewer.spec.md
---

## User Stories
- Browse and search Pera mainnet assets and open details.
- Decode partial or complete asset, verification, collectible, media, trait, and page records.
- Substitute a Sendable service for deterministic state, pagination, filtering, retry, and error tests.
- Show placeholders and reuse cached remote images.

## Acceptance Criteria
- All 11 implementation files and every parser-visible export have 100% coverage.
- Eight source-backed requirements trace models, service, state, UI, images, and verification.
- Strict SpecSync scores A/100 without unfinished scaffolds or invented evidence.
- `Sources/` and `Tests/` remain unchanged.

## Constraints
- Preserve public APIs, SwiftLint, simulator selection, live read-only tests, Codecov, and DocC.
- External Pera/image availability is not represented as success unless its test run succeeds.

## Out of Scope
- Product fixes, new networks, persistence, authentication, mutations, or access-control changes.

### REQ-asa-viewer-001

Models SHALL decode Pera snake-case fields into immutable Codable and Sendable values with optional nested verification, collectible, media, trait, value, and supply data.

Acceptance Criteria
- Minimal/full payloads and nested records decode.
- `Asset.id` equals `assetID`; Hashable remains stable.

### REQ-asa-viewer-002

The service SHALL fetch Pera public-mainnet pages and details asynchronously, apply list limit 1,000, decode results, and propagate URL, transport, or decoding failures.

Acceptance Criteria
- Initial, pagination, and `assets/{id}` routes are preserved.
- Tagged live tests validate read-only list/detail access.

### REQ-asa-viewer-003

The main-actor view model SHALL start empty/idle, append pages, retain the next URL, expose loaded or localized error state, and allow retry.

Acceptance Criteria
- Success appends and loads; failure errors without invented assets; retry can recover.

### REQ-asa-viewer-004

Search SHALL filter names using localized case-insensitive matching, return all for an empty query, and invalidate cached results after loading.

Acceptance Criteria
- Case, empty-query, and pagination filtering tests pass.

### REQ-asa-viewer-005

`ASAViewer` SHALL load when empty, show retry for empty error, otherwise render searchable navigation, and paginate when the last row appears.

Acceptance Criteria
- Progress, retry, list, search, navigation, and pagination branches remain source-backed.

### REQ-asa-viewer-006

Detail presentation SHALL show required identity/supply data and only available optional verification and collectible data.

Acceptance Criteria
- Optional sections are not synthesized when records are absent.

### REQ-asa-viewer-007

Remote images SHALL cache by URL, show placeholders while loading, reuse cached images, and show a failure symbol for nil URL.

Acceptance Criteria
- The current helper exposes no invented typed download-error state.

### REQ-asa-viewer-008

Verification SHALL preserve async Sendable services, main-actor state, SwiftLint, simulator build/all 21 tests, live read-only Pera checks, Codecov, and DocC.

Acceptance Criteria
- Live success is recorded only after execution; `Sources/` and `Tests/` remain unchanged.

