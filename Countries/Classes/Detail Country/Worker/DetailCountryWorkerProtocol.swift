//
//  DetailCountryWorkerProtocol.swift
//  Countries
//
//  Created by Elina Batyrova on 29.01.2019.
//  Copyright © 2019 Elina. All rights reserved.
//

import UIKit

protocol DetailCountryWorkerProtocol {
    
    // MARK: - instance Methods
    
    func getImages(from urls: [String], onSuccess: @escaping ([UIImage]) -> Void, onFailure: @escaping (LoadError?) -> Void)
}
