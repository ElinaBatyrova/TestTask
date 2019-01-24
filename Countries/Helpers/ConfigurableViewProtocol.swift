//
//  ConfigurableViewProtocol.swift
//  Countries
//
//  Created by Elina Batyrova on 20/10/2018.
//  Copyright © 2018 Elina. All rights reserved.
//

import Foundation

protocol ConfigurableViewProtocol: AnyObject {
    
    // MARK: - Instance Methods
    
    func configure(with object: Any?)
}

