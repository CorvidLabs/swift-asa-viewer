@testable import ASAViewer
import Foundation

actor MockASAService: ASAServiceProtocol {
    var assetsToReturn: AssetList?
    var assetDetailToReturn: Asset?
    var errorToThrow: Error?
    var fetchAssetsCallCount = 0
    var fetchDetailCallCount = 0
    var lastRequestedPage: String?
    var lastRequestedAssetID: Int?

    func setAssetsToReturn(_ assets: AssetList) {
        self.assetsToReturn = assets
    }

    func setAssetDetailToReturn(_ asset: Asset) {
        self.assetDetailToReturn = asset
    }

    func setError(_ error: Error) {
        self.errorToThrow = error
    }

    func reset() {
        assetsToReturn = nil
        assetDetailToReturn = nil
        errorToThrow = nil
        fetchAssetsCallCount = 0
        fetchDetailCallCount = 0
        lastRequestedPage = nil
        lastRequestedAssetID = nil
    }

    func fetchAssets(page: String?) async throws -> AssetList {
        fetchAssetsCallCount += 1
        lastRequestedPage = page

        if let error = errorToThrow {
            throw error
        }

        return assetsToReturn ?? AssetList(results: [])
    }

    func fetchAssetDetail(_ id: Int) async throws -> Asset {
        fetchDetailCallCount += 1
        lastRequestedAssetID = id

        if let error = errorToThrow {
            throw error
        }

        guard let asset = assetDetailToReturn else {
            throw MockASAServiceError.noAssetConfigured
        }

        return asset
    }

    enum MockASAServiceError: Error {
        case noAssetConfigured
    }
}
