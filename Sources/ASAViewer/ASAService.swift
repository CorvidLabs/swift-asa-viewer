import Foundation

public struct ASAService: ASAServiceProtocol, Sendable {
    enum ASAEndpoint {
        enum ASAEndpointError: Error {
            case invalidURL(String)
        }

        case list
        case detail(Int)

        static let path: String = "https://mainnet.api.perawallet.app/v1/public/"

        var endpoint: String {
            switch self {
            case .list:
                return "assets"
            case .detail(let id):
                return "assets/\(id)"
            }
        }

        var url: URL? {
            URL(string: ASAEndpoint.path + endpoint)
        }
    }

    public init() {}

    public func fetchAssets(page: String? = nil) async throws -> AssetList {
        let assetsURL: URL

        if let page, let pageURL = URL(string: page) {
            assetsURL = pageURL
        } else if let url = ASAEndpoint.list.url {
            assetsURL = url
        } else {
            throw ASAEndpoint.ASAEndpointError.invalidURL(ASAEndpoint.list.url?.absoluteString ?? "unknown")
        }

        guard var components = URLComponents(url: assetsURL, resolvingAgainstBaseURL: false) else {
            throw ASAEndpoint.ASAEndpointError.invalidURL(assetsURL.absoluteString)
        }

        components.queryItems = [
            URLQueryItem(name: "limit", value: "1000")
        ]

        guard let url = components.url else {
            throw ASAEndpoint.ASAEndpointError.invalidURL(components.string ?? "unknown")
        }

        let (data, _) = try await URLSession.shared.data(from: url)

        do {
            let list = try JSONDecoder().decode(AssetList.self, from: data)
            return list
        } catch {
            throw error
        }
    }

    public func fetchAssetDetail(_ id: Int) async throws -> Asset {
        guard let url = ASAEndpoint.detail(id).url else {
            throw ASAEndpoint.ASAEndpointError.invalidURL(ASAEndpoint.detail(id).url?.absoluteString ?? "unknown(\(id))")
        }

        let (data, _) = try await URLSession.shared.data(from: url)

        return try JSONDecoder().decode(Asset.self, from: data)
    }
}
