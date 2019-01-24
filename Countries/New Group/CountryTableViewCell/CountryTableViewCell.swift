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
    
    // MARK: - Instance Properties
    
    @IBOutlet fileprivate weak var nameLabel: UILabel!
    @IBOutlet fileprivate weak var cityNameLabel: UILabel!
    @IBOutlet fileprivate weak var flagImageView: UIImageView!
    @IBOutlet fileprivate weak var descriptionLabel: UILabel!
    
    // MARK: - Instance Methods
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func prepare(with countryViewModel: CountryList.ViewModel.DisplayedCountry) {
        self.nameLabel.text = countryViewModel.name
        self.cityNameLabel.text = countryViewModel.capital
        self.descriptionLabel.text = countryViewModel.description
        self.flagImageView.image = countryViewModel.flag
    }
}
