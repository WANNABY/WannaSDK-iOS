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
            url: "https://wreleases.s3.us-east-1.amazonaws.com/sdks/ios/20251006/WannaSDK_ios_8_1_0_717_core_spm.zip",
            checksum: "cd266e944cce54ed2b8934584f69a4c62b29348a3d7ef86adca9b9944c2a00b8"
        ),
        .binaryTarget(
            name: "WsneakersUISDK",
            url: "https://wreleases.s3.us-east-1.amazonaws.com/sdks/ios/20251006/WannaSDK_ios_8_1_0_717_ui_spm.zip",
            checksum: "00b1891a59b7d50eec0acc3c905a30642b69a44737ee5bf4bc1719c6d0b69be6"
        )
    ]
)
