//
//  CountryListViewController.swift
//  Countries
//
//  Created by Elina Batyrova on 11.09.2018.
//  Copyright © 2018 Elina. All rights reserved.
//

import UIKit
import PKHUD

class CountryListViewController: UIViewController, CountryListDisplayLogic {
    
    fileprivate enum Constants {
        static let tableCellName = "CountryTableViewCell"
    }
    
    var interactor: CountryListBusinessLogic?
    var router: CountryListRoutingLogic?
    
    var tableViewDataSource: CountryListTableViewDataSource?
    var tableViewDelegate: CountryListTableViewDelegate?

    @IBOutlet weak var tableView: UITableView!
    
    override func awakeFromNib() {
        CountryListConfigurator.sharedInstance.configure(viewController: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.setupTableView()
        self.setupNavigationBar()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        self.router?.prepareFor(segue: segue, sender: sender)
    }
    
    func setupTableView() {
        self.tableView.delegate = self.tableViewDelegate
        self.tableView.dataSource = self.tableViewDataSource
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
        let request = CountryList.Request()
        self.interactor?.fetchCountries(request: request)
    }
    
    func displayCountries(viewModel: CountryList.ViewModel) {
        self.tableViewDelegate?.dispayedCountries = viewModel.displayedCountries
        self.tableViewDataSource?.dispayedCountries = viewModel.displayedCountries
        self.tableView.reloadData()
        HUD.flash(.success, delay: 1.0)
    }
}
