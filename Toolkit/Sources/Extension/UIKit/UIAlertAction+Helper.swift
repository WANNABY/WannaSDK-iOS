// WANNA SDK
// Copyright © 2023 WANNABY Inc. All rights reserved.

import UIKit

public extension UIAlertAction {
    static var `default`: UIAlertAction {
        .default(title: "OK")
    }

    static func `default`(title: String, handler: (() -> ())? = nil) -> UIAlertAction {
        alert(title: title, style: .default, handler: handler)
    }
}

public extension UIAlertAction {
    static var cancel: UIAlertAction {
        .cancel(title: "Cancel")
    }

    static func cancel(title: String, handler: (() -> ())? = nil) -> UIAlertAction {
        alert(title: title, style: .cancel, handler: handler)
    }
}

public extension UIAlertAction {
    static var destructive: UIAlertAction {
        .destructive(title: "Remove")
    }

    static func destructive(title: String, handler: (() -> ())? = nil) -> UIAlertAction {
        alert(title: title, style: .destructive, handler: handler)
    }
}

private extension UIAlertAction {
    static func alert(title: String, style: Style, handler: (() -> ())? = nil) -> UIAlertAction {
        UIAlertAction(title: title, style: style) { _ in
            handler?()
        }
    }
}
