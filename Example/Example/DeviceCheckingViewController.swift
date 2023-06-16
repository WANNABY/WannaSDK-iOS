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
    @IBAction func onRunSdk(_ sender: Any) {
        if WsneakersUISDKSession.isDeviceSupported() {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let controller = storyboard.instantiateViewController(withIdentifier: "render_models_list") as! RenderModelSelectionViewController
            controller.setRenderableType(type: "sneaker")
            show(controller, sender: self)
        } else {
            let popup = UIAlertController(title: "Error", message: "Device is not supported", preferredStyle: .alert)
            present(popup, animated: true)
        }
    }
    
    @IBAction func onRunWatchSdk(_ sender: Any) {
        if WsneakersUISDKSession.isDeviceSupported() {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let controller = storyboard.instantiateViewController(withIdentifier: "render_models_list") as! RenderModelSelectionViewController
            controller.setRenderableType(type: "watch")
            show(controller, sender: self)
        } else {
            let popup = UIAlertController(title: "Error", message: "Device is not supported", preferredStyle: .alert)
            present(popup, animated: true)
        }
    }

    @IBAction func onRunClothesSdk(_ sender: Any) {
        if WsneakersUISDKSession.isDeviceSupported() {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let controller = storyboard.instantiateViewController(withIdentifier: "render_models_list") as! RenderModelSelectionViewController
            controller.setRenderableType(type: "clothes")
            show(controller, sender: self)
        } else {
            let popup = UIAlertController(title: "Error", message: "Device is not supported", preferredStyle: .alert)
            present(popup, animated: true)
        }
    }
}

