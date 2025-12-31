@testable import ASAViewer
import Testing

// MARK: - Integration Tests
// These tests hit the live Pera Wallet API and require network connectivity.
// They verify that the service correctly communicates with the real API.

extension Tag {
    @Tag static var integration: Self
}

@Test(.tags(.integration))
func asaServiceFetchesList() async throws {
    let service = ASAService()
    let assets = try await service.fetchAssets()

    #expect(!assets.results.isEmpty)
}

@Test(.tags(.integration))
func asaServiceFetchesDetail() async throws {
    let service = ASAService()
    let usdcAssetID = 31566704

    let assetDetail = try await service.fetchAssetDetail(usdcAssetID)

    #expect(assetDetail.assetID == usdcAssetID)
    #expect(assetDetail.name == "USDC")
}
