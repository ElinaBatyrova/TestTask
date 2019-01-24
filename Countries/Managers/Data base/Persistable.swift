//
//  Persistable.swift
//  Countries
//
//  Created by Elina Batyrova on 18.09.2018.
//  Copyright © 2018 Elina. All rights reserved.
//

import Foundation
import RealmSwift

public protocol Persistable {
    
    associatedtype ManagedObject: Object
    
    // MARK: - Initializers
    
    init(managedObject: ManagedObject)
    
    // MARK: - Instance Methods
    
    func managedObject() -> ManagedObject
}
