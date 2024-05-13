// swift-tools-version:5.7

import PackageDescription

let package = Package(
    name: "WannaSDK",
    platforms: [
        .iOS(.v12),
        .macOS(.v12),
    ],
    products: [
        .library(
            name: "WannaTryOn",
            targets: [
                "WannaTryOn"
            ]
        )
    ],
    dependencies: [
        .package(path: "./../WannaSDK"),
        .package(path: "WannaSDKToolkit/")
    ],
    targets: [
        .target(
            name: "WannaTryOn",
            dependencies: [
                "WannaSDKToolkit", 
                "WannaSDK"
            ],
            path: "WannaTryOn/Sources/"
        ),
        .testTarget(
            name: "WannaTryOnTests",
            dependencies: [
                "WannaTryOn"
            ],
            path: "Tests/"
        ),
    ]
)
