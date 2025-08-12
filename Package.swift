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
            url: "https://wreleases.s3.amazonaws.com/sdks/ios/20250812/WannaSDK_ios_8_0_0_713_core_spm.zip",
            checksum: "14c2f229ed86786b383161d098d5032759454b21425c4e82e819d3c8a632b448"
        ),
        .binaryTarget(
            name: "WsneakersUISDK",
            url: "https://wreleases.s3.amazonaws.com/sdks/ios/20250812/WannaSDK_ios_8_0_0_713_ui_spm.zip",
            checksum: "bbf7b4c9198cfc4d5e94493aa2453d650464419c905bcc4f6ff48e4b2fe54f40"
        )
    ]
)
