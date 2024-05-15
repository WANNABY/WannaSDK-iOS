//
//  NavigationViewController.swift
//  WANNA SDK
//
//
//  Copyright © 2019 WANNABY Inc. All rights reserved.
//

import UIKit
import WsneakersUISDK

class NavigationViewController: UINavigationController {
    // We don't support orientation change
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        addInfoLabel()
    }

    // Displaying the version of WANNA SDK used, mostly for testing purposes
    private func addInfoLabel() {
        let sdkInfo = WsneakersUISDKInfo()

        let info = "SDK Version: " + sdkInfo.sdkVersion
        + " | meta: " + sdkInfo.metaVersion
        + " | detector: " + (sdkInfo.isDetectorEnabled ? "on" : "off")

        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14)
        label.text = info
        label.textColor = .white
        label.backgroundColor = .clear

        let background = UIView()
        background.translatesAutoresizingMaskIntoConstraints = false
        background.backgroundColor = .darkGray.withAlphaComponent(0.85)
        background.layer.cornerRadius = 8
        background.layer.masksToBounds = true

        background.addSubview(label)
        background.trailingAnchor.constraint(equalTo: label.trailingAnchor, constant: 8).isActive = true
        background.leadingAnchor.constraint(equalTo: label.leadingAnchor, constant: -8).isActive = true
        background.topAnchor.constraint(equalTo: label.topAnchor, constant: -2).isActive = true
        background.bottomAnchor.constraint(equalTo: label.bottomAnchor, constant: 2).isActive = true

        view.addSubview(background)
        background.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 4.0).isActive = true
        background.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 8.0).isActive = true
    }
}
