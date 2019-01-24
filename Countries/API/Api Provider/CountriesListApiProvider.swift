//
//  CountriesListApiProvider.swift
//  Countries
//
//  Created by Elina Batyrova on 14.09.2018.
//  Copyright © 2018 Elina. All rights reserved.
//

import Foundation
import Alamofire

class CountriesListApiProvider: ApiProvider {
    
    // MARK: - Instance Methods
    
    func makeRequest(with request: Request, onSuccess: @escaping (Data?) -> Void, onFailure: @escaping (LoadError?) -> Void) {
        let url = request.endPoint
        let method = request.method
        
        Alamofire.request(url, method: method, parameters: nil)
        .validate()
        .responseData { (response) in
            guard response.result.isSuccess else {
                onFailure(nil)
                return
            }
            
            guard let data = response.result.value else {
                onFailure(nil)
                return
            }
            
            onSuccess(data)
        }
    }
}
