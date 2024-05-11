// WANNA SDK
// Copyright © 2023 WANNABY Inc. All rights reserved.

import UIKit

public extension UIAlertController {
    func addAction(
        title: String,
        style: UIAlertAction.Style = .default,
        handler: @escaping () -> ()
    ) {
        addAction(UIAlertAction(title: title, style: style) { _ in
            handler()
        })
    }
}
