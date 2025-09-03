import AppState
import SwiftUI

@MainActor
class RemoteImageViewModel: ObservableObject {
    @AppState(\.images) private(set) var images: [URL: UIImage]

    func load(url: URL?) {
        guard let url = url else { return }

        if images[url] == nil {
            Task {
                let (data, _) = try await URLSession.shared.data(from: url)

                let image = UIImage(data: data)

                await MainActor.run {
                    images[url] = image
                }
            }
        }
    }
}
