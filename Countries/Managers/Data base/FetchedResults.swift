//
//  FetchedResults.swift
//  Countries
//
//  Created by Elina Batyrova on 18.09.2018.
//  Copyright © 2018 Elina. All rights reserved.
//

import Foundation
import RealmSwift

public final class FetchedResults<T: Persistable> {
    
    internal let results: Results<T.ManagedObject>
    
    public var count: Int {
        return results.count
    }
    
    internal init(results: Results<T.ManagedObject>) {
        self.results = results
    }
    
    public func value(at index: Int) -> T {
        return T(managedObject: results[index])
    }
}
