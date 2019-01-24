//
//  WriteTransaction.swift
//  Countries
//
//  Created by Elina Batyrova on 18.09.2018.
//  Copyright © 2018 Elina. All rights reserved.
//

import Foundation
import RealmSwift

public final class WriteTransaction {
    
    // MARK: - Instance Properties
    
    private let realm: Realm
    
    // MARK: - Initializers
    
    internal init(realm: Realm){
        self.realm = realm
    }
    
    // MARK: - Instance Methods
    
    public func add<T: Persistable>(_ value: T, update: Bool) {
        realm.add(value.managedObject(), update: update)
    }
}
