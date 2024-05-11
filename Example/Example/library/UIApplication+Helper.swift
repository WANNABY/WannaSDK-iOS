// WANNA SDK
// Copyright © 2024 WANNABY Inc. All rights reserved.

import UIKit

extension UIApplication {
    var interfaceOrientation: UIInterfaceOrientation? {
        if #available(iOS 13.0, *) {
            return windows.first?.windowScene?.interfaceOrientation
        } else {
            return statusBarOrientation
        }
    }
}
