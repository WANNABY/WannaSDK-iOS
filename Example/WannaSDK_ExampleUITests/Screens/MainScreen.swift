// WANNA SDK
// Copyright © 2022 WANNABY Inc. All rights reserved.


final class MainScreen: BaseScreen {
    
    enum Strings: String {
        case shoes = "SHOES"
        case watches = "WATCHES"
        case clothes = "CLOTHES"
    }
    
    func verifyBuildNumber(_ buildNumber: String) {
        logger.add("Verify build number is \(buildNumber)") {
            verifyText(buildNumber)
        }
    }
}
