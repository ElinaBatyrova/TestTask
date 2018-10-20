//
//  UniqueIdentifiable.swift
//  Countries
//
//  Created by Elina Batyrova on 20/10/2018.
//  Copyright © 2018 Elina. All rights reserved.
//

typealias UniqueIdentifier = Int

/// Протокол определяющий поведение объектов идентифцируемых уникально
protocol UniqueIdentifiable {
    var uid: UniqueIdentifier { get }
}
