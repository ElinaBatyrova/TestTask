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

extension Country: Persistable {
    
    public init(managedObject: CountryObject) {
        name = managedObject.name
        continent = managedObject.continent
        capital = managedObject.capital
        population = managedObject.population
        description_small = managedObject.smallDescription
        description = managedObject.countryDescription
        image = managedObject.imageURL
        country_info = CountryInfo.init(images: managedObject.imagesURLs.values, flag: managedObject.flagURL)
    }
    
    public func managedObject() -> CountryObject {
        let country = CountryObject()
        
        country.name = name
        country.continent = continent
        country.capital = capital
        country.population = population
        country.smallDescription = description_small
        country.countryDescription = description
        country.imageURL = image
        country.imagesURLs = ImagesURLs.init(values: country_info.images)
        country.flagURL = country_info.flag
        
        return country
    }
}
