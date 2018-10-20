//
//  CountryListInteractor.swift
//  Countries
//
//  Created by Elina Batyrova on 21.09.2018.
//  Copyright © 2018 Elina. All rights reserved.
//

import Foundation

protocol CountryListBusinessLogic: AnyObject {
    func fetchCountries(request: CountryList.Request)
}

protocol CountryListDataStore: AnyObject {
    var countries: [CountryObject]? { get }
}

class CountryListInteractor: CountryListBusinessLogic, CountryListDataStore {
    
    var presenter: CountryListPresentationLogic?
    var worker: CountryListWorker?
    
    var countries: [CountryObject]?
    
    func fetchCountries(request: CountryList.Request) {
        self.worker?.getCountries(onSuccess: { [weak self] (countries, loadedImages) in
            guard let strongSelf = self else { return }
            self?.countries = countries
            
            let response = CountryList.Response(countries: countries, loadedFlagImages: loadedImages)
            
            strongSelf.presenter?.presentCountries(response: response)
            }, onFailure: { [weak self] (error) in
                guard let strongSelf = self else { return }
                //            TODO
        })
    }
}
