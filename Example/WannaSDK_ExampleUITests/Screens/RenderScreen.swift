// WANNA SDK
// Copyright © 2022 WANNABY Inc. All rights reserved.


import Foundation


final class RenderScreen: BaseScreen {
    
    enum Strings: String {
        case nextModel = "Next Model"
        case back = "Render Models"
        case modelId = "model_id"
    }
    
    func checkErrorAlert() -> Bool {
        app.alerts.firstMatch.wait(5).exists
    }
    
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
    
    func getModelsCount() -> Int {
        let navigationBar = app.navigationBars.firstMatch
        let predicate = NSPredicate(format: "label CONTAINS[c] '/'")
        let navigationBarTitle = navigationBar.staticTexts.containing(predicate).firstMatch.wait().label
        let components = navigationBarTitle.components(separatedBy: "/")
        return Int(components[1])!
    }
}
