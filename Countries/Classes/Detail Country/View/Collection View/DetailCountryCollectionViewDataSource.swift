//
//  DetailCountryCollectionViewDataSource.swift
//  Countries
//
//  Created by Elina Batyrova on 20/10/2018.
//  Copyright © 2018 Elina. All rights reserved.
//

import UIKit

class DetailCountryCollectionViewDataSource: NSObject, UICollectionViewDataSource {
    
    // MARK: - Instance Properties
    
    var displayedCountry: DetailCountry.ViewModel?
    
    // MARK: - Instance Methods
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let images = self.displayedCountry?.images {
            return images.count
        } else {
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCollectionViewCell", for: indexPath) as! ImageCollectionViewCell
        
        if let image = self.displayedCountry?.images[indexPath.row] {
            cell.prepareCell(with: image)
        }
        
        return cell
    }
}
