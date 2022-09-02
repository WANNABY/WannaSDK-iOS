// WANNA SDK
// Copyright © 2022 WANNABY Inc. All rights reserved.


import XCTest


final class ModelsListScreen: BaseScreen {
    
    enum Strings: String {
        case manual = "Manual"
    }
    
    var firstShoeCell: XCUIElement  {
        app.tables.firstMatch.wait().cells.firstMatch
    }
}
