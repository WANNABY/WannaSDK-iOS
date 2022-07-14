//
//  BaseScreen.swift
//  WannaSDK_ExampleUITests
//
//  Created by Nikita Kuznetsov on 14/07/2022.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import XCTest


class BaseScreen {
    
    let app = XCUIApplication()
    let logger = Logger()
    
    func tapBy(text: String, timeout: TimeInterval = 10) {
        logger.add("Tap on text: \(text)") {
            app.staticTexts[text].firstMatch.wait(timeout).tap()
        }
    }
    
    func tapBy(cell: XCUIElement, timeout: TimeInterval = 10) {
        logger.add("Tap by cell") {
            cell.firstMatch.wait(timeout).tap()
        }
    }
    
    func tapButtonBy(text: String, timeout: TimeInterval = 10) {
        logger.add("Tap on button with text: \(text)") {
            app.buttons[text].firstMatch.wait(timeout).tap()
        }
    }
    
    func verifyText(_ text: String, timeout: TimeInterval = 10) {
        logger.add("Verify text \"\(text)\" exists",
                   success: app.staticTexts[text].firstMatch.wait(timeout).exists)
    }
    
    func handleCameraPermission() {
        let springboard = XCUIApplication(bundleIdentifier: "com.apple.springboard")
        let alert = springboard.alerts.containing(.staticText, identifier: "Would Like to Access").firstMatch.wait(20)
        logger.add("Close camera alert") {
            alert.buttons.firstMatch.tap()
        }
    }
}
