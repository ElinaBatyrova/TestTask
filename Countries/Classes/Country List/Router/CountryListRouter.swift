//
//  CountryListRouter.swift
//  Countries
//
//  Created by Elina Batyrova on 21.09.2018.
//  Copyright © 2018 Elina. All rights reserved.
//

import Foundation
import UIKit

final class CountryListRouter: NSObject, CountryListRoutingLogic, CountryListDataPassing {
    
    // MARK: - Nested Types
    
    fileprivate enum Constants {
        
        // MARK: - Type Properties
        
        static let segueIdentifier = "toDetailVC"
    }
    
    // MARK: - Instance Properties
    
    weak var viewController: CountryListViewController?
    var dataStore: CountryListDataStore?
    
    // MARK: - Instance Methods
    
    func openCountryDetails(countryId: UniqueIdentifier) {
        if let dataStore = self.dataStore, let country = dataStore.countries?[countryId] {
            self.viewController?.performSegue(withIdentifier: Constants.segueIdentifier, sender: country)
        }
    }
    
    func prepareFor(segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? ConfigurableViewProtocol {
            destination.configure(with: sender)
        }
    }
}
