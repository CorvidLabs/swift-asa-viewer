import SwiftUI

private class ASAViewerViewModel: ObservableObject {
    private let service: ASAService = ASAService()

    var next: String?
    @Published var assets: [Asset] = []

    @MainActor
    func load() async throws {
        let assetList = try await service.fetchAssets(page: next)

        // This needs to be on the main actor! (UI Update)
        assets.append(contentsOf: assetList.results)
        next = assetList.next
    }
}

public struct ASAViewer: View {
    @ObservedObject private var viewModel: ASAViewerViewModel = ASAViewerViewModel()

    public var body: some View {
        List(viewModel.assets) { asset in
            HStack {
                Group {
                    if let logoURL = asset.logo {
                        RemoteImage(url: URL(string: logoURL), placeholder: {
                            ProgressView()
                        }, content: { image in
                            image.resizable()
                                .aspectRatio(contentMode: .fit)
                        })

                    } else {
                        Image(systemName: "questionmark")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                    }
                }
                .frame(width: 32)

                Text(asset.name)
            }

            if
                viewModel.assets.isEmpty == false,
                viewModel.assets.last?.assetID == asset.assetID
            {
                ProgressView()
                    .task {
                        try? await viewModel.load()
                    }
            }
        }
        .task {
            try? await viewModel.load()
        }
    }
}

#Preview {
    ASAViewer()
}
