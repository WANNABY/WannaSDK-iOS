// swift-tools-version:5.7

import PackageDescription

let package = Package(
    name: "WannaSDK",
    platforms: [
        .macOS(.v12), .iOS(.v12)
    ],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "WannaSDK",
            targets: ["WannaCoreSDK", "WsneakersUISDK"]
        )
    ],
    dependencies: [
    ],
    targets: [
        // .binaryTarget(
        //     name: "SomeRemoteBinaryPackage",
        //     url: "https://url/to/some/remote/xcframework.zip",
        //     checksum: "The checksum of the ZIP archive that contains the XCFramework."
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