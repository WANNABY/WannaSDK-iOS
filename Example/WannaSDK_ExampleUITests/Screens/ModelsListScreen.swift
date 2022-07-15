// WANNA SDK
// Copyright © 2022 WANNABY Inc. All rights reserved.


import XCTest


final class ModelsListScreen: BaseScreen {
    
    enum Strings: String {
        case manual = "Manual"
    }
    
    private lazy var firstShoeCell = app.tables.firstMatch.wait().cells.firstMatch
    
    func getShoeCell() -> XCUIElement {
        return firstShoeCell
    }
}
