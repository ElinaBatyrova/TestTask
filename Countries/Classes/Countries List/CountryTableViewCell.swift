//
//  CountryTableViewCell.swift
//  Countries
//
//  Created by Elina Batyrova on 21.09.2018.
//  Copyright © 2018 Elina. All rights reserved.
//

import UIKit
import SDWebImage

class CountryTableViewCell: UITableViewCell {
    
    @IBOutlet fileprivate weak var nameLabel: UILabel!
    @IBOutlet fileprivate weak var cityNameLabel: UILabel!
    @IBOutlet fileprivate weak var flagImageView: UIImageView!
    @IBOutlet fileprivate weak var descriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func prepare(with country: CountryObject) {
        self.nameLabel.text = country.name
        self.cityNameLabel.text = country.capital
        self.descriptionLabel.text = country.smallDescription
        self.flagImageView.sd_setImage(with: URL(string: country.imageURL), completed: nil)
    }
}
