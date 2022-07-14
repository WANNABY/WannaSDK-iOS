//
//  RenderScreen.swift
//  WannaSDK_ExampleUITests
//
//  Created by Nikita Kuznetsov on 14/07/2022.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import Foundation


final class RenderScreen: BaseScreen {
    
    enum Strings: String {
        case nextModel = "Next Model"
        case back = "Render Models"
        case modelId = "model_id"
    }
    
    lazy var checkErrorAlert = app.alerts.firstMatch.wait(5).exists
    
    func waitingForModelDownload(timeout: TimeInterval = 60) {
        logger.add("Waiting for model download") {
            app.progressIndicators.firstMatch.waitUntil(predicate: .notExists, timeout: timeout)
            app.activityIndicators.firstMatch.waitUntil(predicate: .notExists, timeout: timeout)
        }
    }
    
    func closeErrorAlert() {
        logger.add("Close error alert") {
            app.alerts.firstMatch.buttons.firstMatch.tap()
        }
    }
    
    func getModelId() -> String {
        return app.staticTexts[Strings.modelId.rawValue].firstMatch.label
    }
}
