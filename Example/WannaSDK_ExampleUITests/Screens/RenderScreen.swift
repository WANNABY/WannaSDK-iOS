// WANNA SDK
// Copyright © 2022 WANNABY Inc. All rights reserved.


import Foundation


final class RenderScreen: BaseScreen {
    
    enum Strings: String {
        case nextModel = "Next Model"
        case back = "Models"
        case modelId = "model_id"
    }
    
    var modelId: String {
        app.staticTexts[Strings.modelId.rawValue].firstMatch.label
    }
    
    func checkErrorAlert() -> Bool {
        app.alerts.firstMatch.wait(Constants.shortWaitInterval).exists
    }
    
    func waitingForModelDownload(timeout: TimeInterval = Constants.longWaitInterval) {
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
    
    var modelsCount: Int {
        let navigationBar = app.navigationBars.firstMatch
        let predicate = NSPredicate(format: "label CONTAINS[c] '/'")
        let navigationBarTitle = navigationBar.staticTexts.containing(predicate).firstMatch.wait().label
        let components = navigationBarTitle.components(separatedBy: "/")
        return Int(components[1])!
    }
}
