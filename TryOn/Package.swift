// swift-tools-version:5.7

import PackageDescription

let package = Package(
    name: "WannaTryOn",
    platforms: [
        .iOS(.v12),
        .macOS(.v12),
    ],
    products: [
        .library(
            name: "WannaTryOn",
            targets: ["WannaTryOn"]
        ),
    ],
    dependencies: [
        .package(name: "WannaTryOn_Toolkit", path: "./../Toolkit/"),
        .package(path: "./../WannaSDK/")
    ],
    targets: [
        .target(
            name: "WannaTryOn",
            dependencies: [
                "WannaSDK",
                "WannaTryOn_Toolkit"
            ],
            path: "Sources/"
        )
    ]
)
