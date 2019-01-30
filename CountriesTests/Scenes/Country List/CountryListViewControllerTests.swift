//
//  CountryListViewControllerTests.swift
//  CountriesTests
//
//  Created by Elina Batyrova on 24.01.2019.
//  Copyright © 2019 Elina. All rights reserved.
//

@testable import Countries
import XCTest

class CountryListViewControllerTests: XCTestCase {
    
    // MARK: - Instance Properties
    
    fileprivate var viewController: CountryListViewController!
    fileprivate var window: UIWindow!
    
    fileprivate let testDisplayedCountries = [CountryList.ViewModel.DisplayedCountry(uid: 12,
                                                                                     name: "CountryTestName",
                                                                                     capital: "CountryTestCapitalName",
                                                                                     flag: nil,
                                                                                     description: nil)]
    
    // MARK: - Test Lifecycle
    
    override func setUp() {
        super.setUp()
        
        self.window = UIWindow()
        self.setupCountryListViewController()
    }
    
    override func tearDown() {
        self.window = nil
        super.tearDown()
    }
    
    // MARK: - Test Setup
    
    func setupCountryListViewController() {
        let bundle = Bundle.main
        
        let storyboard = UIStoryboard(name: "Main", bundle: bundle)

        self.viewController = storyboard.instantiateViewController(withIdentifier: "CountryListViewController") as? CountryListViewController
    }
    
    func loadView() {
        self.window.addSubview(self.viewController.view)
        
        RunLoop.current.run(until: Date())
    }
    
    // MARK: - Tests
    
    func testShouldFetchCountriesWhenViewDidAppear() {
        // 1. Given
        let countryListBusinessLogicMock = CountryListBusinessLogicMock()
        
        self.viewController.interactor = countryListBusinessLogicMock
        self.loadView()
        
        // 2. When
        self.viewController.viewDidAppear(true)
        
        // 3. Then
        XCTAssert(countryListBusinessLogicMock.fetchCountriesCalled)
    }
    
    func testShouldDisplayFetchedCountries() {
        // 1. Given
        let tableView = TableViewMock()
        self.viewController.tableView = tableView
        
        // 2. When
        let viewModel = CountryList.ViewModel(displayedCountries: self.testDisplayedCountries)
        
        self.viewController.displayCountries(viewModel: viewModel)
        
        // 3. Then
        XCTAssert(tableView.reloadDataCalled)
    }
    
    func testNumberOfRowsShouldEqualNumberOfCountriesToDisplay() {
        // 1. Given
        let tableView = TableViewMock()
        
        self.viewController.tableView = tableView
        
        guard let tableViewDataSource = self.viewController.tableViewDataSource else {
            return
        }
        
        tableViewDataSource.dispayedCountries = self.testDisplayedCountries

        // 2. When
        let numberOfRows = tableViewDataSource.tableView(tableView, numberOfRowsInSection: 0)

        // 3. Then
        XCTAssertEqual(numberOfRows, self.testDisplayedCountries.count)
    }
}

// MARK: - CountryListBusinessLogicMock

class CountryListBusinessLogicMock: CountryListBusinessLogic {
    
    // MARK: - Instance Properties
    
    fileprivate var fetchCountriesCalled = false
    
    // MARK: - Instance Methods
    
    func fetchCountries(request: CountryList.Request) {
        self.fetchCountriesCalled = true
    }
}

// MARK: - TableViewMock

class TableViewMock: UITableView {
    
    // MARK: - Instance Properties
    
    fileprivate var reloadDataCalled = false
    
    // MARK: - Instance Methods
    
    override func reloadData() {
        self.reloadDataCalled = true
    }
}
