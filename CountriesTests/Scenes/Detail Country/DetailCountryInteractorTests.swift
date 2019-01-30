//
//  DetailCountryInteractorTests.swift
//  CountriesTests
//
//  Created by Elina Batyrova on 29.01.2019.
//  Copyright © 2019 Elina. All rights reserved.
//

@testable import Countries
import XCTest
import RealmSwift

class DetailCountryInteractorTests: XCTestCase {
    
    // MARK: - Instance Properties
    
    fileprivate var interactor: DetailCountryInteractor!
    
    // MARK: - Test Lifecycle
    
    override func setUp() {
        super.setUp()
        self.setupDetailCountryInteractor()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    // MARK: - Test Setup
    
    func setupDetailCountryInteractor() {
        self.interactor = DetailCountryInteractor()
    }
    
    // MARK: - Tests
    
    func testSetupViewShouldAskPresenterToFormatResult() {
        // 1. Given
        let detailCountryPresentationLogicMock = DetailCountryPresentationLogicMock()
        
        let country = CountryObject()
        country.imagesURLs = List<String>()
        
        let detailCountryWorkerProtocolMock = DetailCountryWorkerProtocolMock()
        
        self.interactor.presenter = detailCountryPresentationLogicMock
        self.interactor.worker = detailCountryWorkerProtocolMock
        self.interactor.country = country
        
        // 2. When
        self.interactor.setUpViewWithCountry()
                
        // 3. Then
        XCTAssert(detailCountryWorkerProtocolMock.getImagesCalled)
        XCTAssert(detailCountryPresentationLogicMock.presentCountryCalled)
    }
}

// MARK: - DetailCountryPresentationLogicMock

class DetailCountryPresentationLogicMock: DetailCountryPresentationLogic {

    // MARK: - Instance Properties
    
    fileprivate var presentCountryCalled = false
    fileprivate var presentErrorCalled = false
    
    // MARK: - Instance Methods
    
    func presentCountry(response: DetailCountry.Response) {
        self.presentCountryCalled = true
    }
    
    func presentError(with message: String?) {
        self.presentErrorCalled = true
    }
}

// MARK: - DetailCountryWorkerProtocolMock

class DetailCountryWorkerProtocolMock: DetailCountryWorkerProtocol {
    
    // MARK: - Instance Properties
    
    fileprivate var getImagesCalled = false
    
    // MARK: - Instance Methods
    
    func getImages(from urls: [String], onSuccess: @escaping ([UIImage]) -> Void, onFailure: @escaping (LoadError?) -> Void) {
        self.getImagesCalled = true
        
        onSuccess([])
    }
}
