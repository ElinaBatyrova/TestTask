//
//  DetailCountryPresenter.swift
//  Countries
//
//  Created by Elina Batyrova on 20/10/2018.
//  Copyright © 2018 Elina. All rights reserved.
//

import Foundation

protocol DetailCountryPresentationLogic {
    func presentCountry(response: DetailCountry.Response)
}

class DetailCountryPresenter: DetailCountryPresentationLogic {
    
    weak var viewController: DetailCountryDisplayLogic?
    
    func presentCountry(response: DetailCountry.Response) {
        let viewModel = DetailCountry.ViewModel(images: response.loadedImages)
        
        self.viewController?.displayCountry(viewModel: viewModel)
    }
}
