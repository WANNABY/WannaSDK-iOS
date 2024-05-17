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
        // TODO: 1) Move to root folder
        // TODO: 2) implement SPM 
        // https://wannaby.atlassian.net/browse/WK-3968
        //
        // .binaryTarget(
        //     name: "WannaCoreSDK",
        //     url: "https://wreleases.s3.amazonaws.com/sdks/ios/20240419/WannaSDK_ios_7_1_0_548_cocoapods.zip"
        // ),
        // .binaryTarget(
        //     name: "WsneakersUISDK",
        //     url: "https://wreleases.s3.amazonaws.com/sdks/ios/20240419/WannaSDK_ios_7_1_0_548_cocoapods.zip"
        // ),
        .binaryTarget(
            name: "WannaCoreSDK",
            path: "../Example/Pods/WannaSDK/WannaCoreSDK.xcframework"
        ),
        .binaryTarget(
            name: "WsneakersUISDK",
            path: "../Example/Pods/WannaSDK/WsneakersUISDK.xcframework"
        )
    ]
)
