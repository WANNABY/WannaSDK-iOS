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
        // TODO: Use public SPM instead of local workaround based on cocoapods files
        // https://wannaby.atlassian.net/browse/WK-3968
        .package(path: "./../WannaSDK/") 
    ],
    targets: [
        .target(
            name: "WannaDebug",
            dependencies: ["WannaSDK"],
            path: "Sources/"
        )
    ]
)
