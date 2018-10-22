//
//  DetailCountryDisplayLogic.swift
//  Countries
//
//  Created by Elina Batyrova on 22.10.2018.
//  Copyright © 2018 Elina. All rights reserved.
//

import Foundation

protocol DetailCountryDisplayLogic: class {
    func displayCountry(viewModel: DetailCountry.ViewModel)
    func displayError(with message: String?)
}
