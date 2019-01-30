//
//  CountriesUITests.swift
//  CountriesUITests
//
//  Created by Elina Batyrova on 11.09.2018.
//  Copyright © 2018 Elina. All rights reserved.
//

import XCTest

class CountriesUITests: XCTestCase {
    
    // MARK: - Instance Properties
    
    fileprivate var app: XCUIApplication!
    
    // MARK: - Test Lifecycle
        
    override func setUp() {
        super.setUp()
        
        continueAfterFailure = false

        self.setupApplicationForUITesting()
    }
    
    override func tearDown() {
        self.app = nil
        
        super.tearDown()
    }
    
    // MARK: - Test Setup
    
    func setupApplicationForUITesting() {
        self.app = XCUIApplication()
        self.app.launchArguments.append("--uitesting")
    }
    
    // MARK: - Tests
    
    func testTapOnCellShouldOpenDetailController() {
        // 1. Given
        let tablesQuery = app.tables
        
        // 2. When
        self.app.launch()
        
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Канберра"]/*[[".cells.staticTexts[\"Канберра\"]",".staticTexts[\"Канберра\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        // 3. Then
        XCTAssert(self.app.staticTexts["Австралия"].exists)
    }
    
    func testTapToBackShouldReturnToTable() {
        // 1. Given
        let tablesQuery = app.tables
        
        // 2. When
        self.app.launch()
        
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Канберра"]/*[[".cells.staticTexts[\"Канберра\"]",".staticTexts[\"Канберра\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        sleep(1)
        
        let backButton = self.app.navigationBars["Countries.DetailCountryView"].buttons["Countries"]
        
        _ = backButton.waitForExistence(timeout: 5)
        
        backButton.tap()
        
        // 3. Then
        XCTAssert(self.app.staticTexts["Абхазия"].exists)
    }
}

