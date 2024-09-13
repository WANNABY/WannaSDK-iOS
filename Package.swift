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
            url: "https://wreleases.s3.amazonaws.com/sdks/ios/20240910/WannaSDK_ios_7_3_0_653_core_spm.zip",
            checksum: "c25e0de7081676e42ae500fade6c2b8daae546196e6a0b0271253b60b37da6f1"
        ),
        .binaryTarget(
            name: "WsneakersUISDK",
            url: "https://wreleases.s3.amazonaws.com/sdks/ios/20240910/WannaSDK_ios_7_3_0_653_ui_spm.zip",
            checksum: "c8680f148c4e4581c31d03d93940d8bcb09c848ef43639b802264b9f29437d57"
        )
    ]
)
