//
//  CountryListViewController.swift
//  Countries
//
//  Created by Elina Batyrova on 11.09.2018.
//  Copyright © 2018 Elina. All rights reserved.
//

import UIKit
import SVProgressHUD

class CountryListViewController: UIViewController, CountryListDisplayLogic {
    
    // MARK: - Nested Types
    
    fileprivate enum Constants {
        
        // MARK: - Type Properties
        
        static let tableCellName = "CountryTableViewCell"
    }
    
    // MARK: - Instance Properties
    
    var interactor: CountryListBusinessLogic?
    var router: CountryListRoutingLogic?
    
    var tableViewDataSource: CountryListTableViewDataSource?
    var tableViewDelegate: CountryListTableViewDelegate?
    
    // MARK: -

    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Instance Methods
    
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
        SVProgressHUD.show()
    
        let request = CountryList.Request()
        self.interactor?.fetchCountries(request: request)
    }
    
    func displayCountries(viewModel: CountryList.ViewModel) {
        self.tableViewDelegate?.dispayedCountries = viewModel.displayedCountries
        self.tableViewDataSource?.dispayedCountries = viewModel.displayedCountries
        self.tableView.reloadData()
        
        SVProgressHUD.dismiss()
    }
    
    func displayError(with message: String?) {
        SVProgressHUD.dismiss()
        
        let alert = UIAlertController(title: "Error", message: (message != nil) ? message : "Something went wrong", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }
}
