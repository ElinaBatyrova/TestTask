//
//  ApiProvider.swift
//  Countries
//
//  Created by Elina Batyrova on 14.09.2018.
//  Copyright © 2018 Elina. All rights reserved.
//

import Foundation

protocol ApiProvider {
    
    // MARK: - Instance Methods
    
    func makeRequest(with request: Request, onSuccess: @escaping (Data?) -> Void, onFailure: @escaping (LoadError?) -> Void)
}
