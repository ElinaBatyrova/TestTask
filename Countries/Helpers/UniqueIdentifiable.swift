//
//  UniqueIdentifiable.swift
//  Countries
//
//  Created by Elina Batyrova on 20/10/2018.
//  Copyright © 2018 Elina. All rights reserved.
//

typealias UniqueIdentifier = Int

// MARK: - Протокол определяющий поведение объектов идентифицируемых уникально

protocol UniqueIdentifiable {
    
    // MARK: - Instance Methods
    
    var uid: UniqueIdentifier { get }
}
