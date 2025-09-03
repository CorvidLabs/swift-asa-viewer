struct Asset: Codable {
    enum CodingKeys: String, CodingKey {
        case assetID = "asset_id"
        case name
        case logo
    }

    let assetID: Int
    let name: String
    let logo: String?
}

extension Asset: Identifiable {
    var id: Int { assetID }
}
