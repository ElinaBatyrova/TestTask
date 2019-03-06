//
//  NotificationExtension.swift
//  Countries
//
//  Created by Elina Batyrova on 06.03.2019.
//  Copyright © 2019 Elina. All rights reserved.
//

import Foundation

extension NSNotification.Name {
    
    // MARK: - Type Properties
    
    static let backgroundFetch = NSNotification.Name("backgroundFetch")
    static let backgroundFetchCompleted = NSNotification.Name("backgroundFetchCompleted")
}
