//
//  DetailCountryViewController.swift
//  Countries
//
//  Created by Elina Batyrova on 19.09.2018.
//  Copyright © 2018 Elina. All rights reserved.
//

import UIKit
import PKHUD

protocol DetailCountryDisplayLogic: class {
    func displayCountry(viewModel: DetailCountry.ViewModel)
}

class DetailCountryViewController: UIViewController, DetailCountryDisplayLogic, ConfigurableViewProtocol {
    
    var interactor: DetailCountryBusinessLogic?
    var router: (DetailCountryRoutingLogic & DetailCountryDataPassing)?
    
    var collectionViewDataSource: DetailCountryCollectionViewDataSource?
    
    @IBOutlet weak var collectionViewContainerView: UIView!
    @IBOutlet weak var imagesCollectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    var images: [UIImage] = []
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        self.setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setup()
    }
    
    private func setup() {
        let viewController = self
        let interactor = DetailCountryInteractor()
        let presenter = DetailCountryPresenter()
        let router = DetailCountryRouter()
        let worker = DetailCountryWorker()
        let collectionViewDataSource = DetailCountryCollectionViewDataSource()
        viewController.interactor = interactor
        viewController.router = router
        viewController.collectionViewDataSource = collectionViewDataSource
        interactor.presenter = presenter
        interactor.worker = worker
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupNavigationBar()
        self.setUpView()
        
        self.imagesCollectionView.register(UINib(nibName: "ImageCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ImageCollectionViewCell")
        self.imagesCollectionView.dataSource = self.collectionViewDataSource
        self.imagesCollectionView.delegate = self
        
        
        self.pageControl.currentPage = 0
        
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
    
    func setUpView() {
        HUD.show(.progress)
        self.interactor?.setUpViewWithCountry()
    }

    func displayCountry(viewModel: DetailCountry.ViewModel) {
        
        HUD.flash(.success, delay: 1.0)
        
        self.images = viewModel.images
        self.pageControl.numberOfPages = images.count
        self.collectionViewDataSource?.displayedCountry = viewModel
        self.imagesCollectionView.reloadData()
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
