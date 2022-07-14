//
//  ModelsListScreen.swift
//  WannaSDK_ExampleUITests
//
//  Created by Nikita Kuznetsov on 14/07/2022.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

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
