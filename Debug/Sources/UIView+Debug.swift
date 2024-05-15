// WANNA SDK
// Copyright © 2024 WANNABY Inc. All rights reserved.

import UIKit

@_exported import WsneakersUISDK

 /// Displaying the version of WANNA SDK used, mostly for testing purposes
 public extension UIView {
    func addWannaDebugLabel() {
        let background = makeBackground()
        addSubview(background)
        background.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: 4.0).isActive = true
        background.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 8.0).isActive = true

        let label = makeLabel()
        background.addSubview(label)
        background.trailingAnchor.constraint(equalTo: label.trailingAnchor, constant: 8).isActive = true
        background.leadingAnchor.constraint(equalTo: label.leadingAnchor, constant: -8).isActive = true
        background.topAnchor.constraint(equalTo: label.topAnchor, constant: -2).isActive = true
        background.bottomAnchor.constraint(equalTo: label.bottomAnchor, constant: 2).isActive = true

        label.text = makeText()
    }
}

private extension UIView {
    func makeText() -> String {
        let info = WsneakersUISDKInfo()

        return "SDK Version: " + info.sdkVersion
        + " | meta: " + info.metaVersion
        + " | detector: " + (info.isDetectorEnabled ? "on" : "off")
    }

    func makeLabel() -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14)
        label.textColor = .white
        label.backgroundColor = .clear

        return label
    }

    func makeBackground() -> UIView {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .darkGray.withAlphaComponent(0.85)
        view.layer.cornerRadius = 8
        view.layer.masksToBounds = true

        return view
    }
}
