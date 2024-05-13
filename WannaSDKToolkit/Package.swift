// swift-tools-version:5.7

import PackageDescription

let package = Package(
    name: "WannaSDKToolkit",
    platforms: [
        .iOS(.v12),
        .macOS(.v12),
    ],
    products: [
        .library(
            name: "WannaSDKToolkit",
            targets: [
                "WannaSDKToolkit"
            ]
        ),
    ],
    targets: [
        .target(
            name: "WannaSDKToolkit",
            path: "Sources/"
        ),
        .testTarget(
            name: "WannaSDKToolkitTests",
            dependencies: [
                "WannaSDKToolkit"
            ],
            path: "Tests/"
        ),
    ]
)
