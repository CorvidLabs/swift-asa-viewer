public struct AssetList: Codable, Sendable {
    public let next: String?
    public let previous: String?
    public let results: [Asset]

    public init(next: String? = nil, previous: String? = nil, results: [Asset]) {
        self.next = next
        self.previous = previous
        self.results = results
    }
}
