// swift-tools-version:5.7

import PackageDescription

let package = Package(
    name: "WannaSDK",
    platforms: [
        .macOS(.v12), .iOS(.v12)
    ],
    products: [
        .library(
            name: "WannaSDK",
            targets: [
                "WannaCoreSDK", 
                "WsneakersUISDK"
            ]
        )
    ],
    dependencies: [
    ],
    targets: [
        .binaryTarget(
            name: "WannaCoreSDK",
            url: "https://wreleases.s3.amazonaws.com/sdks/ios/20240617/WannaSDK_ios_7_1_1_594_core_spm.zip",
            checksum: "67537a4b008057e128eab8c8ce4c1d5a0e7dfa1efbe2cdcc772bae6f3c685c26"
        ),
        .binaryTarget(
            name: "WsneakersUISDK",
            url: "https://wreleases.s3.amazonaws.com/sdks/ios/20240617/WannaSDK_ios_7_1_1_594_ui_spm.zip",
            checksum: "f329505fdbf1561d6080fe45560319405787c064e0cf9a487477f247dac7773e"
        )
    ]
)
