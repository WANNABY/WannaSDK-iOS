// WANNA SDK
// Copyright © 2022 WANNABY Inc. All rights reserved.


import Foundation
import XCTest


final class Safari {
    let safari = XCUIApplication(bundleIdentifier: SafariIdentifiers.bundleId.rawValue)
    
    enum SafariIdentifiers: String {
        case bundleId = "com.apple.mobilesafari"
        case url = "URL"
        case address = "Address"
        case open = "Open"
        case continueText = "Continue"
        case quickPathText = "Speed up your typing by sliding your finger across the letters to compose a word."
    }
    
    enum KeyboardKeys: String {
        case go = "Go"
    }
    
    func openDeeplink(_ deeplink: String) {
        openLink(deeplink)
        safari.buttons[SafariIdentifiers.open.rawValue].wait().tap()
    }
    
    func getAllModelImages() -> [XCUIElement] {
        return safari.images.allElementsBoundByIndex
    }
    
    func waitForModelDownload() {
        safari.staticTexts["Loading model"].waitUntil(predicate: .notExists, timeout: 30)
    }
    
    func waitForRoomLoading() {
        safari.staticTexts["Initializing App..."].waitUntil(predicate: .notExists, timeout: 30)
    }
    
    func openLink(_ link: String) {
        safari.launch()
        
        let urlTextField = safari.textFields[SafariIdentifiers.address.rawValue]
        // in case of ios 15 or less try to use this line instead to write down url
        // if it doesn't help you, check elements tree using print object
        // let urlField = safari.buttons[SafariIdentifiers.url.rawValue]
        urlTextField.tap()
        let quickPathText = safari
            .scrollViews
            .otherElements
            .containing(.staticText, identifier: SafariIdentifiers.quickPathText.rawValue)
            .element
        let quickPathContinueTextButton = safari.staticTexts[SafariIdentifiers.continueText.rawValue].firstMatch
        
        if quickPathText.exists {
            quickPathContinueTextButton.tap()
        }
        
        urlTextField.typeText(link)
        safari.buttons[KeyboardKeys.go.rawValue].wait().tap()
    }
}
