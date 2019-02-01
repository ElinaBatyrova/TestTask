//
//  DetailCountryConfigurator.swift
//  Countries
//
//  Created by Elina Batyrova on 22.10.2018.
//  Copyright © 2018 Elina. All rights reserved.
//

import UIKit

class DetailCountryConfigurator {
    
    // MARK: - Instance Properties
    
    static let sharedInstance = DetailCountryConfigurator()
    
    // MARK: - Instance Methods
    
    func configure(viewController: DetailCountryViewController) {
        let interactor = DetailCountryInteractor()
        let presenter = DetailCountryPresenter()
        let worker = DetailCountryWorker()
        let collectionViewDataSource = DetailCountryCollectionViewDataSource()
        let tableViewDataSource = DetailCountryTableViewDataSource()
        
        viewController.interactor = interactor
        viewController.collectionViewDataSource = collectionViewDataSource
        viewController.tableViewDataSource = tableViewDataSource
        
        interactor.presenter = presenter
        interactor.worker = worker
        
        presenter.viewController = viewController
    }
}
