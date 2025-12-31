import SwiftUI

struct ASADetailView: View {
    let asset: Asset

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                HStack {
                    if let logo = asset.logo, let url = URL(string: logo) {
                        AsyncImage(url: url) { image in
                            image.resizable()
                                 .aspectRatio(contentMode: .fit)
                        } placeholder: {
                            ProgressView()
                        }
                        .frame(width: 64, height: 64)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                    }
                    VStack(alignment: .leading, spacing: 4) {
                        Text(asset.name)
                            .font(.title2)
                            .bold()
                        Text(asset.unitName ?? "")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                }

                Group {
                    DetailRow(title: "Asset ID", value: "\(asset.assetID)")
                    DetailRow(title: "Verification", value: asset.verificationTier.capitalized)
                    DetailRow(title: "Decimals", value: "\(asset.fractionDecimals)")
                    DetailRow(title: "Total Supply", value: asset.totalSupplyAsStr)

                    if let circulatingSupply = asset.circulatingSupply {
                        DetailRow(title: "Circulating Supply", value: circulatingSupply)
                    }

                    DetailRow(title: "Creator", value: asset.creatorAddress)
                    if let url = asset.url { DetailRow(title: "URL", value: url) }
                    if let description = asset.description { DetailRow(title: "Description", value: description) }
                    if let usdValue = asset.usdValue { DetailRow(title: "USD Value", value: usdValue) }
                    if let usd24 = asset.usdValue24HourAgo { DetailRow(title: "USD 24h Ago", value: usd24) }
                    DetailRow(title: "Is Collectible", value: asset.isCollectible ? "Yes" : "No")
                }

                if let verificationDetails = asset.verificationDetails {
                    Section(header: Text("Verification Details").font(.headline)) {
                        if let projectName = verificationDetails.projectName { DetailRow(title: "Project", value: projectName) }
                        if let projectURL = verificationDetails.projectURL { DetailRow(title: "Project URL", value: projectURL) }
                        if let projectDescription = verificationDetails.projectDescription { DetailRow(title: "Description", value: projectDescription) }
                        if let discordURL = verificationDetails.discordURL { DetailRow(title: "Discord", value: discordURL) }
                        if let telegramURL = verificationDetails.telegramURL { DetailRow(title: "Telegram", value: telegramURL) }
                        if let twitterUsername = verificationDetails.twitterUsername { DetailRow(title: "Twitter", value: twitterUsername) }
                    }
                }

                if let collectible = asset.collectible {
                    Section(header: Text("Collectible Details").font(.headline)) {
                        if let title = collectible.title { DetailRow(title: "Title", value: title) }
                        if let description = collectible.description { DetailRow(title: "Description", value: description) }
                        if let thumbnailURL = collectible.thumbnailURL { DetailRow(title: "Thumbnail", value: thumbnailURL) }
                        if let standards = collectible.standards, !standards.isEmpty {
                            DetailRow(title: "Standards", value: standards.joined(separator: ", "))
                        }
                        // Additional loop for traits or displaying media can be added here
                    }
                }
            }
            .padding()
        }
        .navigationTitle(asset.name)
    }
}

struct DetailRow: View {
    let title: String
    let value: String

    var body: some View {
        HStack(alignment: .top) {
            Text(title + ":")
                .fontWeight(.semibold)
                .frame(width: 130, alignment: .leading)
            Text(value)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}
