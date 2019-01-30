//
//  DetailCountryInteractor.swift
//  Countries
//
//  Created by Elina Batyrova on 03.10.2018.
//  Copyright © 2018 Elina. All rights reserved.
//

import Foundation

final class DetailCountryInteractor: DetailCountryBusinessLogic, DetailCountryDataStore {
    
    // MARK: - Instance Properties
    
    var presenter: DetailCountryPresentationLogic?
    var worker: DetailCountryWorkerProtocol = DetailCountryWorker()
    var country: CountryObject?
    
    // MARK: - Instance Methods
    
    func setUpViewWithCountry() {
        var imagesURLs: [String] = []
        
        guard let stringURLs = self.country?.imagesURLs else {
            return
        }
        
        for string in stringURLs{
            imagesURLs.append(string)
        }
        
        self.worker.getImages(from: imagesURLs, onSuccess: { (images) in
            if let presenter = self.presenter, let country = self.country {
                let countryResponse = DetailCountry.Response(country: country, loadedImages: images)
                
                presenter.presentCountry(response: countryResponse)
            }
        }) { [weak self] (error) in
            guard let strongSelf = self else {
                return
            }
            
            strongSelf.presenter?.presentError(with: error?.message)
        }
    }
    
    func configureBusinessLogic(with object: Any?) {
        if let country = object as? CountryObject {
            self.country = country
        }
    }
}
