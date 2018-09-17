//
//  DatabaseManager.swift
//  Countries
//
//  Created by Elina Batyrova on 13.09.2018.
//  Copyright © 2018 Elina. All rights reserved.
//

import Foundation
import RealmSwift

class DatabaseManager: DatabaseManagerProtocol {
    var database: Realm
    
    init() {
        database = try! Realm()
    }
//
//    func getCountriesLists() -> Results<CountriesList> {
//        let results: Results<CountriesList> = database.objects(CountriesList.self)
//        return results
//    }
//
//    func saveCountriesList(list: CountriesList) {
//        try! database.write {
//            database.add(list)
//        }
//    }
}
