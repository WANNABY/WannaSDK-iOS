// swift-tools-version:5.7

import PackageDescription

let package = Package(
    name: "WannaSDKSample",
    platforms: [
        .iOS(.v12),
        .macOS(.v12),
    ],
    products: [
        .library(
            name: "WannaSDKSample",
            targets: [
                "WannaSDKSample"
            ]
        )
    ],
    dependencies: [
        .package(path: "WannaTryOn/")
        .package(path: "WannaSDKToolkit/")
    ]
)
