import Foundation

struct ASAService {
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

    func fetchAssets(page: String? = nil) async throws -> AssetList {
        let assetsURL: URL

        if
            let page,
            let pageURL = URL(string: page)
        {
            assetsURL = pageURL
        } else if let url = ASAEndpoint.list.url {
            assetsURL = url
        } else {
            throw ASAEndpoint.ASAEndpointError.invalidURL(ASAEndpoint.list.url?.absoluteString ?? "unknown")
        }

        let (data, _) = try await URLSession.shared.data(from: assetsURL)

        return try JSONDecoder().decode(AssetList.self, from: data)
    }

    func fetchAssetDetail(_ id: Int) async throws -> Asset {
        guard let url = ASAEndpoint.detail(id).url else {
            throw ASAEndpoint.ASAEndpointError.invalidURL(ASAEndpoint.detail(id).url?.absoluteString ?? "unknown(\(id))")
        }

        let (data, _) = try await URLSession.shared.data(from: url)

        return try JSONDecoder().decode(Asset.self, from: data)
    }
}
