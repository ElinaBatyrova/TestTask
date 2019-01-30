//
//  ImageDownloadManagerTests.swift
//  CountriesTests
//
//  Created by Elina Batyrova on 29.01.2019.
//  Copyright © 2019 Elina. All rights reserved.
//

@testable import Countries
import XCTest

class ImageDownloadManagerTests: XCTestCase {
    
    // MARK: - Instance Properties
    
    fileprivate var manager: ImageDownloadManager!
    
    // MARK: - Test Lifecycle
    
    override func setUp() {
        super.setUp()
        
        self.setupImageDownloadManager()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    // MARK: - Test Setup
    
    func setupImageDownloadManager() {
        self.manager = ImageDownloadManager()
    }
    
    // MARK: - Tests
    
    func testDownloadImageShouldReturnImage() {
        // 1. Given
        let imageURL = URL(string: "https://tedideas.files.wordpress.com/2017/05/featured_art_heal_forests.jpg?w=750")
        
        // 2. When
        var loadError: LoadError?
        var downloadedImage: UIImage?
        
        let expect = expectation(description: "Wait for downloadImage() should return image")
        
        self.manager.downloadImage(from: imageURL!, success: { (image) in
            downloadedImage = image
            
            expect.fulfill()
        }) { (errorDescription) in
            loadError = LoadError(message: errorDescription)
        }
        
        waitForExpectations(timeout: 5)
        
        // 3. Then
        XCTAssertNil(loadError)
        XCTAssertNotNil(downloadedImage)
    }
}
