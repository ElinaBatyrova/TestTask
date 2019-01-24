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
    
    // MARK: - Type Properties
    
    struct Request {
    }
    
    struct Response {
        
        // MARK: - Instance Properties
        
        var countries: [CountryObject]
        var loadedFlagImages: [UIImage?]
    }
    
    struct ViewModel {
        
        // MARK: - Type Properties
        
        struct DisplayedCountry {
            
            // MARK: - Instance Properties
            
            let uid: UniqueIdentifier
            let name: String
            let capital: String
            let flag: UIImage?
            let description: String?
        }
        
        var displayedCountries: [DisplayedCountry]
    }
}
