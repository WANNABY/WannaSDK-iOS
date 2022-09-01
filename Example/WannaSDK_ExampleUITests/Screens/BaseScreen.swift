// WANNA SDK
// Copyright © 2022 WANNABY Inc. All rights reserved.


import XCTest


class BaseScreen: Applyable {
    typealias T = BaseScreen
    
    let app = XCUIApplication()
    let logger = Logger()
    
    func tapBy(text: String, timeout: TimeInterval = Constants.waitInterval) {
        logger.add("Tap on text: \(text)") {
            app.staticTexts[text].firstMatch.wait(timeout).tap()
        }
    }
    
    func tapBy(cell: XCUIElement, timeout: TimeInterval = Constants.waitInterval) {
        logger.add("Tap by cell") {
            cell.firstMatch.wait(timeout).tap()
        }
    }
    
    func tapButtonBy(text: String, timeout: TimeInterval = Constants.waitInterval) {
        logger.add("Tap on button with text: \(text)") {
            app.buttons[text].firstMatch.wait(timeout).tap()
        }
    }
    
    func verifyText(_ text: String, timeout: TimeInterval = Constants.waitInterval) {
        logger.add("Verify text \"\(text)\" exists",
                   success: app.staticTexts[text].firstMatch.wait(timeout).exists)
    }
    
    func grantCameraPermission() {
        let springboard = XCUIApplication(bundleIdentifier: "com.apple.springboard")
        if springboard.alerts.firstMatch.waitForExistence(timeout: Constants.longWaitInterval) {
            logger.add("Grant camera permission") {
                springboard.alerts.firstMatch.buttons["OK"].firstMatch.tap()
            }
        }
    }
}
