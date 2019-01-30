//
//  CountryListRouterTests.swift
//  CountriesTests
//
//  Created by Elina Batyrova on 30.01.2019.
//  Copyright © 2019 Elina. All rights reserved.
//

@testable import Countries
import XCTest

class CountryListRouterTests: XCTestCase {
    
    // MARK: - Instance Properties
    
    fileprivate var router: CountryListRouter!
    
    // MARK: - Test Lifecycle
    
    override func setUp() {
        super.setUp()
        
        self.setupCountryListRouter()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    // MARK: - Test Setup
    
    func setupCountryListRouter() {
        self.router = CountryListRouter()
    }
    
    // MARK: - Tests
    
    func testOpenDetailCountryShouldAskViewControllerToPerformSegue() {
        // 1. Given
        let countryListViewControllerMock = CountryListViewControllerMock()
        let countryListDataStoreMock = CountryListDataStoreMock()
        
        self.router.viewController = countryListViewControllerMock
        self.router.dataStore = countryListDataStoreMock
        
        // 2. When
        self.router.openCountryDetails(countryId: 0)
        
        // 3. Then
        XCTAssert(countryListViewControllerMock.performSegueCalled)
    }
}

// MARK: - CountryListViewControllerMock

class CountryListViewControllerMock: CountryListViewController {
    
    // MARK: - Instance Properties
    
    fileprivate var performSegueCalled = false
    
    // MARK: - Instance Methods
    
    override func performSegue(withIdentifier identifier: String, sender: Any?) {
        self.performSegueCalled = true
    }
}

// MARK: - CountryListDataStoreMock

class CountryListDataStoreMock: CountryListDataStore {
    
    // MARK: - Instance Properties
    
    var countries: [CountryObject]? = [CountryObject()]
}
