import Foundation

struct Asset: Codable, Hashable {
    struct VerificationDetails: Codable, Hashable {
        enum CodingKeys: String, CodingKey {
            case projectName = "project_name"
            case projectURL = "project_url"
            case projectDescription = "project_description"
            case discordURL = "discord_url"
            case telegramURL = "telegram_url"
            case twitterUsername = "twitter_username"
        }
        let projectName: String?
        let projectURL: String?
        let projectDescription: String?
        let discordURL: String?
        let telegramURL: String?
        let twitterUsername: String?
    }

    struct Media: Codable, Hashable {
        enum CodingKeys: String, CodingKey {
            case type
            case url
            case ipfsCID = "ipfs_cid"
            case extensionType = "extension"
        }
        let type: String?
        let url: String?
        let ipfsCID: String?
        let extensionType: String?
    }

    struct Trait: Codable, Hashable {
        enum CodingKeys: String, CodingKey {
            case displayName = "display_name"
            case displayValue = "display_value"
        }
        let displayName: String?
        let displayValue: String?
    }

    struct Collectible: Codable, Hashable {
        enum CodingKeys: String, CodingKey {
            case title
            case description
            case standards
            case thumbnailURL = "thumbnail_url"
            case thumbnailIPFSCID = "thumbnail_ipfs_cid"
            case media
            case metadata
            case traits
        }
        let title: String?
        let description: String?
        let standards: [String]?
        let thumbnailURL: String?
        let thumbnailIPFSCID: String?
        let media: [Media]?
        let metadata: [String: String]?
        let traits: [Trait]?
    }

    enum CodingKeys: String, CodingKey {
        case assetID = "asset_id"
        case name
        case unitName = "unit_name"
        case fractionDecimals = "fraction_decimals"
        case totalSupply = "total_supply"
        case totalSupplyAsStr = "total_supply_as_str"
        case creatorAddress = "creator_address"
        case url
        case logo
        case verificationTier = "verification_tier"
        case usdValue = "usd_value"
        case usdValue24HourAgo = "usd_value_24_hour_ago"
        case isCollectible = "is_collectible"
        case verificationDetails = "verification_details"
        case collectible
        case description
        case circulatingSupply = "circulating_supply"
    }

    let assetID: Int
    let name: String
    let unitName: String?
    let fractionDecimals: Int
    let totalSupply: Double
    let totalSupplyAsStr: String
    let creatorAddress: String
    let url: String?
    let logo: String?
    let verificationTier: String
    let usdValue: String?
    let usdValue24HourAgo: String?
    let isCollectible: Bool
    let verificationDetails: VerificationDetails?
    let collectible: Collectible?
    let description: String?
    let circulatingSupply: String?
}

extension Asset: Identifiable {
    var id: Int { assetID }
}
