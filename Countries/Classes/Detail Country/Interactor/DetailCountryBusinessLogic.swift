//
//  DetailCountryBusinessLogic.swift
//  Countries
//
//  Created by Elina Batyrova on 22.10.2018.
//  Copyright © 2018 Elina. All rights reserved.
//

import Foundation
import PassKit

protocol DetailCountryBusinessLogic {
    
    // MARK: - Instance Properties
    
    var isApplePayAvailable: Bool { get }
    
    // MARK: - Instance Methods
    
    func setUpViewWithCountry()
    func configureBusinessLogic(with object: Any?)
    func payWithApplePay(delegate: PKPaymentAuthorizationControllerDelegate)
}
