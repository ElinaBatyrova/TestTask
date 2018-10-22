//
//  DetailCountryViewController.swift
//  Countries
//
//  Created by Elina Batyrova on 19.09.2018.
//  Copyright © 2018 Elina. All rights reserved.
//

import UIKit
import PKHUD

class DetailCountryViewController: UIViewController, DetailCountryDisplayLogic, ConfigurableViewProtocol {
    
    var interactor: DetailCountryBusinessLogic?
    var collectionViewDataSource: DetailCountryCollectionViewDataSource?
    
    @IBOutlet weak var collectionViewContainerView: UIView!
    @IBOutlet weak var imagesCollectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    var images: [UIImage] = []
    
    override func awakeFromNib() {
        super.awakeFromNib()
        DetailCountryConfigurator.sharedInstance.configure(viewController: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupNavigationBar()
        self.setUpView()
        
        self.imagesCollectionView.register(UINib(nibName: "ImageCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ImageCollectionViewCell")
        self.imagesCollectionView.dataSource = self.collectionViewDataSource
        self.imagesCollectionView.delegate = self

        self.collectionViewContainerView.bringSubview(toFront: self.pageControl)
    }

    func configure(with object: Any?) {
        self.interactor?.configureBusinessLogic(with: object)
    }
    
    func setupNavigationBar() {
        self.navigationController?.navigationBar.backgroundColor = UIColor.clear
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.tintColor = UIColor.white
    }
    
    func setupNavigationBarBlack() {
        self.navigationController?.navigationBar.tintColor = UIColor.black
    }
    
    func setUpView() {
        HUD.show(.progress)
        self.interactor?.setUpViewWithCountry()
    }

    func displayCountry(viewModel: DetailCountry.ViewModel) {
        
        HUD.flash(.success, delay: 1.0)
        
        if viewModel.images.isEmpty {
            self.setupNavigationBarBlack()
        } else {
            self.images = viewModel.images
            self.pageControl.numberOfPages = images.count
            self.pageControl.currentPage = 0
            self.collectionViewDataSource?.displayedCountry = viewModel
            self.imagesCollectionView.reloadData()
        }
    }
    
    func displayError(with message: String?) {
        let alert = UIAlertController(title: "Error", message: (message != nil) ? message : "Something went wrong", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }
}

extension DetailCountryViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageIndex = round(scrollView.contentOffset.x/self.collectionViewContainerView.frame.width)
        self.pageControl.currentPage = Int(pageIndex)
    }
}
