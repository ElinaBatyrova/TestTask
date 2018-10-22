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
    
    fileprivate enum Constants {
        static let segueIdentifier = "toDetailVC"
    }
    
    weak var viewController: CountryListViewController?
    var dataStore: CountryListDataStore?
    
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
