//
//  DetailCountryTableViewDataSource.swift
//  Countries
//
//  Created by Elina Batyrova on 31.01.2019.
//  Copyright © 2019 Elina. All rights reserved.
//

import UIKit

class DetailCountryTableViewDataSource: NSObject, UITableViewDataSource {
    
    // MARK: - Instance Properties
    
    var onPayWithApplePayButtonClicked: (() -> Void)?
    var isApplePayButtonHidden: Bool!
    
    // MARK: - Instance Methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ApplePayTableViewCell") as! ApplePayTableViewCell
        
        cell.payWithApplePayButton.isHidden = self.isApplePayButtonHidden
        cell.onButtonClicked = self.onPayWithApplePayButtonClicked
        
        return cell
    }
}

