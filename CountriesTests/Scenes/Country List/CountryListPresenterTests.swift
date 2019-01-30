//
//  CountryListPresenterTests.swift
//  CountriesTests
//
//  Created by Elina Batyrova on 24.01.2019.
//  Copyright © 2019 Elina. All rights reserved.
//

@testable import Countries
import XCTest

class CountryListPresenterTests: XCTestCase {
    
    // MARK: - Instance Properties
    
    fileprivate var presenter: CountryListPresenter!
    
    // MARK: - Test Lifecycle
    
    override func setUp() {
        super.setUp()
        
        self.setupCountryListPresenter()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    // MARK: - Test Setup
    
    func setupCountryListPresenter() {
        self.presenter = CountryListPresenter()
    }
    
    // MARK: - Tests
    
    func testPresentFetchedCountriesShouldFormatFetchedCountriesForDisplay() {
        // 1. Given
        let countryListDisplayLogicMock = CountryListDisplayLogicMock()
        
        self.presenter.viewController = countryListDisplayLogicMock
        
        // 2. When
        let country = CountryObject()
        country.name = "Russia"
        country.capital = "Moscow"
        
        let response = CountryList.Response(countries: [country], loadedFlagImages: [nil])
        
        self.presenter.presentCountries(response: response)
        
        // 3. Then
        let displayedCountries = countryListDisplayLogicMock.viewModel.displayedCountries
        
        for countryViewModel in displayedCountries {
            XCTAssertEqual(countryViewModel.name, "Russia")
            XCTAssertEqual(countryViewModel.capital, "Moscow")
        }
    }
}

// MARK: - CountryListDisplayLogicMock

class CountryListDisplayLogicMock: CountryListDisplayLogic {

    // MARK: - Instance Properties
    
    fileprivate var displayFetchedCountriesCalled = false
    fileprivate var displayErrorCalled = false
    
    fileprivate var viewModel: CountryList.ViewModel!
    
    // MARK: - Instance Methods
    
    func displayCountries(viewModel: CountryList.ViewModel) {
        self.displayFetchedCountriesCalled = true
        self.viewModel = viewModel
    }
    
    func displayError(with message: String?) {
        self.displayErrorCalled = true
    }
}
