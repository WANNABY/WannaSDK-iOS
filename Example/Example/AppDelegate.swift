//
//  AppDelegate.swift
//  WANNA SDK
//
//
//  Copyright © 2019 WANNABY Inc. All rights reserved.
//

import UIKit
import WsneakersUISDK
import WannaCoreSDK

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        // Tell the app to continue displaying content even when the user is doing nothing,
        // to avoid dimming or turning off the screen while virtual try-on is in progress
        application.isIdleTimerDisabled = true

        // For WANNA internal use only.
        if #available(iOS 13.0, *),
         let url = URL(string: "wannasample://wannadebug?meta-version=6.1.0") {

            WannaDebug.deepLinkHandler.handleURL(url)
        }

        var session = UnsafeMutablePointer<WclothesCoreSDKSessionRef?>(nil)
        WclothesCoreSDKSessionCreate(WannaSDKDefaults.clientConfig, session)

        return true
    }

    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {

        // Don't add to production code.
        // For WANNA internal use only.
        if #available(iOS 13.0, *) {
            WannaDebug.deepLinkHandler.handleURL(url)
        }

        return true
    }
}

