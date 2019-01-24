//
//  DetailCountryPresenter.swift
//  Countries
//
//  Created by Elina Batyrova on 20/10/2018.
//  Copyright © 2018 Elina. All rights reserved.
//

import Foundation

class DetailCountryPresenter: DetailCountryPresentationLogic {
    
    // MARK: - Instance Properties
    
    weak var viewController: DetailCountryDisplayLogic?
    
    // MARK: - Instance Methods
    
    func presentCountry(response: DetailCountry.Response) {
        let viewModel = DetailCountry.ViewModel(images: response.loadedImages, countryName: response.country.name)
        
        self.viewController?.displayCountry(viewModel: viewModel)
    }
    
    func presentError(with message: String?) {
        self.viewController?.displayError(with: message)
    }
}
