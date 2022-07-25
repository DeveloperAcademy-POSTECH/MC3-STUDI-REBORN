//
//  DetailImageView.swift
//  Reborn
//
//  Created by peo on 2022/07/20.
//

import UIKit

final class DetailImageView: UIView {
    
    // MARK: - Properties
    
    let closeButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "xmark"), for: .normal)
        button.tintColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let animalImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "test"))
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let animalImageViewContainer: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    // MARK: - Methods
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .black
        
        makeSubviews()
        makeConstraints()
    }
    
    func makeSubviews() {
        animalImageViewContainer.addSubview(animalImageView)
        
        [animalImageViewContainer,
         closeButton].forEach { self.addSubview($0) }
    }
    
    func makeConstraints() {
        let closeButtonConstraints = [closeButton.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 24),
                                      closeButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -24)]
        
        let animalImageViewContainerConstraints = [animalImageViewContainer.topAnchor.constraint(equalTo: self.topAnchor),
                                                   animalImageViewContainer.bottomAnchor.constraint(equalTo: self.bottomAnchor),
                                                   animalImageViewContainer.leadingAnchor.constraint(equalTo: self.leadingAnchor),
                                                   animalImageViewContainer.trailingAnchor.constraint(equalTo: self.trailingAnchor)]
        
        let animalImageViewConstraints = [animalImageView.leadingAnchor.constraint(equalTo: animalImageViewContainer.contentLayoutGuide.leadingAnchor),
                                          animalImageView.trailingAnchor.constraint(equalTo: animalImageViewContainer.contentLayoutGuide.trailingAnchor),
                                          animalImageView.topAnchor.constraint(equalTo: animalImageViewContainer.contentLayoutGuide.topAnchor),
                                          animalImageView.bottomAnchor.constraint(equalTo: animalImageViewContainer.contentLayoutGuide.bottomAnchor),
                                          animalImageView.widthAnchor.constraint(equalTo: animalImageViewContainer.frameLayoutGuide.widthAnchor),
                                          animalImageView.heightAnchor.constraint(equalTo: animalImageViewContainer.frameLayoutGuide.heightAnchor)]
        
        [closeButtonConstraints,
         animalImageViewContainerConstraints,
         animalImageViewConstraints].forEach { NSLayoutConstraint.activate($0) }
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}
