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
            url: "https://wreleases.s3.amazonaws.com/sdks/ios/20240717/WannaSDK_ios_7_2_0_626_core_spm.zip",
            checksum: "fa0be316f5659605a3821bf94526c18f4fdc1f187a38fa213d265e9efaef36f0"
        ),
        .binaryTarget(
            name: "WsneakersUISDK",
            url: "https://wreleases.s3.amazonaws.com/sdks/ios/20240717/WannaSDK_ios_7_2_0_626_ui_spm.zip",
            checksum: "c48a8a9de080b9d4448498a993eaf1a9cdc8cb33a2b97b007a86ac27396abc78"
        )
    ]
)
