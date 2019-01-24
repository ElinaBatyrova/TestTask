//
//  Request.swift
//  Countries
//
//  Created by Elina Batyrova on 14.09.2018.
//  Copyright © 2018 Elina. All rights reserved.
//

import Foundation
import Alamofire

protocol Request {
    
    // MARK: - Instance Properties
    
    var method: HTTPMethod { get }
    var endPoint: String { get }
}
