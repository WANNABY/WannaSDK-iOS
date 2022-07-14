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
        
        let shoesCells = ModelsListScreen().getShoeCells()
        var errorModels: [String] = []
        
        ModelsListScreen().tapBy(cell: shoesCells[0])
        ModelsListScreen().tapButtonBy(text: ModelsListScreen.Strings.manual.rawValue, timeout: 300)
        
        for i in 0...shoesCells.count {
            RenderScreen().waitingForModelDownload()
            var modelId: String
            if RenderScreen().checkErrorAlert {
                RenderScreen().closeErrorAlert()
                modelId = RenderScreen().getModelId()
                errorModels.append(modelId)
            } else {
                modelId = RenderScreen().getModelId()
                Logger().makeScreenshot(info: "model #\(i): \(modelId)")
            }
            
            if i < shoesCells.count {
                RenderScreen().tapButtonBy(text: RenderScreen.Strings.nextModel.rawValue)
            }
        }

        for model in errorModels {
            Logger().add("Broken model: \(model)")
        }
    }
}
