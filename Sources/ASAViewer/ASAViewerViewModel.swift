import AppState
import SwiftUI

@MainActor
class ASAViewerViewModel: ObservableObject {
    private let service: ASAService = ASAService()

    @Published private(set) var assets: [Asset] = []
    @Published var searchQuery: String = ""

    var listItems: [Asset] {
        if searchQuery.isEmpty {
            return assets
        } else {
            let searchText = searchQuery.lowercased()

            return assets.filter { asset in
                asset.name.lowercased().contains(searchText)
            }
        }
    }

    private var next: String?

    func load() async {
        do {
            let assetList = try await service.fetchAssets(page: next)

            // This needs to be on the main actor! (UI Update)
            assets.append(contentsOf: assetList.results)
            next = assetList.next
        } catch {
            Application.logger.error("\(error.localizedDescription)")
        }
    }
}
