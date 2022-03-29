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
        let info = "SDK Version: " + WsneakersUISDKInfo().coreSDKVersion()

        let label = UILabel()
        label.font = .systemFont(ofSize: 13)
        label.text = info
        label.textColor = .green
        label.backgroundColor = .darkGray.withAlphaComponent(0.5)
        label.translatesAutoresizingMaskIntoConstraints = false

        UIApplication.shared.keyWindow?.addSubview(label)
        label.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16.0).isActive = true
        label.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 8.0).isActive = true
    }
}
