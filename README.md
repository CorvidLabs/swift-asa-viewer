# ASAViewer

[![macOS](https://github.com/CorvidLabs/swift-asa-viewer/actions/workflows/macOS.yml/badge.svg)](https://github.com/CorvidLabs/swift-asa-viewer/actions/workflows/macOS.yml)
[![Documentation](https://github.com/CorvidLabs/swift-asa-viewer/actions/workflows/docs.yml/badge.svg)](https://github.com/CorvidLabs/swift-asa-viewer/actions/workflows/docs.yml)

SwiftUI components for displaying Algorand Standard Assets (ASAs) using the Pera Wallet API.

## Features

- **Asset List View** - Paginated list with infinite scroll
- **Asset Detail View** - Comprehensive asset information display
- **Search** - Filter assets by name
- **Remote Image Loading** - Async image loading with caching via AppState
- **Navigation Ready** - Built-in NavigationLink support

## Requirements

- iOS 16.0+
- Swift 6.0+
- Xcode 16.0+

## Installation

### Swift Package Manager

Add ASAViewer to your project using Swift Package Manager:

```swift
dependencies: [
    .package(url: "https://github.com/CorvidLabs/swift-asa-viewer.git", from: "1.0.0")
]
```

## Usage

### Basic Usage

```swift
import ASAViewer
import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            ASAViewer()
        }
    }
}
```

### Custom Service (for testing)

The library uses protocol-based dependency injection for testability:

```swift
import ASAViewer

// Create a mock service for testing
actor MockASAService: ASAServiceProtocol {
    func fetchAssets(page: String?) async throws -> AssetList {
        // Return mock data
    }

    func fetchAssetDetail(_ id: Int) async throws -> Asset {
        // Return mock asset
    }
}

// Inject into ViewModel
let viewModel = ASAViewerViewModel(service: MockASAService())
```

### Accessing Asset Data

```swift
import ASAViewer

// Fetch assets directly
let service = ASAService()
let assetList = try await service.fetchAssets()

for asset in assetList.results {
    print("\(asset.name) (ID: \(asset.assetID))")
    print("  Verification: \(asset.verificationTier)")
    print("  USD Value: \(asset.usdValue ?? "N/A")")
}

// Fetch specific asset details
let usdc = try await service.fetchAssetDetail(31566704)
print(usdc.description ?? "No description")
```

## API

### ASAViewer

The main SwiftUI view that displays a paginated list of Algorand assets with search functionality.

### ASAService

Service for fetching asset data from the Pera Wallet API:

- `fetchAssets(page:)` - Fetches paginated list of assets
- `fetchAssetDetail(_:)` - Fetches detailed info for a specific asset

### Asset Model

Comprehensive model including:
- Basic info: `assetID`, `name`, `unitName`, `logo`
- Supply info: `totalSupply`, `circulatingSupply`, `fractionDecimals`
- Verification: `verificationTier`, `verificationDetails`
- Collectible info: `isCollectible`, `collectible`
- Pricing: `usdValue`, `usdValue24HourAgo`

## Documentation

Full API documentation is available at:
https://corvidlabs.github.io/swift-asa-viewer/

## Dependencies

- [AppState](https://github.com/0xLeif/AppState) - State management for image caching

## License

MIT License - Copyright 2025 Corvid Labs
