import AppState
import SwiftUI

public struct ASAViewer: View {
    @ObservedObject private var viewModel: ASAViewerViewModel = ASAViewerViewModel()

    public var body: some View {
        Group {
            if viewModel.assets.isEmpty {
                ProgressView()
                    .task {
                        await viewModel.load()
                    }
            } else {
                List(viewModel.listItems) { asset in
                    NavigationLink(value: asset) {
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

                    if
                        viewModel.assets.isEmpty == false,
                        viewModel.assets.last?.assetID == asset.assetID
                    {
                        ProgressView()
                            .task {
                                await viewModel.load()
                            }
                    }
                }
                .searchable(text: $viewModel.searchQuery)
            }
        }
        .navigationDestination(for: Asset.self) { asset in
            ASADetailView(asset: asset)
        }
        .navigationTitle(Text("ASA"))
    }
}

#Preview {
    let _ = Application.logging(isEnabled: true)

    NavigationStack {
        ASAViewer()
    }
}
