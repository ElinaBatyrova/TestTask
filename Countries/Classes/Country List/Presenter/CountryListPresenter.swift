//
//  CountryListPresenter.swift
//  Countries
//
//  Created by Elina Batyrova on 21.09.2018.
//  Copyright © 2018 Elina. All rights reserved.
//

import Foundation

final class CountryListPresenter: CountryListPresentationLogic {
    
    // MARK: - Instance Properties
    
    weak var viewController: CountryListDisplayLogic?
    
    // MARK: - Instance Methods
    
    func presentCountries(response: CountryList.Response) {
        var viewModel = CountryList.ViewModel(displayedCountries: [])
        
        for i in 0..<response.countries.count {
            let country = response.countries[i]
            let flagImage = response.loadedFlagImages[i]
            let displayedCountry = CountryList.ViewModel.DisplayedCountry(uid: i, name: country.name, capital: country.capital, flag: flagImage, description: country.smallDescription)
            viewModel.displayedCountries.append(displayedCountry)
        }
        
        self.viewController?.displayCountries(viewModel: viewModel)
    }
}

