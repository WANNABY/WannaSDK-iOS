// WANNA SDK
// Copyright © 2023 WANNABY Inc. All rights reserved.

import UIKit

extension UIView {
    func addToView(_ superview: UIView) {
        superview.addSubview(self)
        superview.addBorderConstraints(to: self)
    }

    func addBorderConstraints(to subview: UIView, constant: CGFloat = 0) {
        subview.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: subview.topAnchor, constant: -constant),
            bottomAnchor.constraint(equalTo: subview.bottomAnchor, constant: constant),
            leadingAnchor.constraint(equalTo: subview.leadingAnchor, constant: -constant),
            trailingAnchor.constraint(equalTo: subview.trailingAnchor, constant: constant)
        ])
    }
}
