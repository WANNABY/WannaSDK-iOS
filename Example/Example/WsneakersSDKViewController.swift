//
//  WsneakersSDKViewController.swift
//  WANNA SDK
//
//
//  Copyright © 2019 WANNABY Inc. All rights reserved.
//

import WsneakersUISDK

@available(iOS 13.0, *)
class WsneakersSDKViewController: TryOnViewController {
    @IBOutlet private weak var sneakersView: WsneakersUISDKView!

    override var tryOnView: WsneakersUISDKView {
        sneakersView
    }
}
