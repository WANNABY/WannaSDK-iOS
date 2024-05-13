// WANNA SDK
// Copyright © 2024 WANNABY Inc. All rights reserved.

import UIKit

public extension UIApplication {
    var interfaceOrientation: UIInterfaceOrientation? {
        if #available(iOS 13.0, *) {
            return windowScene?.interfaceOrientation
        } else {
            return statusBarOrientation
        }
    }

    @available(iOS 13.0, *)
    var windowScene: UIWindowScene? {
        if #available(iOS 15.0, *) {
            return UIApplication.shared
                .connectedScenes
                .compactMap {
                    $0 as? UIWindowScene
                }
                .first {
                    $0.activationState == .foregroundActive
                }
        } else {
            return windows.first?.windowScene
        }
    }
}

private extension UIApplication {

}
