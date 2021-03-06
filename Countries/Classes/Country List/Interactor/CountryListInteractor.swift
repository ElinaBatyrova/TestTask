//
//  CountryListInteractor.swift
//  Countries
//
//  Created by Elina Batyrova on 21.09.2018.
//  Copyright © 2018 Elina. All rights reserved.
//

import Foundation

class CountryListInteractor: CountryListBusinessLogic, CountryListDataStore {
    
    // MARK: - Instance Properties
    
    var presenter: CountryListPresentationLogic?
    var worker: CountryListWorkerProtocol?
    
    var countries: [CountryObject]?
    
    // MARK: - Initializers
    
    init() {
        self.subscribeToNotifications()
    }
    
    deinit {
        self.unsubscribeFromNotifications()
    }
    
    // MARK: - Instance Methods
    
    func subscribeToNotifications() {
        self.unsubscribeFromNotifications()
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.onBackgroundFetchCalled(_:)), name: .backgroundFetch, object: nil)
    }
    
    func unsubscribeFromNotifications() {
        NotificationCenter.default.removeObserver(self, name: .backgroundFetch, object: nil)
    }
    
    @objc func onBackgroundFetchCalled(_ notification: NSNotification) {
        let request = CountryList.Request()
        
        self.fetchCountries(request: request)
        
        NotificationCenter.default.post(Notification(name: .backgroundFetchCompleted))
    }
    
    func fetchCountries(request: CountryList.Request) {
        self.worker?.getCountries(onSuccess: { [weak self] (countries, loadedImages) in
            guard let strongSelf = self else {
                return
            }
            
            self?.countries = countries
            
            let response = CountryList.Response(countries: countries, loadedFlagImages: loadedImages)
            
            strongSelf.presenter?.presentCountries(response: response)
            }, onFailure: { [weak self] (error) in
                guard let strongSelf = self else {
                    return
                }
                
                guard let error = error else {
                    return
                }
                
                strongSelf.presenter?.present(error: error)
        })
    }
}
