//
//  DetailCountryPresentationLogic.swift
//  Countries
//
//  Created by Elina Batyrova on 22.10.2018.
//  Copyright © 2018 Elina. All rights reserved.
//

import Foundation

protocol DetailCountryPresentationLogic {
    
    // MARK: - Instance Methods
    
    func presentCountry(response: DetailCountry.Response)
    func presentError(with message: String?)
}
