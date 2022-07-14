//
//  XCUIElement+wait.swift
//  WannaSDK_ExampleUITests
//
//  Created by Nikita Kuznetsov on 14/07/2022.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import XCTest


extension XCUIElement {
    
    enum WaitPredicate: String {
        case exists = "exists == true"
        case notExists = "exists == false"
    }
    
    func wait(_ timeout: TimeInterval = 10.0) -> XCUIElement {
        _ = waitForExistence(timeout: timeout)
        return self
    }
    
    func waitIfNotExists(_ timeout: TimeInterval = 15.0) -> Bool {
        return !waitForExistence(timeout: timeout)
    }
    
    func waitUntil(predicate: WaitPredicate, timeout: TimeInterval = 30.0) {
        let expectation = XCTestCase().expectation(
            for: NSPredicate(format: predicate.rawValue),
            evaluatedWith: self,
            handler: .none
        )

        let _ = XCTWaiter.wait(for: [expectation], timeout: timeout)
    }
}
