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
    var countries: [CountryObject] = []
    var nextURL = "https://rawgit.com/NikitaAsabin/799e4502c9fc3e0ea7af439b2dfd88fa/raw/7f5c6c66358501f72fada21e04d75f64474a7888/page1.json"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.countriesService = CountriesService()
        self.setupTableView()
        self.fetchCountriesFromURL(stringURL: self.nextURL)
    }
    
    func setupTableView() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 250;
        self.tableView.register(UINib(nibName: "CountryTableViewCell", bundle: nil), forCellReuseIdentifier: "CountryTableViewCell")
    }
    
    func fetchCountriesFromURL(stringURL: String) {
        let request = GetCountriesListRequest(endpoint: stringURL)
        
        self.countriesService.getCountriesList(with: request, onSuccess: { [weak self] (countries) in
            
            guard let strongSelf = self else { return }
            strongSelf.countries = countries
            strongSelf.tableView.reloadData()
            
        }) { (error) in
            
        }
    }
}

extension CountriesListViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.countries.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CountryTableViewCell", for: indexPath) as! CountryTableViewCell
        
        cell.prepare(with: self.countries[indexPath.row])
        
        return cell
    }
}

extension CountriesListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

}
