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

        self.detailImageView.closeButton.addTarget(self, action: #selector(closeButtonDidTap), for: .touchUpInside)
        
        self.detailImageView.addGestureRecognizer(UIPinchGestureRecognizer(target: self, action: #selector(doPinch)))
    }
    
    override func loadView() {
        super.loadView()
        self.view = self.detailImageView
    }
    
    @objc func closeButtonDidTap() {
        self.dismiss(animated: true)
    }
    
    @objc func doPinch(_ pinch: UIPinchGestureRecognizer) {
        self.detailImageView.animalImageView?.transform = self.detailImageView.animalImageView?.transform.scaledBy(x: pinch.scale, y: pinch.scale) ?? .init()
        
        pinch.scale = 1
    }
}
