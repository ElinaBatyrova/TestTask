//
//  CountryListViewController.swift
//  Countries
//
//  Created by Elina Batyrova on 11.09.2018.
//  Copyright © 2018 Elina. All rights reserved.
//

import UIKit
import PKHUD

protocol CountryListDisplayLogic: class {
    func displayCountries(viewModel: CountryList.ViewModel)
}

class CountryListViewController: UIViewController, CountryListDisplayLogic {
    
    fileprivate enum Constants {
        static let tableCellName = "CountryTableViewCell"
        static let segueIdentifier = "toDetailVC"
    }
    
    var interactor: CountryListBusinessLogic?
    var router: (CountryListRoutingLogic & CountryListDataPassing)?

    @IBOutlet weak var tableView: UITableView!
    
    var dispayedCountries = [CountryList.ViewModel.DisplayedCountry]()
    
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        self.setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setup()
    }
    
    private func setup() {
        let viewController = self
        let interactor = CountryListInteractor()
        let presenter = CountryListPresenter()
        let router = CountryListRouter()
        let worker = CountryListWorker()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        interactor.worker = worker
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.setupTableView()
        self.setupNavigationBar()
    }
    
    func setupTableView() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 250;
        self.tableView.register(UINib(nibName: Constants.tableCellName, bundle: nil), forCellReuseIdentifier: Constants.tableCellName)
    }
    
    func setupNavigationBar() {
        self.navigationController?.navigationBar.setBackgroundImage(nil, for: .default)
        self.navigationController?.navigationBar.shadowImage = nil
        self.navigationController?.navigationBar.tintColor = UIColor.black
    }
    
    func setUpView() {
        HUD.show(.progress)
        self.interactor?.setUpViewWithCountries()
    }
    
    func displayCountries(viewModel: CountryList.ViewModel) {
        self.dispayedCountries = viewModel.displayedCountries
        self.tableView.reloadData()
        HUD.flash(.success, delay: 1.0)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == Constants.segueIdentifier {
//            if let viewController = segue.destination as? DetailCountryViewController, let country = sender as? CountryObject {
//                viewController.country = country
//            }
            
            if let router = self.router, let selectedRow = sender as? Int {
                router.routeToDetailCountry(segue: segue, selectedRow: selectedRow)
            }
        }
    }
}

extension CountryListViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dispayedCountries.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.tableCellName, for: indexPath) as! CountryTableViewCell
        
        cell.prepare(with: self.dispayedCountries[indexPath.row])
        
        return cell
    }
}

extension CountryListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        performSegue(withIdentifier: Constants.segueIdentifier, sender: indexPath.row)
    }
}
