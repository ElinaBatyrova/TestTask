//
//  CountryListConfigurator.swift
//  Countries
//
//  Created by Elina Batyrova on 22.10.2018.
//  Copyright © 2018 Elina. All rights reserved.
//

import Foundation

class CountryListConfigurator {
    
    // MARK: - Instance Properties
    
    static let sharedInstance = CountryListConfigurator()
    
    // MARK: - Instance Methods
    
    func configure(viewController: CountryListViewController) {
        let interactor = CountryListInteractor()
        let presenter = CountryListPresenter()
        let router = CountryListRouter()
        let worker = CountryListWorker()
        let tableViewDataSource = CountryListTableViewDataSource()
        let tableViewDelegate = CountryListTableViewDelegate()
        
        viewController.interactor = interactor
        viewController.router = router
        viewController.tableViewDataSource = tableViewDataSource
        viewController.tableViewDelegate = tableViewDelegate
        
        interactor.presenter = presenter
        interactor.worker = worker
        
        presenter.viewController = viewController
        
        router.viewController = viewController
        router.dataStore = interactor
        
        tableViewDelegate.delegate = router
    }
}
