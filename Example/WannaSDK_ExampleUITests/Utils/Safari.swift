//
//  Safari.swift
//  WannaSDK_ExampleUITests
//
//  Created by Nikita Kuznetsov on 14/07/2022.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import Foundation
import XCTest


final class Safari {
    let safari = XCUIApplication(bundleIdentifier: SafariIdentifiers.bundleId.rawValue)
    
    enum SafariIdentifiers: String {
        case bundleId = "com.apple.mobilesafari"
        case url = "URL"
        case open = "Open"
        case continueText = "Continue"
        case quickPathText = "Speed up your typing by sliding your finger across the letters to compose a word."
    }
    
    enum KeyboardKeys: String {
        case go = "Go"
    }
    
    func openDeeplink(_ deeplink: String) {
        safari.launch()
        
        let urlTextField = safari.textFields[SafariIdentifiers.url.rawValue]
        let urlField = safari.buttons[SafariIdentifiers.url.rawValue]
        urlField.tap()
        let quickPathText = safari
            .scrollViews
            .otherElements
            .containing(.staticText, identifier: SafariIdentifiers.quickPathText.rawValue)
            .element
        let quickPathContinueTextButton = safari.staticTexts[SafariIdentifiers.continueText.rawValue].firstMatch
        
        if quickPathText.exists {
            quickPathContinueTextButton.tap()
        }
        
        urlTextField.typeText(deeplink)
        safari.buttons[KeyboardKeys.go.rawValue].wait().tap()
        safari.buttons[SafariIdentifiers.open.rawValue].wait().tap()
    }
}
