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
    var countriesService: CountriesServiceProtocol!
    
    init() {
        self.countriesService = CountriesService()
    }
    
    func getCountries(onSuccess: @escaping ([CountryObject], [UIImage?]) -> Void, onFailure: @escaping (LoadError?) -> Void) {
        let request = GetCountriesListRequest(endpoint: "https://rawgit.com/NikitaAsabin/799e4502c9fc3e0ea7af439b2dfd88fa/raw/7f5c6c66358501f72fada21e04d75f64474a7888/page1.json")
        
        self.countriesService.getCountriesList(with: request, onSuccess: { (countries) in
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
