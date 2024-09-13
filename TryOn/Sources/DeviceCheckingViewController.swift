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
public class DeviceCheckingViewController: UIViewController {
    private var clientConfig: String?

    public func update(clientConfig: String) {
        self.clientConfig = clientConfig
    }
}

private extension DeviceCheckingViewController {
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
        guard WsneakersUISDKSession.isDeviceSupported() else {
            presentAlert(title: "Error", message:  "Device is not supported")
            
            return
        }

        guard let clientConfig else {
            presentAlert(title: "Error", message:  "Client config is nil")

            return
        }

        let bundle = Bundle(for: RenderModelSelectionViewController.self)
        let storyboard = UIStoryboard(name: "TryOn", bundle: bundle)
        let controller = storyboard.instantiateViewController(
            withIdentifier: "render_models_list"
        ) as! RenderModelSelectionViewController
        
        controller.setClientConfig(clientConfig)
        controller.setRenderableType(type)
        controller.setSessionOptions(options)

        show(controller, sender: self)
    }
}

