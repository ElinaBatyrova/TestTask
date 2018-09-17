//
//  Country.swift
//  Countries
//
//  Created by Elina Batyrova on 13.09.2018.
//  Copyright © 2018 Elina. All rights reserved.
//

import Foundation

struct Country: Codable {
    let name: String
    let continent: String
    let capital: String
    let population: Int
    let description_small: String
    let description: String
    let image: String
    let country_info: CountryInfo
    
    struct CountryInfo: Codable {
        let images: [String]
        let flag: String
    }
}
