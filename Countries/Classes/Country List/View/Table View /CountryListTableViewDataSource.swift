//
//  CountryListTableViewDataSource.swift
//  Countries
//
//  Created by Elina Batyrova on 20/10/2018.
//  Copyright © 2018 Elina. All rights reserved.
//

import UIKit

class CountryListTableViewDataSource: NSObject {
    
    // MARK: - Instance Properties
    
    var dispayedCountries = [CountryList.ViewModel.DisplayedCountry]()
    
    // MARK: - Initializers
    
    init(viewModels: [CountryList.ViewModel.DisplayedCountry] = []) {
        self.dispayedCountries = viewModels
    }
}

// MARK: - UITableViewDataSource

extension CountryListTableViewDataSource: UITableViewDataSource {
    
    // MARK: - Instance Methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dispayedCountries.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CountryTableViewCell", for: indexPath) as! CountryTableViewCell
        
        cell.prepare(with: self.dispayedCountries[indexPath.row])
        
        return cell
    }
}
