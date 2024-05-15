//
//  NavigationViewController.swift
//  WANNA SDK
//
//
//  Copyright © 2019 WANNABY Inc. All rights reserved.
//

import UIKit
import WannaDebug

class NavigationViewController: UINavigationController {
    // We don't support orientation change
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        // Don't use in production: add debug label for internal test purposes
        view.addWannaDebugLabel()
    }
}
