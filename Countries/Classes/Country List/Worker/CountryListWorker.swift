//
//  CountryListWorker.swift
//  Countries
//
//  Created by Elina Batyrova on 21.09.2018.
//  Copyright © 2018 Elina. All rights reserved.
//

import Foundation
import SDWebImage

final class CountryListWorker {
    
    // MARK: - Instance Properties
    
    var countriesService: CountriesServiceProtocol!
    
    // MARK: - Initializers
    
    init() {
        self.countriesService = CountriesService()
    }
    
    // MARK: - Instance Methods
    
    func getCountries(onSuccess: @escaping ([CountryObject], [UIImage?]) -> Void, onFailure: @escaping (LoadError?) -> Void) {
        
        self.countriesService.getCountriesList(onSuccess: { (countries) in
            var loadedImages: [UIImage?] = []
            
            let dispatchGroup = DispatchGroup()
            
            for country in countries {
                dispatchGroup.enter()
                SDWebImageManager.shared().imageDownloader?.downloadImage(with: URL(string: country.flagURL), options: [], progress: nil, completed: { (image, data, error, finished) in
                    
                    loadedImages.append(image)
                    dispatchGroup.leave()
                })
            }
            
            dispatchGroup.notify(queue: .main) {
                onSuccess(countries, loadedImages)
            }
        }) { (error) in
            onFailure(error)
        }
    }
}
