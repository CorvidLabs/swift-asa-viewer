import AppState
import SwiftUI

public struct ASAViewer: View {
    @ObservedObject private var viewModel: ASAViewerViewModel = ASAViewerViewModel()

    public init() {}

    public var body: some View {
        Group {
            switch viewModel.loadingState {
            case .idle, .loading where viewModel.assets.isEmpty:
                ProgressView()
                    .task {
                        await viewModel.load()
                    }
            case .error(let message) where viewModel.assets.isEmpty:
                ErrorView(message: message, retry: viewModel.load)
            default:
                assetListView
            }
        }
        .navigationDestination(for: Asset.self) { asset in
            ASADetailView(asset: asset)
        }
        .navigationTitle(Text("ASA"))
    }

    private var assetListView: some View {
        List(viewModel.listItems) { asset in
            NavigationLink(value: asset) {
                AssetRowView(asset: asset)
            }
            .onAppear {
                if asset.assetID == viewModel.assets.last?.assetID {
                    Task { await viewModel.load() }
                }
            }
        }
        .searchable(text: $viewModel.searchQuery)
    }
}

private struct AssetRowView: View {
    let asset: Asset

    var body: some View {
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
    }
}

#Preview {
    NavigationStack {
        ASAViewer()
    }
}
