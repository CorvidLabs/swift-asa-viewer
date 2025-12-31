import Foundation

public struct Asset: Codable, Hashable, Sendable {
    public struct VerificationDetails: Codable, Hashable, Sendable {
        enum CodingKeys: String, CodingKey {
            case projectName = "project_name"
            case projectURL = "project_url"
            case projectDescription = "project_description"
            case discordURL = "discord_url"
            case telegramURL = "telegram_url"
            case twitterUsername = "twitter_username"
        }
        public let projectName: String?
        public let projectURL: String?
        public let projectDescription: String?
        public let discordURL: String?
        public let telegramURL: String?
        public let twitterUsername: String?

        public init(
            projectName: String? = nil,
            projectURL: String? = nil,
            projectDescription: String? = nil,
            discordURL: String? = nil,
            telegramURL: String? = nil,
            twitterUsername: String? = nil
        ) {
            self.projectName = projectName
            self.projectURL = projectURL
            self.projectDescription = projectDescription
            self.discordURL = discordURL
            self.telegramURL = telegramURL
            self.twitterUsername = twitterUsername
        }
    }

    public struct Media: Codable, Hashable, Sendable {
        enum CodingKeys: String, CodingKey {
            case type
            case url
            case ipfsCID = "ipfs_cid"
            case extensionType = "extension"
        }
        public let type: String?
        public let url: String?
        public let ipfsCID: String?
        public let extensionType: String?

        public init(
            type: String? = nil,
            url: String? = nil,
            ipfsCID: String? = nil,
            extensionType: String? = nil
        ) {
            self.type = type
            self.url = url
            self.ipfsCID = ipfsCID
            self.extensionType = extensionType
        }
    }

    public struct Trait: Codable, Hashable, Sendable {
        enum CodingKeys: String, CodingKey {
            case displayName = "display_name"
            case displayValue = "display_value"
        }
        public let displayName: String?
        public let displayValue: String?

        public init(displayName: String? = nil, displayValue: String? = nil) {
            self.displayName = displayName
            self.displayValue = displayValue
        }
    }

    public struct Collectible: Codable, Hashable, Sendable {
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
        public let title: String?
        public let description: String?
        public let standards: [String]?
        public let thumbnailURL: String?
        public let thumbnailIPFSCID: String?
        public let media: [Media]?
        public let metadata: [String: String]?
        public let traits: [Trait]?

        public init(
            title: String? = nil,
            description: String? = nil,
            standards: [String]? = nil,
            thumbnailURL: String? = nil,
            thumbnailIPFSCID: String? = nil,
            media: [Media]? = nil,
            metadata: [String: String]? = nil,
            traits: [Trait]? = nil
        ) {
            self.title = title
            self.description = description
            self.standards = standards
            self.thumbnailURL = thumbnailURL
            self.thumbnailIPFSCID = thumbnailIPFSCID
            self.media = media
            self.metadata = metadata
            self.traits = traits
        }
    }

    public enum CodingKeys: String, CodingKey {
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

    public let assetID: Int
    public let name: String
    public let unitName: String?
    public let fractionDecimals: Int
    public let totalSupply: Double
    public let totalSupplyAsStr: String
    public let creatorAddress: String
    public let url: String?
    public let logo: String?
    public let verificationTier: String
    public let usdValue: String?
    public let usdValue24HourAgo: String?
    public let isCollectible: Bool
    public let verificationDetails: VerificationDetails?
    public let collectible: Collectible?
    public let description: String?
    public let circulatingSupply: String?

    public init(
        assetID: Int,
        name: String,
        unitName: String? = nil,
        fractionDecimals: Int = 0,
        totalSupply: Double = 0,
        totalSupplyAsStr: String = "0",
        creatorAddress: String = "",
        url: String? = nil,
        logo: String? = nil,
        verificationTier: String = "unverified",
        usdValue: String? = nil,
        usdValue24HourAgo: String? = nil,
        isCollectible: Bool = false,
        verificationDetails: VerificationDetails? = nil,
        collectible: Collectible? = nil,
        description: String? = nil,
        circulatingSupply: String? = nil
    ) {
        self.assetID = assetID
        self.name = name
        self.unitName = unitName
        self.fractionDecimals = fractionDecimals
        self.totalSupply = totalSupply
        self.totalSupplyAsStr = totalSupplyAsStr
        self.creatorAddress = creatorAddress
        self.url = url
        self.logo = logo
        self.verificationTier = verificationTier
        self.usdValue = usdValue
        self.usdValue24HourAgo = usdValue24HourAgo
        self.isCollectible = isCollectible
        self.verificationDetails = verificationDetails
        self.collectible = collectible
        self.description = description
        self.circulatingSupply = circulatingSupply
    }
}

extension Asset: Identifiable {
    public var id: Int { assetID }
}
