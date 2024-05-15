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
        .library(
            name: "WannaDebug",
            targets: ["WannaDebug"]
        )
    ],
    dependencies: [
        .package(name: "WannaTryOn_Toolkit", path: "./../Toolkit/"),

        // TODO: Use public SPM instead of local workaround based on cocoapods files
        // https://wannaby.atlassian.net/browse/WK-3968
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
        ),
        .target(
            name: "WannaDebug",
            dependencies: ["WannaSDK"],
            path: "Debug/"
        )
    ]
)
