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
    let errorMessage = "Ошибка при загрузке данных."
    
    init() {
        self.apiProvider = CountriesListApiProvider()
    }

    func getCountriesList(with request: Request, onSuccess: @escaping (CountriesList) -> Void, onFailure: @escaping (LoadError?) -> Void) {
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
            
            onSuccess(countriesList)
        }) { [weak self] (error) in
            guard let strongSelf = self else { return }
            
            onFailure(.error(strongSelf.errorMessage))
        }
    }
}
