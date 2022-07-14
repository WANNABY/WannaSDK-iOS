//
//  MainScreen.swift
//  WannaSDK_ExampleUITests
//
//  Created by Nikita Kuznetsov on 14/07/2022.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

final class MainScreen: BaseScreen {
    
    enum Strings: String {
        case shoes = "SHOES"
        case watches = "WATCHES"
    }
    
    func verifyBuildNumber(_ buildNumber: String) {
        logger.add("Verify build number is \(buildNumber)") {
            verifyText(buildNumber)
        }
    }
}
