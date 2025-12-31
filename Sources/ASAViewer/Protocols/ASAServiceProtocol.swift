import Foundation

/// Protocol defining the interface for fetching Algorand Standard Assets.
public protocol ASAServiceProtocol: Sendable {
    /// Fetches a paginated list of assets.
    /// - Parameter page: Optional URL string for the next page of results.
    /// - Returns: An `AssetList` containing the assets and pagination info.
    func fetchAssets(page: String?) async throws -> AssetList

    /// Fetches details for a specific asset.
    /// - Parameter id: The asset ID to fetch.
    /// - Returns: The `Asset` with the specified ID.
    func fetchAssetDetail(_ id: Int) async throws -> Asset
}
