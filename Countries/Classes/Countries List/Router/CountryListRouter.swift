//
//  CountryListRouter.swift
//  Countries
//
//  Created by Elina Batyrova on 21.09.2018.
//  Copyright © 2018 Elina. All rights reserved.
//

import Foundation
import UIKit

protocol CountryListRoutingLogic {
    func routeToDetailCountry(segue: UIStoryboardSegue?, selectedRow: Int)
}

protocol CountryListDataPassing {
    var dataStore: CountryListDataStore? { get }
}

final class CountryListRouter: NSObject, CountryListRoutingLogic, CountryListDataPassing {
    weak var viewController: CountryListViewController?
    var dataStore: CountryListDataStore?
    
    func routeToDetailCountry(segue: UIStoryboardSegue?, selectedRow: Int) {
        if let destinationVC = segue?.destination as? DetailCountryViewController {
            var destinationDS = destinationVC.router!.dataStore!
            self.passDataToDetailCountry(source: self.dataStore!, destination: &destinationDS, selectedRow: selectedRow)
//            self.navigateToDetailView(source: self.viewController!, destination: destinationVC)
        }
    }
    
//    func navigateToDetailView(source: CountryListViewController, destination: DetailCountryViewController) {
//        source.show(destination, sender: nil)
//    }
    
    func passDataToDetailCountry(source: CountryListDataStore, destination: inout DetailCountryDataStore, selectedRow: Int) {
//        if let selectedRow = viewController?.tableView.indexPathForSelectedRow?.row {
            destination.country = source.countries?[selectedRow]
//        }
    }
}
