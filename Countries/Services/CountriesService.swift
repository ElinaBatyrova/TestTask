//
//  CountriesService.swift
//  Countries
//
//  Created by Elina Batyrova on 14.09.2018.
//  Copyright © 2018 Elina. All rights reserved.
//

import Foundation

class CountriesService: CountriesServiceProtocol {
    
    // MARK: - Nested Types
    
    fileprivate enum Constants {
        
        // MARK: - Type Properties
        
        static let errorMessage = "Ошибка при загрузке данных."
        static let endpoint = "https://rawgit.com/NikitaAsabin/799e4502c9fc3e0ea7af439b2dfd88fa/raw/7f5c6c66358501f72fada21e04d75f64474a7888/page1.json"
    }
    
    // MARK: - Instance Properties
    
    fileprivate var apiProvider: ApiProvider!
    fileprivate var container: Container!
    
    // MARK: - Initializers
    
    init() {
        self.apiProvider = CountriesListApiProvider()
        self.container = try! Container()
    }
    
    // MARK: - Instance Methods

    func getCountriesList(onSuccess: @escaping ([CountryObject]) -> Void, onFailure: @escaping (LoadError?) -> Void) {
        let request = GetCountriesListRequest(endpoint: Constants.endpoint)
        
        self.apiProvider.makeRequest(with: request, onSuccess: { [weak self] (data) in
            guard let strongSelf = self else { return }
            
            guard let data = data else {
                onFailure(LoadError(message: Constants.errorMessage))
                return
            }
            
            guard let countriesList = try? JSONDecoder().decode(CountriesList.self, from: data) else {
                onFailure(LoadError(message: Constants.errorMessage))
                return
            }
            
            for country in countriesList.countries {
                try! strongSelf.container.write({ (transaction) in
                    transaction.add(country, update: true)
                })
            }
            
            let results = strongSelf.container.values(Country.self)
            
            var countriesObjects: [CountryObject] = []
            
            for i in 0..<results.count {
                countriesObjects.append(results.value(at: i).managedObject())
            }
            
            onSuccess(countriesObjects)
        }) { (error) in
            onFailure(LoadError(message: Constants.errorMessage))
        }
    }
}
