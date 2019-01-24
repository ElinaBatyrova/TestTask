//
//  CountryListTableViewDelegate.swift
//  Countries
//
//  Created by Elina Batyrova on 20/10/2018.
//  Copyright © 2018 Elina. All rights reserved.
//

import UIKit

class CountryListTableViewDelegate: NSObject {
    
    // MARK: - Instance Properties
    
    var delegate: CountryListRoutingLogic?
    
    var dispayedCountries = [CountryList.ViewModel.DisplayedCountry]()
    
    // MARK: - Initializers
    
    init(viewModels: [CountryList.ViewModel.DisplayedCountry] = []) {
        self.dispayedCountries = viewModels
    }
}

// MARK: - UITableViewDelegate

extension CountryListTableViewDelegate: UITableViewDelegate {
    
    // MARK: - Instance Methods
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        defer { tableView.deselectRow(at: indexPath, animated: true) }
        
        self.delegate?.openCountryDetails(countryId: indexPath.row)
    }
}
