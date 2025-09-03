// swift-tools-version: 6.0

import PackageDescription

let package = Package(
    name: "ASAViewer",
    platforms: [
        .iOS(.v16)
    ],
    products: [
        .library(
            name: "ASAViewer",
            targets: ["ASAViewer"]
        )
    ],
    dependencies: [
        .package(url: "https://github.com/0xLeif/AppState.git", from: "2.2.0")
    ],
    targets: [
        .target(
            name: "ASAViewer",
            dependencies: ["AppState"]
        ),
        .testTarget(
            name: "ASAViewerTests",
            dependencies: ["ASAViewer"]
        )
    ]
)
