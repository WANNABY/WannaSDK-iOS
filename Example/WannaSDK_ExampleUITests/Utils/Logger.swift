// WANNA SDK
// Copyright © 2022 WANNABY Inc. All rights reserved.


import XCTest

final class Logger {
    
    func add(_ info: String, success: Bool) {
        XCTContext.runActivity(named: info) { _ in
            if !success {
                makeScreenshot()
                XCTFail("Action \(info) has failed")
            }
        }
    }
    
    func add(_ info: String, action: () -> ()) {
        add(info, success: true)
        action()
    }
    
    func add(_ info: String) {
        add(info, success: true)
    }
    
    func makeScreenshot(info: String = "") {
        let info = "Screenshot \(info)"
        XCTContext.runActivity(named: info) {
            let screenshot = XCUIScreen.main.screenshot()
            let attachment = XCTAttachment(screenshot: screenshot, quality: .original)
            attachment.name = info
            attachment.lifetime = .keepAlways
            $0.add(attachment)
        }
    }
}
