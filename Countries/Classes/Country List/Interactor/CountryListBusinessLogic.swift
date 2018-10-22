//
//  CountryListBusinessLogic.swift
//  Countries
//
//  Created by Elina Batyrova on 22.10.2018.
//  Copyright © 2018 Elina. All rights reserved.
//

import Foundation

protocol CountryListBusinessLogic {
    func fetchCountries(request: CountryList.Request)
}
