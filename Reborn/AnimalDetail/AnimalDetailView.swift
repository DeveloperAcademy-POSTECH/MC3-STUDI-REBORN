//
//  AnimalDetailView.swift
//  Reborn
//
//  Created by peo on 2022/07/18.
//

import UIKit

final class AnimalDetailView: UIView {
    
    // MARK: - Properties
    
    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    let animalImageContainer: UIView = {
        let animalImageContainer = UIView()
        animalImageContainer.translatesAutoresizingMaskIntoConstraints = false
        return animalImageContainer
    }()
    
    let animalImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .gray
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let animalInfoView: AnimalInfoView = {
        let animalInfoView = AnimalInfoView()
        animalInfoView.translatesAutoresizingMaskIntoConstraints = false
        return animalInfoView
    }()
    
    let tabbar: AnimalDetailTabbar = {
        let tabbar = AnimalDetailTabbar()
        tabbar.translatesAutoresizingMaskIntoConstraints = false
        return tabbar
    }()
    
    // MARK: - Methods
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        makeSubviews()
        makeConstraints()
    }
    
    private func makeSubviews() {
        [scrollView, tabbar].forEach { self.addSubview($0) }
        
        [animalImageContainer,
         animalImageView,
         animalInfoView].forEach { scrollView.addSubview($0) }
    }
    
    private func makeConstraints() {
        let scrollViewConstraints = [scrollView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
                                     scrollView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
                                     scrollView.topAnchor.constraint(equalTo: self.topAnchor),
                                     scrollView.bottomAnchor.constraint(equalTo: tabbar.topAnchor)]
        
        let animalImageContainerConstraints = [animalImageContainer.leadingAnchor.constraint(equalTo: self.leadingAnchor),
                                               animalImageContainer.trailingAnchor.constraint(equalTo: self.trailingAnchor),
                                               animalImageContainer.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
                                               animalImageContainer.bottomAnchor.constraint(equalTo: animalInfoView.topAnchor, constant: -20),
                                               animalImageContainer.heightAnchor.constraint(equalToConstant: 420),
                                               animalImageContainer.widthAnchor.constraint(equalTo: scrollView.widthAnchor)]
        
        let animalImageViewConstraints = [animalImageView.leadingAnchor.constraint(equalTo: animalImageContainer.leadingAnchor),
                                          animalImageView.trailingAnchor.constraint(equalTo: animalImageContainer.trailingAnchor),
                                          animalImageView.bottomAnchor.constraint(equalTo: animalImageContainer.bottomAnchor)]
        let animalImageViewTopConstraints = animalImageView.topAnchor.constraint(equalTo: topAnchor)
        animalImageViewTopConstraints.priority = .defaultHigh
        let animalImageViewHeightConstraints = animalImageView.heightAnchor.constraint(greaterThanOrEqualTo: animalImageContainer.heightAnchor, constant: -40)
        animalImageViewHeightConstraints.priority = .required
        
        let animalInfoViewConstraints = [animalInfoView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
                                         animalInfoView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
                                         animalInfoView.topAnchor.constraint(equalTo: animalImageContainer.bottomAnchor, constant: 20),
                                         animalInfoView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor)]
        let animalInfoViewHeightConstraints = animalInfoView.heightAnchor.constraint(greaterThanOrEqualTo: heightAnchor, constant: -240)
        animalInfoViewHeightConstraints.priority = .required
        
        let tabbarConstraints = [tabbar.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
                                 tabbar.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor),
                                 tabbar.bottomAnchor.constraint(equalTo: self.bottomAnchor),
                                 tabbar.topAnchor.constraint(equalTo: scrollView.bottomAnchor),
                                 tabbar.heightAnchor.constraint(equalToConstant: 114)]
        
        [scrollViewConstraints,
         animalImageContainerConstraints,
         animalImageViewConstraints,
         [animalImageViewTopConstraints, animalImageViewHeightConstraints],
         animalInfoViewConstraints,
         [animalInfoViewHeightConstraints],
         tabbarConstraints].forEach { NSLayoutConstraint.activate($0) }
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}
