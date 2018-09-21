//
//  CountriesListViewController.swift
//  Countries
//
//  Created by Elina Batyrova on 11.09.2018.
//  Copyright © 2018 Elina. All rights reserved.
//

import UIKit

class CountriesListViewController: UIViewController {
    
    fileprivate enum Constants {
        static let tableCellName = "CountryTableViewCell"
        static let segueIdentifier = "toDetailVC"
        
        // TODO: Move to service or api
        static let baseURL = "https://rawgit.com/NikitaAsabin/799e4502c9fc3e0ea7af439b2dfd88fa/raw/7f5c6c66358501f72fada21e04d75f64474a7888/page1.json"
    }

    @IBOutlet weak var tableView: UITableView!
    
    var countriesService: CountriesServiceProtocol!
    var countries: [CountryObject] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.countriesService = CountriesService()
        self.setupTableView()
        self.fetchCountriesFromURL(stringURL: Constants.baseURL)
    }
    
    func setupTableView() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 250;
        self.tableView.register(UINib(nibName: Constants.tableCellName, bundle: nil), forCellReuseIdentifier: Constants.tableCellName)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.setupNavigationBar()
    }
    
    func setupNavigationBar() {
        self.navigationController?.navigationBar.setBackgroundImage(nil, for: .default)
        self.navigationController?.navigationBar.shadowImage = nil
        self.navigationController?.navigationBar.tintColor = UIColor.black
    }
    
    func fetchCountriesFromURL(stringURL: String) {
        let request = GetCountriesListRequest(endpoint: stringURL)
        
        self.countriesService.getCountriesList(with: request, onSuccess: { [weak self] (countries) in
            
            guard let strongSelf = self else { return }
            strongSelf.countries = countries
            strongSelf.tableView.reloadData()
            
        }) { (error) in
            let alert = UIAlertController(title: "Ошибка!", message: "Ошибка при загрузке списка стран", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Constants.segueIdentifier {
            if let viewController = segue.destination as? DetailCountryViewController, let country = sender as? CountryObject {
                viewController.country = country
            }
        }
    }
}

extension CountriesListViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.countries.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.tableCellName, for: indexPath) as! CountryTableViewCell
        
        cell.prepare(with: self.countries[indexPath.row])
        
        return cell
    }
}

extension CountriesListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        performSegue(withIdentifier: Constants.segueIdentifier, sender: countries[indexPath.row])
    }
}
