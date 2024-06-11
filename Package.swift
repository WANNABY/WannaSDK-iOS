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
            url: "https://wreleases.s3.amazonaws.com/sdks/ios/20240601/WannaSDK_ios_7_1_1_579_cocoapods.zip",
            checksum: "3d2368e85cd9d2f385aba08b99299d31217d7964cd48a6edd9971dbbbfc0e800"
        ),
        .binaryTarget(
            name: "WsneakersUISDK",
            url: "https://wreleases.s3.amazonaws.com/sdks/ios/20240601/WannaSDK_ios_7_1_1_579_cocoapods.zip",
            checksum: "3d2368e85cd9d2f385aba08b99299d31217d7964cd48a6edd9971dbbbfc0e800"
        )
    ]
)
