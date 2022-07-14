// WANNA SDK
// Copyright © 2022 WANNABY Inc. All rights reserved.


import XCTest


final class ModelsListScreen: BaseScreen {
    
    enum Strings: String {
        case manual = "Manual"
    }
    
    private lazy var shoesCells = app.tables.firstMatch.wait().cells.allElementsBoundByIndex
    
    func getShoeCells() -> [XCUIElement] {
        return shoesCells
    }
}
