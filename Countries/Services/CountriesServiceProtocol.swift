//
//  CountriesServiceProtocol.swift
//  Countries
//
//  Created by Elina Batyrova on 14.09.2018.
//  Copyright © 2018 Elina. All rights reserved.
//

import Foundation

protocol CountriesServiceProtocol: class {
    func getCountriesList(onSuccess: @escaping ([CountryObject]) -> Void, onFailure: @escaping (LoadError?) -> Void)
}
