//
//  CountryListWorkerTests.swift
//  CountriesTests
//
//  Created by Elina Batyrova on 29.01.2019.
//  Copyright © 2019 Elina. All rights reserved.
//

@testable import Countries
import XCTest

class CountryListWorkerTests: XCTestCase {
    
    // MARK: - Instance Properties
    
    fileprivate var worker: CountryListWorker!
    
    // MARK: - Test Lifecycle
    
    override func setUp() {
        super.setUp()
        
        self.setupCountryListWorker()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    // MARK: - Test Setup
    
    func setupCountryListWorker() {
        self.worker = CountryListWorker()
    }
    
    // MARK: - Tests
    
    func testFetchCountriesShouldReturnCountryList() {
        // 1. Given
        let countriesServiceProtocolMock = CountriesServiceProtocolMock()
        
        self.worker.countriesService = countriesServiceProtocolMock
        
        // 2. When
        var fetchedCountries = [CountryObject]()
        var loadError: LoadError?
        
        let expect = expectation(description: "Wait for getCountriesList() to return array of countries")
        
        self.worker.getCountries(onSuccess: { (countries, images) in
            fetchedCountries = countries
            
            expect.fulfill()
        }) { (error) in
            loadError = error
        }
        
        waitForExpectations(timeout: 1.1)
        
        // 3. Then
        XCTAssertNil(loadError)
        XCTAssert(countriesServiceProtocolMock.fetchCountryListCalled)
        XCTAssertEqual(fetchedCountries.count, countriesServiceProtocolMock.responseArrayCount)
    }
}

// MARK: -

class CountriesServiceProtocolMock: CountriesServiceProtocol {
    
    // MARK: - Instance Properties
    
    fileprivate var fetchCountryListCalled = false
    fileprivate var responseArrayCount = 0
    
    // MARK: - Instance Methods
    
    func getCountriesList(onSuccess: @escaping ([CountryObject]) -> Void, onFailure: @escaping (LoadError?) -> Void) {
        self.fetchCountryListCalled = true
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)) {
            let countryObject = CountryObject()
            countryObject.name = "Russia"
            countryObject.capital = "Moscow"
            
            let response = [countryObject]
            
            self.responseArrayCount = response.count
            
            onSuccess(response)
        }
    }
}
