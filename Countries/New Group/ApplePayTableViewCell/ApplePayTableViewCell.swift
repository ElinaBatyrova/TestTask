//
//  ApplePayTableViewCell.swift
//  Countries
//
//  Created by Elina Batyrova on 31.01.2019.
//  Copyright © 2019 Elina. All rights reserved.
//

import UIKit

class ApplePayTableViewCell: UITableViewCell {
    
    // MARK: - Instance Properties
    
    @IBOutlet weak var payWithApplePayButton: UIButton!
    
    var onButtonClicked: (() -> Void)?
    
    // MARK: - Instance Methods

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    @IBAction func onPayWithApplePayButtonClicked(_ sender: Any) {
        self.onButtonClicked?()
    }
}
