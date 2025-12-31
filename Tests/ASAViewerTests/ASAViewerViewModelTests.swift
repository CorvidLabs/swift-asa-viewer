@testable import ASAViewer
import Foundation
import Testing

@Test
@MainActor
func viewModelStartsEmpty() async {
    let mockService = MockASAService()
    let viewModel = ASAViewerViewModel(service: mockService)

    #expect(viewModel.assets.isEmpty)
    #expect(viewModel.searchQuery.isEmpty)
    #expect(viewModel.listItems.isEmpty)
}

@Test
@MainActor
func loadPopulatesAssets() async {
    let mockService = MockASAService()
    await mockService.setAssetsToReturn(AssetList(
        results: [
            Asset(assetID: 1, name: "USDC"),
            Asset(assetID: 2, name: "ALGO")
        ]
    ))

    let viewModel = ASAViewerViewModel(service: mockService)
    await viewModel.load()

    #expect(viewModel.assets.count == 2)
    #expect(viewModel.assets[0].name == "USDC")
    #expect(viewModel.assets[1].name == "ALGO")
    #expect(await mockService.fetchAssetsCallCount == 1)
}

@Test
@MainActor
func loadAppendsPaginatedResults() async {
    let mockService = MockASAService()
    await mockService.setAssetsToReturn(AssetList(
        next: "https://api.example.com/page2",
        results: [Asset(assetID: 1, name: "Asset 1")]
    ))

    let viewModel = ASAViewerViewModel(service: mockService)
    await viewModel.load()

    #expect(viewModel.assets.count == 1)

    await mockService.setAssetsToReturn(AssetList(
        results: [Asset(assetID: 2, name: "Asset 2")]
    ))
    await viewModel.load()

    #expect(viewModel.assets.count == 2)
    #expect(viewModel.assets[0].name == "Asset 1")
    #expect(viewModel.assets[1].name == "Asset 2")
    #expect(await mockService.fetchAssetsCallCount == 2)
}

@Test
@MainActor
func searchFiltersByName() async {
    let mockService = MockASAService()
    await mockService.setAssetsToReturn(AssetList(
        results: [
            Asset(assetID: 1, name: "USDC"),
            Asset(assetID: 2, name: "ALGO"),
            Asset(assetID: 3, name: "USD Tether")
        ]
    ))

    let viewModel = ASAViewerViewModel(service: mockService)
    await viewModel.load()

    #expect(viewModel.listItems.count == 3)

    viewModel.searchQuery = "USD"
    #expect(viewModel.listItems.count == 2)
    #expect(viewModel.listItems.contains { $0.name == "USDC" })
    #expect(viewModel.listItems.contains { $0.name == "USD Tether" })
    #expect(!viewModel.listItems.contains { $0.name == "ALGO" })
}

@Test
@MainActor
func searchIsCaseInsensitive() async {
    let mockService = MockASAService()
    await mockService.setAssetsToReturn(AssetList(
        results: [
            Asset(assetID: 1, name: "USDC"),
            Asset(assetID: 2, name: "algo"),
            Asset(assetID: 3, name: "Bitcoin")
        ]
    ))

    let viewModel = ASAViewerViewModel(service: mockService)
    await viewModel.load()

    viewModel.searchQuery = "ALGO"
    #expect(viewModel.listItems.count == 1)
    #expect(viewModel.listItems[0].name == "algo")

    viewModel.searchQuery = "bitcoin"
    #expect(viewModel.listItems.count == 1)
    #expect(viewModel.listItems[0].name == "Bitcoin")
}

@Test
@MainActor
func emptySearchReturnsAllAssets() async {
    let mockService = MockASAService()
    await mockService.setAssetsToReturn(AssetList(
        results: [
            Asset(assetID: 1, name: "Asset 1"),
            Asset(assetID: 2, name: "Asset 2")
        ]
    ))

    let viewModel = ASAViewerViewModel(service: mockService)
    await viewModel.load()

    viewModel.searchQuery = "test"
    #expect(viewModel.listItems.isEmpty)

    viewModel.searchQuery = ""
    #expect(viewModel.listItems.count == 2)
}

@Test
@MainActor
func loadHandlesError() async {
    let mockService = MockASAService()
    await mockService.setError(URLError(.notConnectedToInternet))

    let viewModel = ASAViewerViewModel(service: mockService)
    await viewModel.load()

    #expect(viewModel.assets.isEmpty)
    #expect(await mockService.fetchAssetsCallCount == 1)
}
