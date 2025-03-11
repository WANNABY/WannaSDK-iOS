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
            url: "https://wreleases.s3.amazonaws.com/sdks/ios/20250227/WannaSDK_ios_7_4_0_674_core_spm.zip",
            checksum: "32f123bca8f3a7ebd6106278104182b46dbbab28e2e410bc05221b755cd7349d"
        ),
        .binaryTarget(
            name: "WsneakersUISDK",
            url: "https://wreleases.s3.amazonaws.com/sdks/ios/20250227/WannaSDK_ios_7_4_0_674_ui_spm.zip",
            checksum: "6cc734ca3b7c20545ac6433a89a5707734019b875af14440ac3561a8df4ed488"
        )
    ]
)
