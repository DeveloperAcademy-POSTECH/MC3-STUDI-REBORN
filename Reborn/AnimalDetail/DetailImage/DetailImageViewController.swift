//
//  DetailImageViewController.swift
//  Reborn
//
//  Created by peo on 2022/07/20.
//

import UIKit

final class DetailImageViewController: UIViewController {
    
    // MARK: - Properties

    let detailImageView = DetailImageView()
    
    // MARK: - Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()

        detailImageView.closeButton.addTarget(self, action: #selector(closeButtonDidTap), for: .touchUpInside)
        
        setUpScroll()
    }
    
    override func loadView() {
        super.loadView()
        
        self.view = self.detailImageView
    }
    
    @objc func closeButtonDidTap() {
        self.dismiss(animated: true)
    }
}

// MARK: - Scroll Delegate

extension DetailImageViewController: UIScrollViewDelegate {
    
    private func setUpScroll() {
        detailImageView.animalImageViewContainer.minimumZoomScale = 1
        detailImageView.animalImageViewContainer.maximumZoomScale = 2
        detailImageView.animalImageViewContainer.delegate = self
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return detailImageView.animalImageView
    }
}
