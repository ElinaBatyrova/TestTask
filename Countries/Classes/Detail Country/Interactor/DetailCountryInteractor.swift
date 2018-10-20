//
//  DetailCountryInteractor.swift
//  Countries
//
//  Created by Elina Batyrova on 03.10.2018.
//  Copyright © 2018 Elina. All rights reserved.
//

import Foundation

protocol DetailCountryBusinessLogic {
    func setUpViewWithCountry()
    func configureBusinessLogic(with object: Any?)
}

protocol DetailCountryDataStore {
    var country: CountryObject? { get set }
}

final class DetailCountryInteractor: DetailCountryBusinessLogic, DetailCountryDataStore {
    
    var presenter: DetailCountryPresentationLogic?
    var worker = DetailCountryWorker()
    var country: CountryObject?
    
    func setUpViewWithCountry() {
        var imagesURLs: [String] = []
        
        guard let stringURLs = self.country?.imagesURLs else { return }
        
        for string in stringURLs{
            imagesURLs.append(string)
        }
        
        self.worker.getImages(from: imagesURLs, onSuccess: { (images) in
            
            if let presenter = self.presenter, let country = self.country {
                let countryResponse = DetailCountry.Response(country: country, loadedImages: images)
                
                presenter.presentCountry(response: countryResponse)
            }
        }) { (error) in
//            TODO
        }
    }
    
    func configureBusinessLogic(with object: Any?) {
        if let country = object as? CountryObject {
            self.country = country
        }
    }
}
