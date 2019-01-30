//
//  CountryListInteractorTests.swift
//  CountriesTests
//
//  Created by Elina Batyrova on 24.01.2019.
//  Copyright © 2019 Elina. All rights reserved.
//

@testable import Countries
import XCTest

class CountryListInteractorTests: XCTestCase {
    
    // MARK: - Instance Properties
    
    fileprivate var interactor: CountryListInteractor!
    
    // MARK: - Test Lifecycle
    
    override func setUp() {
        super.setUp()
        
        self.setupCountryListInteractor()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    // MARK: - Test Setup
    
    func setupCountryListInteractor() {
        self.interactor = CountryListInteractor()
    }
    
    // MARK: - Tests
    
    func testFetchCountriesShouldAskWorkerToFetchCountriesAndPresenterToFormatResult() {
        // 1. Given
        let countryListPresentationLogicMock = CountryListPresentationLogicMock()
        let countryListWorkerMock = CountryListWorkerMock()
        
        self.interactor.presenter = countryListPresentationLogicMock
        self.interactor.worker = countryListWorkerMock
        
        // 2. When
        let request = CountryList.Request()
        
        self.interactor.fetchCountries(request: request)
        
        // 3. Then
        XCTAssert(countryListWorkerMock.fetchCountriesCalled)
        XCTAssert(countryListPresentationLogicMock.presentFetchedCountriesCalled)
    }
}

// MARK: - CountryListPresentationLogicMock

class CountryListPresentationLogicMock: CountryListPresentationLogic {

    // MARK: - Instance Properties
    
    fileprivate var presentFetchedCountriesCalled = false
    fileprivate var presentErrorCalled = false
    
    // MARK: - Instance Methods
    
    func presentCountries(response: CountryList.Response) {
        self.presentFetchedCountriesCalled = true
    }
    
    func present(error: LoadError) {
        self.presentErrorCalled = true
    }
}

// MARK: - CountryListWorkerMock

class CountryListWorkerMock: CountryListWorkerProtocol {
    
    // MARK: - Instance Properties
    
    fileprivate var fetchCountriesCalled = false
    
    // MARK: - Instance Methods
    
    func getCountries(onSuccess: @escaping ([CountryObject], [UIImage?]) -> Void, onFailure: @escaping (LoadError?) -> Void) {
        self.fetchCountriesCalled = true
        
        onSuccess([CountryObject()], [])
    }
}
