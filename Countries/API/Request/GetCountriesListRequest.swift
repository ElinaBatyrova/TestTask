//
//  GetCountriesListRequest.swift
//  Countries
//
//  Created by Elina Batyrova on 14.09.2018.
//  Copyright © 2018 Elina. All rights reserved.
//

import Foundation
import Alamofire

class GetCountriesListRequest: Request {
    
    // MARK: - Instance Properties
    
    var method: HTTPMethod = .get
    var endPoint: String
    
    // MARK: - Initializers
    
    init(endpoint: String) {
        self.endPoint = endpoint
    }
}
