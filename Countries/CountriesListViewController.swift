//
//  CountriesListViewController.swift
//  Countries
//
//  Created by Elina Batyrova on 11.09.2018.
//  Copyright © 2018 Elina. All rights reserved.
//

import UIKit

class CountriesListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var countriesService: CountriesServiceProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.countriesService = CountriesService()
        
        
        var request = GetCountriesListRequest(endpoint: "https://rawgit.com/NikitaAsabin/799e4502c9fc3e0ea7af439b2dfd88fa/raw/7f5c6c66358501f72fada21e04d75f64474a7888/page1.json")
        
        self.countriesService.getCountriesList(with: request, onSuccess: { (countriesList) in
            
        }) { (error) in
            
        }
    }

}
