//
//  DetailCountryViewController.swift
//  Countries
//
//  Created by Elina Batyrova on 19.09.2018.
//  Copyright © 2018 Elina. All rights reserved.
//

import UIKit
import PKHUD

private enum State {
    case closed
    case open
}

extension State {
    var opposite: State {
        switch self {
        case .open:
            return .closed
            
        case .closed:
            return .open
        }
    }
}

class DetailCountryViewController: UIViewController, DetailCountryDisplayLogic, ConfigurableViewProtocol {
    
    fileprivate enum Constants {
        static let tableCellName = "ImageCollectionViewCell"
        
        static let viewAnimationIndex = 0
        
        static let openedViewConstraintConstant: CGFloat = 0
        static let closedViewConstraintConstant: CGFloat = 180
    }
    
    var interactor: DetailCountryBusinessLogic?
    var collectionViewDataSource: DetailCountryCollectionViewDataSource?
    
    @IBOutlet weak var countryNameLabel: UILabel!
    
    @IBOutlet weak var collectionViewContainerView: UIView!
    @IBOutlet weak var imagesCollectionView: UICollectionView!
    
    @IBOutlet weak var informationView: UIView!
    @IBOutlet weak var informationViewTopConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var pageControl: UIPageControl!
    
    var images: [UIImage] = []
    
    private var currentState: State = .closed
    
    private var runningAnimators = [UIViewPropertyAnimator]()
    
    private var animationProgress = [CGFloat]()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        DetailCountryConfigurator.sharedInstance.configure(viewController: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupNavigationBar()
        self.setupCollectionView()
        self.setUpView()
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
    
    func setupNoAnimationState() {
        self.navigationController?.navigationBar.tintColor = UIColor.black
        
        self.informationViewTopConstraint.constant = Constants.openedViewConstraintConstant
    }
    
    func setupAnimationState() {
        let panRecognizer = UIPanGestureRecognizer()
        
        panRecognizer.addTarget(self, action: #selector(popupViewPanned(recognizer:)))
        
        self.informationView.addGestureRecognizer(panRecognizer)
        
        self.pageControl.numberOfPages = images.count
        self.pageControl.currentPage = 0
        
        self.imagesCollectionView.reloadData()
    }
    
    func setupCollectionView() {
        self.imagesCollectionView.register(UINib(nibName: Constants.tableCellName, bundle: nil), forCellWithReuseIdentifier: Constants.tableCellName)
        self.imagesCollectionView.dataSource = self.collectionViewDataSource
        self.imagesCollectionView.delegate = self
        
        self.collectionViewContainerView.bringSubview(toFront: self.pageControl)
    }
    
    func setUpView() {
        HUD.show(.progress)
        
        self.interactor?.setUpViewWithCountry()
    }

    func displayCountry(viewModel: DetailCountry.ViewModel) {
        HUD.flash(.success, delay: 1.0)
        
        self.countryNameLabel.text = viewModel.countryName
        
        if viewModel.images.isEmpty {
            self.setupNoAnimationState()
        } else {
            self.images = viewModel.images
            self.collectionViewDataSource?.displayedCountry = viewModel
            self.setupAnimationState()
        }
    }
    
    func displayError(with message: String?) {
        HUD.flash(.error, delay: 1.0)
        
        let alert = UIAlertController(title: "Error", message: (message != nil) ? message : "Something went wrong", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
        self.setupNoAnimationState()
    }
    
    private func animateTransitionIfNeeded(to state: State, duration: TimeInterval) {
        guard runningAnimators.isEmpty else { return }
        
        let transitionAnimator = UIViewPropertyAnimator(duration: duration, dampingRatio: 1, animations: {
            switch state {
            case .open:
                self.informationViewTopConstraint.constant = Constants.openedViewConstraintConstant
                self.informationView.layer.cornerRadius = 20
                
            case .closed:
                self.informationViewTopConstraint.constant = Constants.closedViewConstraintConstant
                self.informationView.layer.cornerRadius = 0
                
            }
            self.view.layoutIfNeeded()
        })
        
        transitionAnimator.addCompletion { position in
            switch position {
            case .start:
                self.currentState = state.opposite
                
            case .end:
                self.currentState = state
                
            case .current:
                break
            }
            
            switch self.currentState {
            case .open:
                self.informationViewTopConstraint.constant = Constants.openedViewConstraintConstant
                
            case .closed:
                self.informationViewTopConstraint.constant = Constants.closedViewConstraintConstant
            }
            
            self.runningAnimators.removeAll()
        }
        
        transitionAnimator.startAnimation()
        
        self.runningAnimators.append(transitionAnimator)
    }
    
    @objc private func popupViewPanned(recognizer: UIPanGestureRecognizer) {
        switch recognizer.state {
        case .began:
            animateTransitionIfNeeded(to: currentState.opposite, duration: 1)
            
            runningAnimators.forEach { $0.pauseAnimation() }
            
            animationProgress = runningAnimators.map { $0.fractionComplete }
            
        case .changed:
            let translation = recognizer.translation(in: self.informationView)
            var fraction = -translation.y / Constants.closedViewConstraintConstant
            
            if currentState == .open { fraction *= -1 }
            if runningAnimators[Constants.viewAnimationIndex].isReversed { fraction *= -1 }
            
            for (index, animator) in runningAnimators.enumerated() {
                animator.fractionComplete = fraction + animationProgress[index]
            }
            
        case .ended:
            let yVelocity = recognizer.velocity(in: self.informationView).y
            let shouldClose = yVelocity > 0
            
            if yVelocity == 0 {
                runningAnimators.forEach { $0.continueAnimation(withTimingParameters: nil, durationFactor: 0) }
                break
            }
            
            switch currentState {
            case .open:
                if !shouldClose && !runningAnimators[Constants.viewAnimationIndex].isReversed {
                    runningAnimators.forEach { $0.isReversed = !$0.isReversed }
                }
                if shouldClose && runningAnimators[Constants.viewAnimationIndex].isReversed {
                    runningAnimators.forEach { $0.isReversed = !$0.isReversed }
                }
                
            case .closed:
                if shouldClose && !runningAnimators[Constants.viewAnimationIndex].isReversed {
                    runningAnimators.forEach { $0.isReversed = !$0.isReversed }
                }
                if !shouldClose && runningAnimators[Constants.viewAnimationIndex].isReversed {
                    runningAnimators.forEach { $0.isReversed = !$0.isReversed }
                }
            }
            
            runningAnimators.forEach { $0.continueAnimation(withTimingParameters: nil, durationFactor: 0) }
            
        default:
            break
        }
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
