//
//  CountryListModels.swift
//  Countries
//
//  Created by Elina Batyrova on 21.09.2018.
//  Copyright © 2018 Elina. All rights reserved.
//

import Foundation
import UIKit

enum CountryList {
    
    struct Response {
        var countries: [CountryObject]
        var loadedFlagImages: [UIImage?]
    }
    
    struct ViewModel {
        
        struct DisplayedCountry {
            let name: String
            let capital: String
            let flag: UIImage?
            let description: String?
        }
        
        var displayedCountries: [DisplayedCountry]
    }
}
