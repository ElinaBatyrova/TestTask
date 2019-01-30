//
//  CountryObject.swift
//  Countries
//
//  Created by Elina Batyrova on 17.09.2018.
//  Copyright © 2018 Elina. All rights reserved.
//

import Foundation
import RealmSwift

final class CountryObject: Object {
    
    // MARK: - Instance Properties
    
    @objc dynamic var name = ""
    @objc dynamic var continent = ""
    @objc dynamic var capital = ""
    @objc dynamic var population = 0
    @objc dynamic var smallDescription = ""
    @objc dynamic var countryDescription = ""
    @objc dynamic var imageURL = ""
    var imagesURLs: List<String> = List<String>()
    @objc dynamic var flagURL = ""
    
    // MARK: - Instance Methods
    
    override static func primaryKey() -> String? {
        return "name"
    }
}

//class ImagesURLs {
//
//    // MARK: - Instance Properties
//
//    var values: [String]
//
//    // MARK: - Initializers
//
//    init(values: [String]) {
//        self.values = values
//    }
//}
