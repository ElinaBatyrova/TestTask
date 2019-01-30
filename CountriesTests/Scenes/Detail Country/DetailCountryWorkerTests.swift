//
//  DetailCountryWorkerTests.swift
//  CountriesTests
//
//  Created by Elina Batyrova on 29.01.2019.
//  Copyright © 2019 Elina. All rights reserved.
//

@testable import Countries
import XCTest

class DetailCountryWorkerTests: XCTestCase {
    
    // MARK: - Instance Properties
    
    fileprivate var worker: DetailCountryWorker!
    
    // MARK: - Test Lifecycle
    
    override func setUp() {
        super.setUp()
        
        self.setupDetailCountryWorker()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    // MARK: - Test Setup
    
    func setupDetailCountryWorker() {
        self.worker = DetailCountryWorker()
    }
    
    // MARK: - Tests
    
    func testDownloadImageShouldReturnImage() {
        // 1. Given
        let imageDownloadManagerProtocolMock = ImageDownloadManagerProtocolMock()
        
        self.worker.imageDownloadManager = imageDownloadManagerProtocolMock
        
        // 2. When
        var downloadedImages: [UIImage]?
        var loadError: LoadError?
        let expect = expectation(description: "Wait for downloadImage() should return image")
        let stringURL = "https://tedideas.files.wordpress.com/2017/05/featured_art_heal_forests.jpg?w=750"
        
        self.worker.getImages(from: [stringURL], onSuccess: { (imageArray) in
            downloadedImages = imageArray
            
            expect.fulfill()
        }) { (error) in
            loadError = error
        }
        
        waitForExpectations(timeout: 1.1)
        
        // 3. Then
        XCTAssertNil(loadError)
        XCTAssertNotNil(downloadedImages)
    }
}

// MARK: - ImageDownloadManagerProtocolMock

class ImageDownloadManagerProtocolMock: ImageDownloadManagerProtocol {
    
    // MARK: - Instance Properties
    
    fileprivate var downloadImagesCalled = false
    
    // MARK: - Instance Methods
    
    func downloadImage(from url: URL, success: @escaping (UIImage?) -> Void, failure: @escaping (String) -> Void) {
        self.downloadImagesCalled = true
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)) {
            success(UIImage())
        }
    }
}
