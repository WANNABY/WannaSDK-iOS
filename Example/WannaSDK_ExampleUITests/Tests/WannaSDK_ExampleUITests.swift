// WANNA SDK
// Copyright © 2022 WANNABY Inc. All rights reserved.


import XCTest
import Foundation


class WannaSDK_ExampleUITests: XCTestCase {

    override func setUpWithError() throws {
        continueAfterFailure = false
        let app = XCUIApplication()
        app.launch()
        let safari = Safari()
        let imageUrl = "https://s2.favim.com/orig/32/brown-converse-cute-girl-hot-Favim.com-253926.jpg"
        safari.openDeeplink("wannasample://wannadebug?fake-camera-input=\(imageUrl)")
    }

    func testClicklAllModels() {
        
        MainScreen().tapButtonBy(text: MainScreen.Strings.shoes.rawValue)
        
        var errorModels: [String] = []
        ModelsListScreen().apply() {
            $0.tapBy(cell: ModelsListScreen().getShoeCell())
            $0.grantCameraPermission()
            $0.tapButtonBy(text: ModelsListScreen.Strings.manual.rawValue, timeout: 300)
        }
        
        RenderScreen().apply {
            let shoeCount = $0.getModelsCount()
            for i in 1...shoeCount {
                $0.waitingForModelDownload()
                var modelId: String
                if $0.checkErrorAlert() {
                    $0.closeErrorAlert()
                    modelId = $0.modelId
                    errorModels.append(modelId)
                } else {
                    modelId = $0.modelId
                    Logger().makeScreenshot(info: "model #\(i): \(modelId)")
                }
                
                if i < shoeCount {
                    $0.tapButtonBy(text: RenderScreen.Strings.nextModel.rawValue)
                }
            }
        }

        for model in errorModels {
            Logger().add("Broken model: \(model)")
        }
    }
}
