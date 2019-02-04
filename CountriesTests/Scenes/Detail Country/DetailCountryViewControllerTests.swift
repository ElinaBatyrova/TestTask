//
//  DetailCountryViewControllerTests.swift
//  CountriesTests
//
//  Created by Elina Batyrova on 29.01.2019.
//  Copyright © 2019 Elina. All rights reserved.
//

@testable import Countries
import XCTest
import PassKit

class DetailCountryViewControllerTests: XCTestCase {
    
    // MARK: - Instance Properties
    
    fileprivate var viewController: DetailCountryViewController!
    fileprivate var window: UIWindow!
    
    fileprivate let testDisplayedCountry = DetailCountry.ViewModel(images: [UIImage()], countryName: "Russia")
    
    // MARK: - Test Lifecycle
    
    override func setUp() {
        super.setUp()
        
        self.window = UIWindow()
        self.setupDetailCountryViewController()
    }
    
    override func tearDown() {
        self.window = nil
        
        super.tearDown()
    }
    
    // MARK: - Test Setup
    
    func setupDetailCountryViewController() {
        let bundle = Bundle.main
        
        let storyboard = UIStoryboard(name: "Main", bundle: bundle)
        
        self.viewController = storyboard.instantiateViewController(withIdentifier: "DetailCountryViewController") as? DetailCountryViewController
    }
    
    func loadView() {
        self.window.addSubview(self.viewController.view)
        
        RunLoop.current.run(until: Date())
    }
    
    // MARK: - Tests
    
    func testShouldSetupViewWhenViewIsLoaded() {
        // 1. Given
        let detailCountryBusinessLogicMock = DetailCountryBusinessLogicMock()
        
        self.viewController.interactor = detailCountryBusinessLogicMock
        
        // 2. When
        self.loadView()
        
        // 3. Then
        XCTAssert(detailCountryBusinessLogicMock.setupViewCalled)
    }
    
    func testShouldConfigureBusinessLogicWithCountry() {
        // 1. Given
        let detailCountryBusinessLogicMock = DetailCountryBusinessLogicMock()
        
        self.viewController.interactor = detailCountryBusinessLogicMock
        
        let country = CountryObject()
        
        // 2. When
        self.viewController.configure(with: country)
        
        // 3. Then
        XCTAssert(detailCountryBusinessLogicMock.configureBusinessLogicCalled)
    }
    
    func testDetailCountryShouldUpdateCountryNameLabel() {
        // 1. Given
        let detailCountryBusinessLogicMock = DetailCountryBusinessLogicMock()
        
        self.viewController.interactor = detailCountryBusinessLogicMock
        self.loadView()
        
        // 2. When
        self.viewController.displayCountry(viewModel: self.testDisplayedCountry)
        
        // 3. Then
        XCTAssertEqual(self.viewController.countryNameLabel.text, "Russia")
    }
    
    func testDetailCountryShouldAskReloadCollectionView() {
        // 1. Given
        let collectionViewMock = CollectionViewMock(frame: CGRect(x: 0,
                                                                  y: 0,
                                                                  width: 0,
                                                                  height: 0),
                                                    collectionViewLayout: UICollectionViewLayout())
        self.loadView()
        self.viewController.imagesCollectionView = collectionViewMock
        
        // 2. When
        self.viewController.displayCountry(viewModel: self.testDisplayedCountry)
        
        // 3. Then
        XCTAssert(collectionViewMock.reloadDataCalled)
    }
    
    func testNumberOfItemsShouldEqualNumberOfImagesToDisplay() {
        // 1. Given
        let collectionViewMock = CollectionViewMock(frame: CGRect(x: 0,
                                                                  y: 0,
                                                                  width: 0,
                                                                  height: 0),
                                                    collectionViewLayout: UICollectionViewLayout())
        
        self.viewController.imagesCollectionView = collectionViewMock
        
        guard let collectionViewDataSource = self.viewController.collectionViewDataSource else {
            return
        }
        
        collectionViewDataSource.displayedCountry = self.testDisplayedCountry
        
        // 2. When
        let numberOfItems = collectionViewDataSource.collectionView(collectionViewMock, numberOfItemsInSection: 0)
        
        // 3. Then
        XCTAssertEqual(numberOfItems, self.testDisplayedCountry.images.count)
    }
    
    func testImageShouldSetToCollectionViewCell() {
        // 1. Given
        let collectionViewMock = CollectionViewMock(frame: CGRect(x: 0,
                                                                  y: 0,
                                                                  width: 0,
                                                                  height: 0),
                                                    collectionViewLayout: UICollectionViewLayout())
        
        self.viewController.imagesCollectionView = collectionViewMock
        
        guard let collectionViewDataSource = self.viewController.collectionViewDataSource else {
            return
        }
        
        collectionViewDataSource.displayedCountry = self.testDisplayedCountry
        
        // 2. When
        self.viewController.imagesCollectionView.register(UINib(nibName: "ImageCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ImageCollectionViewCell")
        
        let cell = collectionViewDataSource.collectionView(collectionViewMock, cellForItemAt: IndexPath(row: 0, section: 0)) as? ImageCollectionViewCell
        
        // 3. Then
        XCTAssertNotNil(cell?.imageView.image)
    }
}

// MARK: - DetailCountryBusinessLogicMock

class DetailCountryBusinessLogicMock: DetailCountryBusinessLogic {

    // MARK: - Instance Properties
    
    fileprivate var setupViewCalled = false
    fileprivate var configureBusinessLogicCalled = false
    fileprivate var payWithApplePayCalled = false
    
    var isApplePayAvailable: Bool = true

    // MARK: - Instance Methods
    
    func setUpViewWithCountry() {
        self.setupViewCalled = true
    }
    
    func configureBusinessLogic(with object: Any?) {
        self.configureBusinessLogicCalled = true
    }
    
    func payWithApplePay(delegate: PKPaymentAuthorizationControllerDelegate) {
        self.payWithApplePayCalled = true
    }
}

// MARK: - CollectionViewMock

class CollectionViewMock: UICollectionView {
    
    // MARK: - Instance Properties
    
    fileprivate var reloadDataCalled = false
    
    // MARK: - Instance Methods
    
    override func reloadData() {
        self.reloadDataCalled = true
    }
}
