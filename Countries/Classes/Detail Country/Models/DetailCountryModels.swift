//
//  DetailCountryModels.swift
//  Countries
//
//  Created by Elina Batyrova on 20/10/2018.
//  Copyright © 2018 Elina. All rights reserved.
//

import Foundation
import UIKit

enum DetailCountry {
    
    // MARK: - Type Properties
    
    struct Request {
    }
    
    struct Response {
        
        // MARK: - Instance Properties
        
        let country: CountryObject
        let loadedImages: [UIImage]
    }
    
    struct ViewModel {
        
        // MARK: - Instance Properties
        
        let images: [UIImage]
        let countryName: String
    }
}
