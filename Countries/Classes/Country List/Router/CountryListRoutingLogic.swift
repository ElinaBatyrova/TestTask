//
//  CountryListRoutingLogic.swift
//  Countries
//
//  Created by Elina Batyrova on 22.10.2018.
//  Copyright © 2018 Elina. All rights reserved.
//

import UIKit

protocol CountryListRoutingLogic {
    
    // MARK: - Instance Methods
    
    func prepareFor(segue: UIStoryboardSegue, sender: Any?)
    func openCountryDetails(countryId: UniqueIdentifier)
}
