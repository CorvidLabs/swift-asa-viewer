import Testing
@testable import ASAViewer

@Test func asaViewerList() async throws {
    // 1. Initialize the service that makes the network call.
    let service = ASAService()

    // 2. Fetch the list of assets.
    // The 'try await' keyword handles the asynchronous network request and any potential errors.
    let assets = try await service.fetchAssets()

    // 3. Verify the result.
    // We expect that the returned array of assets is not empty.
    #expect(!assets.results.isEmpty)
}

@Test func asaViewerDetail() async throws {
    // 1. Initialize the service.
    let service = ASAService()

    // 2. Define a known, valid Asset ID to test against.
    // In this case, we're using the asset ID for USDC on Algorand.
    let usdcAssetID = 31566704

    // 3. Fetch the detail for that specific asset.
    let assetDetail = try await service.fetchAssetDetail(usdcAssetID)

    // 4. Verify the result.
    // We expect the 'assetId' of the fetched object to be the same as the one we requested.
    #expect(assetDetail.assetID == usdcAssetID)
}

@Test func allASA() async throws {
    let service: ASAService = ASAService()
    var isFetching: Bool = true
    var next: String? = nil

    while isFetching {
        do {
            print("Next: \(String(describing: next))")
            let assetList = try await service.fetchAssets(page: next)

            next = assetList.next

            if next == nil {
                isFetching = false
            }
        } catch {
            isFetching = false

        }
    }
}
