//
//  DeviceCheckingViewController.swift
//  WANNA SDK
//
//
//  Copyright © 2019 WANNABY Inc. All rights reserved.
//

import UIKit
import WsneakersUISDK

// This is where we check that the SDK can run on the device
// If yes, move on to the 3D model selection view
// If no, display an error
class DeviceCheckingViewController: UIViewController {
    @IBAction func runSneakers() {
        runSdk(type: .sneaker)
    }

    @IBAction func runWatch() {
        runSdk(type: .watch)
    }

    @IBAction func runWatchInMirror() {
        runSdk(type: .watch, options: .magicMirror)
    }

    @IBAction func runClothes() {
        runSdk(type: .clothes)
    }

    func runSdk(type: RenderableType, options: WannaSessionOptions = []) {
        guard WsneakersUISDKSession.isDeviceSupported()  else {
            presentAlert(title: "Error", message:  "Device is not supported")
            
            return
        }
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(
            withIdentifier: "render_models_list"
        ) as! RenderModelSelectionViewController
        
        controller.setRenderableType(type)
        controller.setSessionOptions(options)

        show(controller, sender: self)
    }
}

