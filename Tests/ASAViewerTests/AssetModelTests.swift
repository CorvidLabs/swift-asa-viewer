@testable import ASAViewer
import Foundation
import Testing

@Test
func assetDecodesMinimalJSON() throws {
    let json = Data("""
    {
        "asset_id": 123,
        "name": "Test Asset",
        "fraction_decimals": 6,
        "total_supply": 1000000,
        "total_supply_as_str": "1000000",
        "creator_address": "TESTADDRESS123",
        "verification_tier": "verified",
        "is_collectible": false
    }
    """.utf8)

    let asset = try JSONDecoder().decode(Asset.self, from: json)

    #expect(asset.assetID == 123)
    #expect(asset.name == "Test Asset")
    #expect(asset.fractionDecimals == 6)
    #expect(asset.totalSupply == 1000000)
    #expect(asset.creatorAddress == "TESTADDRESS123")
    #expect(asset.verificationTier == "verified")
    #expect(asset.isCollectible == false)
    #expect(asset.unitName == nil)
    #expect(asset.logo == nil)
}

@Test
func assetDecodesFullJSON() throws {
    let json = Data("""
    {
        "asset_id": 31566704,
        "name": "USDC",
        "unit_name": "USDC",
        "fraction_decimals": 6,
        "total_supply": 10000000000,
        "total_supply_as_str": "10000000000",
        "creator_address": "2UEQTE5QDNXPI7M3TU44G6SYKLFWLPQO7EBZM7K7MHMQQAPYK73OWJEB",
        "url": "https://www.centre.io/usdc",
        "logo": "https://asa-list.tinyman.org/assets/31566704/icon.png",
        "verification_tier": "verified",
        "usd_value": "1.00",
        "usd_value_24_hour_ago": "1.00",
        "is_collectible": false,
        "description": "USDC is a stablecoin",
        "circulating_supply": "5000000000"
    }
    """.utf8)

    let asset = try JSONDecoder().decode(Asset.self, from: json)

    #expect(asset.assetID == 31566704)
    #expect(asset.name == "USDC")
    #expect(asset.unitName == "USDC")
    #expect(asset.url == "https://www.centre.io/usdc")
    #expect(asset.logo != nil)
    #expect(asset.usdValue == "1.00")
    #expect(asset.description == "USDC is a stablecoin")
    #expect(asset.circulatingSupply == "5000000000")
}

@Test
func assetDecodesWithVerificationDetails() throws {
    let json = Data("""
    {
        "asset_id": 1,
        "name": "Test",
        "fraction_decimals": 0,
        "total_supply": 1000,
        "total_supply_as_str": "1000",
        "creator_address": "ABC",
        "verification_tier": "verified",
        "is_collectible": false,
        "verification_details": {
            "project_name": "Test Project",
            "project_url": "https://test.com",
            "project_description": "A test project",
            "discord_url": "https://discord.gg/test",
            "telegram_url": "https://t.me/test",
            "twitter_username": "testproject"
        }
    }
    """.utf8)

    let asset = try JSONDecoder().decode(Asset.self, from: json)

    #expect(asset.verificationDetails != nil)
    #expect(asset.verificationDetails?.projectName == "Test Project")
    #expect(asset.verificationDetails?.projectURL == "https://test.com")
    #expect(asset.verificationDetails?.twitterUsername == "testproject")
}

@Test
func assetDecodesWithCollectible() throws {
    let json = Data("""
    {
        "asset_id": 1,
        "name": "NFT",
        "fraction_decimals": 0,
        "total_supply": 1,
        "total_supply_as_str": "1",
        "creator_address": "ABC",
        "verification_tier": "unverified",
        "is_collectible": true,
        "collectible": {
            "title": "My NFT",
            "description": "A rare NFT",
            "standards": ["arc3", "arc69"],
            "thumbnail_url": "https://example.com/thumb.png"
        }
    }
    """.utf8)

    let asset = try JSONDecoder().decode(Asset.self, from: json)

    #expect(asset.isCollectible == true)
    #expect(asset.collectible != nil)
    #expect(asset.collectible?.title == "My NFT")
    #expect(asset.collectible?.standards == ["arc3", "arc69"])
}

@Test
func assetIsHashable() {
    let asset1 = Asset(assetID: 1, name: "Asset 1")
    let asset2 = Asset(assetID: 1, name: "Asset 1")
    let asset3 = Asset(assetID: 2, name: "Asset 2")

    #expect(asset1.hashValue == asset2.hashValue)
    #expect(asset1.hashValue != asset3.hashValue)
}

@Test
func assetIsIdentifiable() {
    let asset = Asset(assetID: 12345, name: "Test")

    #expect(asset.id == 12345)
    #expect(asset.id == asset.assetID)
}

@Test
func assetListDecodes() throws {
    let json = Data("""
    {
        "next": "https://api.example.com/assets?page=2",
        "previous": null,
        "results": [
            {
                "asset_id": 1,
                "name": "Asset 1",
                "fraction_decimals": 0,
                "total_supply": 1000,
                "total_supply_as_str": "1000",
                "creator_address": "ABC",
                "verification_tier": "unverified",
                "is_collectible": false
            },
            {
                "asset_id": 2,
                "name": "Asset 2",
                "fraction_decimals": 6,
                "total_supply": 2000,
                "total_supply_as_str": "2000",
                "creator_address": "DEF",
                "verification_tier": "verified",
                "is_collectible": false
            }
        ]
    }
    """.utf8)

    let assetList = try JSONDecoder().decode(AssetList.self, from: json)

    #expect(assetList.next == "https://api.example.com/assets?page=2")
    #expect(assetList.previous == nil)
    #expect(assetList.results.count == 2)
    #expect(assetList.results[0].name == "Asset 1")
    #expect(assetList.results[1].name == "Asset 2")
}
