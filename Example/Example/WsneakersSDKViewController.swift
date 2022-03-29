//
//  WsneakersSDKViewController.swift
//  WANNA SDK
//
//
//  Copyright © 2019 WANNABY Inc. All rights reserved.
//

import WsneakersUISDK

class WsneakersSDKViewController: WsneakersGeneralViewController {
    @IBOutlet weak var sneakersView: WsneakersUISDKView!

    override func createView() -> WsneakersUISDKView {
        return sneakersView;
    }
}
