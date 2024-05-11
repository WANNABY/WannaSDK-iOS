// WANNA SDK
// Copyright © 2023 WANNABY Inc. All rights reserved.

import UIKit

extension UIViewController {
    func presentAlert(title: String, message: String, actions: [UIAlertAction]? = nil, animated: Bool = true) {
        let alert = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert
        )

        for action in actions ?? [.default] {
            alert.addAction(action)
        }

        present(alert, animated: animated)
    }

    func presentAlert(title: String, error: Error?) {
        presentAlert(title: title, message: error?.localizedDescription ?? "Unexpected: no error")
    }
}
