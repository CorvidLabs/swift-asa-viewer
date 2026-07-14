---
module: asa-viewer
version: 3
status: active
files:
  - Sources/ASAViewer/ASADetailView.swift
  - Sources/ASAViewer/ASAService.swift
  - Sources/ASAViewer/ASAViewer.swift
  - Sources/ASAViewer/ASAViewerViewModel.swift
  - Sources/ASAViewer/Models/Asset.swift
  - Sources/ASAViewer/Models/AssetList.swift
  - Sources/ASAViewer/Protocols/ASAServiceProtocol.swift
  - Sources/ASAViewer/RemoteImage/RemoteImage+Application.swift
  - Sources/ASAViewer/RemoteImage/RemoteImage.swift
  - Sources/ASAViewer/RemoteImage/RemoteImageViewModel.swift
  - Sources/ASAViewer/Views/ErrorView.swift
db_tables: []
depends_on: []
---

# ASA Viewer

## Purpose

ASA Viewer is a SwiftUI package for browsing Algorand Standard Assets from Pera Wallet's public mainnet API. It owns Pera list/detail requests, Codable asset models, paginated loading and search state, list/detail presentation, retry UI, and in-memory remote-image caching. It does not own Pera, Algorand data, image hosts, persistence, or host-app navigation.

## Public API

| Export | Contract |
|--------|----------|
| `ASAService` | Sendable Pera asset service implementation. |
| `ASAServiceProtocol` | Async list/detail service abstraction. |
| `fetchAssets` | Fetches a page of up to 1,000 assets from the initial or supplied page URL. |
| `fetchAssetDetail` | Fetches one asset by numeric identifier. |
| `LoadingState` | Idle, loading, loaded, or message-bearing error state. |
| `idle` | Initial state before a load begins. |
| `loading` | Active initial-load state. |
| `loaded` | Successful or content-preserving state. |
| `error` | Localized service failure state. |
| `ASAViewer` | Public SwiftUI asset browser. |
| `init` | Public viewer, service, and model construction. |
| `body` | SwiftUI body exposed by the public viewer and image helper. |
| `Asset` | Codable, Hashable, Sendable Pera asset record. |
| `VerificationDetails` | Optional project and social verification metadata. |
| `projectName` | Optional verified project name. |
| `projectURL` | Optional verified project URL. |
| `projectDescription` | Optional verified project description. |
| `discordURL` | Optional Discord URL. |
| `telegramURL` | Optional Telegram URL. |
| `twitterUsername` | Optional Twitter username. |
| `Media` | Optional collectible media record. |
| `type` | Optional media type. |
| `url` | Optional asset or media URL. |
| `ipfsCID` | Optional media IPFS CID. |
| `extensionType` | Optional media extension. |
| `Trait` | Optional collectible display pair. |
| `displayName` | Optional trait display name. |
| `displayValue` | Optional trait display value. |
| `Collectible` | Optional collectible details. |
| `title` | Optional collectible title. |
| `description` | Optional asset, project, or collectible description. |
| `standards` | Optional collectible standards. |
| `thumbnailURL` | Optional thumbnail URL. |
| `thumbnailIPFSCID` | Optional thumbnail CID. |
| `media` | Optional collectible media. |
| `metadata` | Optional collectible string metadata. |
| `traits` | Optional collectible traits. |
| `CodingKeys` | Public snake-case JSON mapping. |
| `assetID` | Numeric Algorand asset identifier. |
| `name` | Asset name. |
| `unitName` | Optional asset unit name. |
| `fractionDecimals` | Asset decimal precision. |
| `totalSupply` | Numeric total supply. |
| `totalSupplyAsStr` | Service-provided total-supply string. |
| `creatorAddress` | Creator address. |
| `logo` | Optional logo URL. |
| `verificationTier` | Pera verification tier. |
| `usdValue` | Optional current USD value. |
| `usdValue24HourAgo` | Optional prior-day USD value. |
| `isCollectible` | Indicates collectible details apply. |
| `verificationDetails` | Optional verification record. |
| `collectible` | Optional collectible record. |
| `circulatingSupply` | Optional circulating supply. |
| `id` | Identifiable value equal to `assetID`. |
| `AssetList` | Page containing continuation links and assets. |
| `next` | Optional next-page URL. |
| `previous` | Optional previous-page URL. |
| `results` | Assets in a list response. |

## Invariants

1. Service requests target Pera's public mainnet API; lists append `limit=1000`, and details use `assets/{id}`.
2. A supplied page URL replaces the initial list URL before the limit is applied.
3. Snake-case fields decode into immutable Sendable model values, and `Asset.id` equals `assetID`.
4. The main-actor view model appends pages, retains the next URL, and records errors without deleting loaded assets.
5. Search is localized and case-insensitive; an empty query returns every loaded asset.
6. The root view loads when empty, offers retry for an empty error, and otherwise preserves the list.
7. Images are cached by URL; nil URL shows `xmark`, and uncached URLs show the caller placeholder while loading.

## Behavioral Examples

### Scenario: Load and paginate
- **Given** an empty view model and a page with a next URL
- **When** `load` succeeds and the final row appears
- **Then** results append, state becomes loaded, and the next URL is requested

### Scenario: Search
- **Given** loaded assets and a nonempty query
- **When** list items are read
- **Then** names are filtered with localized case-insensitive matching

### Scenario: Initial failure
- **Given** no assets and a failed request
- **When** the root view evaluates error state
- **Then** it shows the localized message and async retry action

## Error Cases

| Condition | Behavior |
|-----------|----------|
| URL cannot be formed | Throw the internal endpoint invalid-URL error. |
| Pera transport or decoding fails | Propagate the underlying error. |
| View-model load fails | Store localized error state and log it. |
| Empty viewer is in error | Render retry UI. |
| Image URL is nil | Render `xmark`. |
| Image download fails | The current helper exposes no typed public error state. |

## Dependencies

| Module | Use |
|--------|-----|
| SwiftUI | Viewer, navigation, detail, retry, and image UI. |
| Foundation | URLs, URLSession, and JSON decoding. |
| AppState | Logger and URL-to-UIImage cache. |
| Pera public API | Read-only asset list and detail data. |

## Change Log

| Date | Author | Change |
|------|--------|--------|
| 2026-07-13 | `user:0xLeif` | Documented existing behavior at complete coverage without product-code changes. |
| 2026-07-14 | CHG-0002-document-the-existing-swift-asa-viewer-api-at-complete-specsync-coverage: Document the existing Swift ASA Viewer API at complete SpecSync coverage |
