// WANNA SDK
// Copyright © 2022 WANNABY Inc. All rights reserved.


import XCTest


struct Constants {
    static let waitInterval: TimeInterval = 30
}

extension XCUIElement {

    enum WaitPredicate: String {
        case exists = "exists == true"
        case notExists = "exists == false"
    }
    
    func wait(_ timeout: TimeInterval = Constants.waitInterval) -> XCUIElement {
        _ = waitForExistence(timeout: timeout)
        return self
    }
    
    func waitIfNotExists(_ timeout: TimeInterval = Constants.waitInterval) -> Bool {
        return !waitForExistence(timeout: timeout)
    }
    
    func waitUntil(predicate: WaitPredicate, timeout: TimeInterval = Constants.waitInterval) {
        let expectation = XCTestCase().expectation(
            for: NSPredicate(format: predicate.rawValue),
            evaluatedWith: self,
            handler: .none
        )

        let _ = XCTWaiter.wait(for: [expectation], timeout: timeout)
    }
}
