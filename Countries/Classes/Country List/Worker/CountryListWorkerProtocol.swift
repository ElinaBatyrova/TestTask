//
//  CountryListWorkerProtocol.swift
//  Countries
//
//  Created by Elina Batyrova on 28.01.2019.
//  Copyright © 2019 Elina. All rights reserved.
//

import UIKit

protocol CountryListWorkerProtocol {
    
    // MARK: - Instance Methods
    
    func getCountries(onSuccess: @escaping ([CountryObject], [UIImage?]) -> Void, onFailure: @escaping (LoadError?) -> Void)
}
