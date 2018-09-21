//
//  DetailCountryViewController.swift
//  Countries
//
//  Created by Elina Batyrova on 19.09.2018.
//  Copyright © 2018 Elina. All rights reserved.
//

import UIKit

class DetailCountryViewController: UIViewController {
    
    @IBOutlet weak var collectionViewContainerView: UIView!
    @IBOutlet weak var imagesCollectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    var images: [UIImageView] = []
    
    var country: CountryObject!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupNavigationBar()
        self.loadImages()
        
        self.imagesCollectionView.register(UINib(nibName: "ImageCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ImageCollectionViewCell")
        
        self.pageControl.numberOfPages = self.images.count
        self.pageControl.currentPage = 0
        self.collectionViewContainerView.bringSubview(toFront: self.pageControl)
    }

    func setupNavigationBar() {
        self.navigationController?.navigationBar.backgroundColor = UIColor.clear
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.tintColor = UIColor.white
    }
    
    func prepareWith(country: CountryObject) {
        self.country = country
    }
    
    func loadImages() {
        for imageStringURL in country.imagesURLs {
            let imageView = UIImageView()
            imageView.sd_setImage(with: URL(string: imageStringURL), completed: nil)
            self.images.append(imageView)
        }
    }
}

extension DetailCountryViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCollectionViewCell", for: indexPath) as! ImageCollectionViewCell
        cell.prepareCell(with: self.images[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageIndex = round(scrollView.contentOffset.x/self.collectionViewContainerView.frame.width)
        self.pageControl.currentPage = Int(pageIndex)
    }
}
