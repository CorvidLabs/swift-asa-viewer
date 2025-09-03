import AppState
import SwiftUI

struct RemoteImage<Placeholder: View, Content: View>: View {
    @ObservedObject private var viewModel = RemoteImageViewModel()

    private let url: URL?
    private let placeholder: () -> Placeholder
    private let content: (Image) -> Content

    /** Initializes a RemoteImage view.
     - Parameters:
      - url: The URL of the image to display.
      - placeholder: A closure that returns the placeholder view to display while the image is loading.
      - content: A closure that returns the content view to display when the image is available.
     */
    public init(
        url: URL?,
        placeholder: @escaping () -> Placeholder,
        content: @escaping (Image) -> Content
    ) {
        self.url = url
        self.placeholder = placeholder
        self.content = content

        if let url, viewModel.images[url] == nil {
            viewModel.load(url: url)
        }
    }

    // The body of the RemoteImage view.
    public var body: some View {
        if let url {
            if let image = viewModel.images[url] {
                content(Image(uiImage: image))
            } else {
                placeholder()
                    .onAppear {
                        viewModel.load(url: url)
                    }
            }
        } else {
            Image(systemName: "xmark")
        }
    }
}

extension RemoteImage {
    /** Initializes a RemoteImage view.
     - Parameters:
      - url: The URL string of the image to display.
      - placeholder: A closure that returns the placeholder view to display while the image is loading.
      - content: A closure that returns the content view to display when the image is available.
     */
    public init(
        url: String,
        placeholder: @escaping () -> Placeholder,
        content: @escaping (Image) -> Content
    ) {
        self.init(
            url: URL(string: url),
            placeholder: placeholder,
            content: content
        )
    }

    /** Initializes a RemoteImage view.
     - Parameters:
      - url: The URL string of the image to display.
      - placeholder: A closure that returns the placeholder view to display while the image is loading.
     */
    public init(
        url: String,
        placeholder: @escaping () -> Placeholder
    ) where Content == Image {
        self.init(
            url: URL(string: url),
            placeholder: placeholder,
            content: { $0 }
        )
    }

    /** Initializes a RemoteImage view.
     - Parameters:
      - url: The URL string of the image to display.
      - content: A closure that returns the content view to display when the image is available.
     */
    public init(
        url: String,
        content: @escaping (Image) -> Content
    ) where Placeholder == ProgressView<EmptyView, EmptyView> {
        self.init(
            url: URL(string: url),
            placeholder: ProgressView.init,
            content: content
        )
    }

    /** Initializes a RemoteImage view.
     - Parameters:
      - url: The URL string of the image to display.
     */
    public init(
        url: String
    ) where Placeholder == ProgressView<EmptyView, EmptyView>, Content == Image {
        self.init(
            url: URL(string: url),
            placeholder: ProgressView.init,
            content: { $0 }
        )
    }
}
