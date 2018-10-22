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
    struct Request {
    }
    
    struct Response {
        let country: CountryObject
        let loadedImages: [UIImage]
    }
    
    struct ViewModel {
        let images: [UIImage]
        let countryName: String
    }
}
