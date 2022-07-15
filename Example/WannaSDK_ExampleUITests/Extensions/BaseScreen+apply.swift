// WANNA SDK
// Copyright © 2022 WANNABY Inc. All rights reserved.


extension Applyable where Self: BaseScreen {
    func apply(_ closure: (Self) -> Void) {
        closure(self)
    }
}
