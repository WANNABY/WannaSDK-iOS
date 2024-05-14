// swift-tools-version:5.7

import PackageDescription

let package = Package(
    name: "WannaTryOn_Toolkit",
    platforms: [
        .iOS(.v12),
        .macOS(.v12),
    ],
    products: [
        .library(
            name: "WannaTryOn_Toolkit",
            targets: [
                "WannaTryOn_Toolkit"
            ]
        ),
    ],
    targets: [
        .target(
            name: "WannaTryOn_Toolkit",
            path: "Sources/"
        ),
        // TODO:
        // .testTarget(
        //     name: "WannaSDKToolkitTests",
        //     dependencies: [
        //         "WannaSDKToolkit"
        //     ],
        //     path: "Tests/"
        // )
    ]
)
