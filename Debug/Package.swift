// swift-tools-version:5.7

import PackageDescription

let package = Package(
    name: "WannaDebug",
    platforms: [
        .iOS(.v12),
        .macOS(.v12),
    ],
    products: [
        .library(
            name: "WannaDebug",
            targets: ["WannaDebug"]
        )
    ],
    dependencies: [
        .package(url: "https://github.com/WANNABY/WannaSDK-iOS.git", from: "7.1.1")
    ],
    targets: [
        .target(
            name: "WannaDebug",
            dependencies: [.product(name: "WannaSDK", package: "WannaSDK-iOS")],
            path: "Sources/"
        )
    ]
)
