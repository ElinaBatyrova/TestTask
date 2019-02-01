//
//  DetailCountryInteractor.swift
//  Countries
//
//  Created by Elina Batyrova on 03.10.2018.
//  Copyright © 2018 Elina. All rights reserved.
//

import Foundation
import PassKit

final class DetailCountryInteractor: DetailCountryBusinessLogic, DetailCountryDataStore {
    
    // MARK: - Instance Properties
    
    var presenter: DetailCountryPresentationLogic?
    var worker: DetailCountryWorkerProtocol = DetailCountryWorker()
    var country: CountryObject?
    
    var supportedPaymentNetworks = [PKPaymentNetwork.visa, PKPaymentNetwork.masterCard]
    var applePayMerchantIdentifier = "merchant.com.flatstack.countries"
    
    var isApplePayAvailable: Bool {
        get {
            return PKPaymentAuthorizationViewController.canMakePayments(usingNetworks: self.supportedPaymentNetworks)
        }
    }
    
    // MARK: - Instance Methods
    
    func setUpViewWithCountry() {
        var imagesURLs: [String] = []
        
        guard let stringURLs = self.country?.imagesURLs else {
            return
        }
        
        for string in stringURLs{
            imagesURLs.append(string)
        }
        
        self.worker.getImages(from: imagesURLs, onSuccess: { (images) in
            if let presenter = self.presenter, let country = self.country {
                let countryResponse = DetailCountry.Response(country: country, loadedImages: images)
                
                presenter.presentCountry(response: countryResponse)
            }
        }) { [weak self] (error) in
            guard let strongSelf = self else {
                return
            }
            
            strongSelf.presenter?.presentError(with: error?.message)
        }
    }
    
    func configureBusinessLogic(with object: Any?) {
        if let country = object as? CountryObject {
            self.country = country
        }
    }
    
    func payWithApplePay(delegate: PKPaymentAuthorizationControllerDelegate) {
        let request = PKPaymentRequest()
        
        request.merchantCapabilities = PKMerchantCapability.capability3DS
        request.merchantIdentifier = self.applePayMerchantIdentifier
        request.supportedNetworks = self.supportedPaymentNetworks
        request.countryCode = "RU"
        request.currencyCode = "RUB"
        
        request.paymentSummaryItems = [PKPaymentSummaryItem(label: "Ticket 1", amount: 1500),
                                       PKPaymentSummaryItem(label: "Ticket 2", amount: 4500),
                                       PKPaymentSummaryItem(label: "Tickets", amount: 6000)]
        
        let applePayController = PKPaymentAuthorizationController(paymentRequest: request)
        
        applePayController.delegate = delegate
        
        applePayController.present { (success) in
            if success {
                print("Presented payment controller")
            } else {
                print("Failed to present payment controller")
            }
        }
    }
}
