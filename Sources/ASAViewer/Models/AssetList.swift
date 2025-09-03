struct AssetList: Codable {
    let next: String?
    let previous: String?
    let results: [Asset]
}
