//
//  CountriesService.swift
//  Countries
//
//  Created by Elina Batyrova on 14.09.2018.
//  Copyright © 2018 Elina. All rights reserved.
//

import Foundation

class CountriesService: CountriesServiceProtocol {
    
    var apiProvider: ApiProvider!
    var container: Container!
    let errorMessage = "Ошибка при загрузке данных."
    
    init() {
        self.apiProvider = CountriesListApiProvider()
        self.container = try! Container()
    }

    func getCountriesList(with request: Request, onSuccess: @escaping (FetchedResults<Country>) -> Void, onFailure: @escaping (LoadError?) -> Void) {
        self.apiProvider.makeRequest(with: request, onSuccess: { [weak self] (data) in
            guard let strongSelf = self else { return }
            
            guard let data = data else {
                onFailure(.error(strongSelf.errorMessage))
                return
            }
            
            guard let countriesList = try? JSONDecoder().decode(CountriesList.self, from: data) else {
                onFailure(.error(strongSelf.errorMessage))
                return
            }
            
            for country in countriesList.countries {
                try! strongSelf.container.write({ (transaction) in
                    transaction.add(country, update: true)
                })
            }
            
            let results = strongSelf.container.values(Country.self)
            
            onSuccess(results)
        }) { [weak self] (error) in
            guard let strongSelf = self else { return }
            
            onFailure(.error(strongSelf.errorMessage))
        }
    }
}
