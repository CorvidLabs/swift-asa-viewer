import AppState
import SwiftUI

/// Represents the loading state of the asset list
public enum LoadingState: Equatable, Sendable {
    case idle
    case loading
    case loaded
    case error(String)
}

@MainActor
class ASAViewerViewModel: ObservableObject {
    private let service: any ASAServiceProtocol

    @Published private(set) var assets: [Asset] = []
    @Published private(set) var loadingState: LoadingState = .idle
    @Published var searchQuery: String = ""

    private var cachedFilteredItems: [Asset] = []
    private var lastSearchQuery: String = ""

    var listItems: [Asset] {
        if searchQuery == lastSearchQuery && !cachedFilteredItems.isEmpty {
            return cachedFilteredItems
        }
        lastSearchQuery = searchQuery
        if searchQuery.isEmpty {
            cachedFilteredItems = assets
        } else {
            cachedFilteredItems = assets.filter { asset in
                asset.name.localizedCaseInsensitiveContains(searchQuery)
            }
        }
        return cachedFilteredItems
    }

    private var next: String?

    init(service: any ASAServiceProtocol = ASAService()) {
        self.service = service
    }

    func load() async {
        loadingState = assets.isEmpty ? .loading : .loaded
        do {
            let assetList = try await service.fetchAssets(page: next)
            assets.append(contentsOf: assetList.results)
            next = assetList.next
            cachedFilteredItems = []
            loadingState = .loaded
        } catch {
            loadingState = .error(error.localizedDescription)
            Application.logger.error("\(error.localizedDescription)")
        }
    }
}
