//
//  DetailCountryPresenterTests.swift
//  CountriesTests
//
//  Created by Elina Batyrova on 29.01.2019.
//  Copyright © 2019 Elina. All rights reserved.
//

@testable import Countries
import XCTest

class DetailCountryPresenterTests: XCTestCase {
    
    // MARK: - Instance Properties
    
    fileprivate var presenter: DetailCountryPresenter!
    
    // MARK: - Test Lifecycle
    
    override func setUp() {
        super.setUp()
        
        self.setupDetailCountryPresenter()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    // MARK: - Test Setup
    
    func setupDetailCountryPresenter() {
        self.presenter = DetailCountryPresenter()
    }
    
    // MARK: - Tests
    
    func testPresentCountryShouldAskViewControllerToDisplayCountry() {
        // 1. Given
        let detailCountryDisplayLogicMock = DetailCountryDisplayLogicMock()
        
        self.presenter.viewController = detailCountryDisplayLogicMock
        
        // 2. When
        let countryObject = CountryObject()
        let country = DetailCountry.Response(country: countryObject, loadedImages: [])
        
        self.presenter.presentCountry(response: country)
        
        // 3. Then
        XCTAssert(detailCountryDisplayLogicMock.displayCountryCalled)
    }
    
    func testPresentCountryShouldFormatCountryToDisplay() {
        // 1. Given
        let detailCountryDisplayLogicMock = DetailCountryDisplayLogicMock()
        
        self.presenter.viewController = detailCountryDisplayLogicMock
        
        // 2. When
        let countryObject = CountryObject()
        countryObject.name = "Russia"
        
        let country = DetailCountry.Response(country: countryObject, loadedImages: [])
        
        self.presenter.presentCountry(response: country)
        
        // 3. Then
        let displayedCountry = detailCountryDisplayLogicMock.displayedViewModel
        
        XCTAssertEqual(displayedCountry?.countryName, "Russia")
        XCTAssertEqual(displayedCountry?.images, [])
    }
}

// MARK: - DetailCountryDisplayLogicMock

class DetailCountryDisplayLogicMock: DetailCountryDisplayLogic {
    
    // MARK: - Instance Properties
    
    fileprivate var displayCountryCalled = false
    fileprivate var displayErrorCalled = false
    
    fileprivate var displayedViewModel: DetailCountry.ViewModel!

    // MARK: - Instance Methods
    
    func displayCountry(viewModel: DetailCountry.ViewModel) {
        self.displayCountryCalled = true
        self.displayedViewModel = viewModel
    }
    
    func displayError(with message: String?) {
        self.displayErrorCalled = true
    }
}
