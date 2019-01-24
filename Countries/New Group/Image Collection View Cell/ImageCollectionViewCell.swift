//
//  ImageCollectionViewCell.swift
//  Countries
//
//  Created by Elina Batyrova on 20.09.2018.
//  Copyright © 2018 Elina. All rights reserved.
//

import UIKit

class ImageCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Instance Properties

    @IBOutlet fileprivate weak var imageView: UIImageView!
    
    // MARK: - Instance Methods
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func prepareCell(with image: UIImage) {
        self.imageView.image = image
    }
}
