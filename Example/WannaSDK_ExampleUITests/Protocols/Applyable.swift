// WANNA SDK
// Copyright © 2022 WANNABY Inc. All rights reserved.

import XCTest


protocol Applyable {
    associatedtype T: BaseScreen
    func apply(_ closure: (T) -> Void)
}

extension Applyable where Self: BaseScreen {
    func apply(_ closure: (Self) -> Void) {
        closure(self)
    }
}
