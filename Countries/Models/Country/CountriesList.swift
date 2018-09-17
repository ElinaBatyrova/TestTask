//
//  CountriesList.swift
//  Countries
//
//  Created by Elina Batyrova on 13.09.2018.
//  Copyright © 2018 Elina. All rights reserved.
//

import Foundation

struct CountriesList: Codable {
    let next: String
    let countries: [Country]
}
