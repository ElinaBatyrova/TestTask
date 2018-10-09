//
//  DetailCountryRouter.swift
//  Countries
//
//  Created by Elina Batyrova on 03.10.2018.
//  Copyright © 2018 Elina. All rights reserved.
//

import Foundation

protocol DetailCountryRoutingLogic {
    
}

protocol DetailCountryDataPassing {
    var dataStore: DetailCountryDataStore? { get }
}

final class DetailCountryRouter: DetailCountryRoutingLogic, DetailCountryDataPassing {
    
    weak var viewController: DetailCountryViewController?
    var dataStore: DetailCountryDataStore?
    
    
}
