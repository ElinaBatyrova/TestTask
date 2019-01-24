//
//  Country.swift
//  Countries
//
//  Created by Elina Batyrova on 13.09.2018.
//  Copyright © 2018 Elina. All rights reserved.
//

import Foundation
import RealmSwift

struct Country: Codable {
    
    // MARK: - Instance Properties
    
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

// MARK: - Persistable

extension Country: Persistable {
    
    // MARK: - Initializers
    
    public init(managedObject: CountryObject) {
        name = managedObject.name
        continent = managedObject.continent
        capital = managedObject.capital
        population = managedObject.population
        description_small = managedObject.smallDescription
        description = managedObject.countryDescription
        image = managedObject.imageURL
        country_info = CountryInfo.init(images: Array(managedObject.imagesURLs), flag: managedObject.flagURL)
    }
    
    // MARK: - Instance Methods
    
    public func managedObject() -> CountryObject {
        let country = CountryObject()
        
        country.name = name
        country.continent = continent
        country.capital = capital
        country.population = population
        country.smallDescription = description_small
        country.countryDescription = description
        country.imageURL = image
        let images = List<String>()
        for image in country_info.images {
            images.append(image)
        }
        country.imagesURLs = images
        country.flagURL = country_info.flag
        
        return country
    }
}
