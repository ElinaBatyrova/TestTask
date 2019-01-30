//
//  CountryListPresentationLogic.swift
//  Countries
//
//  Created by Elina Batyrova on 22.10.2018.
//  Copyright © 2018 Elina. All rights reserved.
//

import Foundation

protocol CountryListPresentationLogic {
    
    // MARK: - Instance Methods
    
    func presentCountries(response: CountryList.Response)
    func present(error: LoadError)
}
