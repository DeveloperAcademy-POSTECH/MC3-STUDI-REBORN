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
    
    var animalImageView: UIImageView?
    
    // MARK: - Methods
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .black
        
        makeSubviews()
        makeConstraints()
    }
    
    func makeSubviews() {
        self.addSubview(closeButton)
        if let animalImageView = animalImageView {
            self.addSubview(animalImageView)
        }
    }
    
    func makeConstraints() {
        let closeButtonConstraints = [closeButton.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 24),
                                      closeButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -24)]
        
        guard let animalImageView = animalImageView else { return }
        let animalImageViewConstraints = [animalImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
                                          animalImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
                                          animalImageView.topAnchor.constraint(equalTo: self.topAnchor),
                                          animalImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor)]
        
        [closeButtonConstraints, animalImageViewConstraints].forEach { NSLayoutConstraint.activate($0) }
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}
