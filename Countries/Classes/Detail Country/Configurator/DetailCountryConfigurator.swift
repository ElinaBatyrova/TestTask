//
//  DetailCountryConfigurator.swift
//  Countries
//
//  Created by Elina Batyrova on 22.10.2018.
//  Copyright © 2018 Elina. All rights reserved.
//

import UIKit

class DetailCountryConfigurator {
    
    static let sharedInstance = DetailCountryConfigurator()
    
    func configure(viewController: DetailCountryViewController) {
        let interactor = DetailCountryInteractor()
        let presenter = DetailCountryPresenter()
        let worker = DetailCountryWorker()
        let collectionViewDataSource = DetailCountryCollectionViewDataSource()
        
        viewController.interactor = interactor
        viewController.collectionViewDataSource = collectionViewDataSource
        
        interactor.presenter = presenter
        interactor.worker = worker
        
        presenter.viewController = viewController
    }
}
