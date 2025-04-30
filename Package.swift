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
            url: "https://wreleases.s3.amazonaws.com/sdks/ios/20250430/WannaSDK_ios_7_4_1_704_core_spm.zip",
            checksum: "4e0a9339ea121de42e11944ae737442a0b6ea07b1732008c137962441d878144"
        ),
        .binaryTarget(
            name: "WsneakersUISDK",
            url: "https://wreleases.s3.amazonaws.com/sdks/ios/20250430/WannaSDK_ios_7_4_1_704_ui_spm.zip",
            checksum: "aa20637ed691b56db09cef40d99fd823aa7675ef81a6e2612a76ac3389320f0e"
        )
    ]
)
