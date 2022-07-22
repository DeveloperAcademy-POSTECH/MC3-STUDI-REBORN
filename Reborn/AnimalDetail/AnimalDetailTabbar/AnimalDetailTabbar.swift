//
//  AnimalDetailTabbar.swift
//  Reborn
//
//  Created by peo on 2022/07/19.
//

import UIKit

final class AnimalDetailTabbar: UIView {
    
    // MARK: - Properties
    
    let likeButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(systemName: "heart"), for: .normal)
        button.tintColor = .gray
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let contactButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .cGreen
        button.layer.cornerRadius = 14
        button.setTitle("보호소 연락하기", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 17, weight: .semibold)
        button.setTitleColor(.white, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    weak var delegate: AnimalDetailTabbarDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        makeSubviews()
        makeConstraints()
        configureTabbarBorder()
        setDelegates()
    }
    
    private func configureTabbarBorder() {
        self.layer.borderWidth = 0.4
        self.layer.borderColor = UIColor.cLightGray?.cgColor
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}

// MARK: - Layout Setting

extension AnimalDetailTabbar {
    
    private func makeSubviews() {
        [likeButton, contactButton].forEach { self.addSubview($0) }
    }
    
    private func makeConstraints() {
        let likeButtonConstraints = [likeButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 32),
                                     likeButton.centerYAnchor.constraint(equalTo: contactButton.centerYAnchor),
                                     likeButton.widthAnchor.constraint(equalToConstant: 27.5),
                                     likeButton.heightAnchor.constraint(equalToConstant: 24.5)]
        
        let contactButtonConstraints = [contactButton.leadingAnchor.constraint(equalTo: likeButton.trailingAnchor, constant: 26),
                                        contactButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
                                        contactButton.topAnchor.constraint(equalTo: topAnchor, constant: 10),
                                        contactButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -52)]
        
        [likeButtonConstraints, contactButtonConstraints].forEach { NSLayoutConstraint.activate($0) }
    }
}

// MARK: - Delegate

extension AnimalDetailTabbar {
    
    func setDelegates() {
        contactButton.addTarget(self, action: #selector(contactButtonDidTap), for: .touchUpInside)
        likeButton.addTarget(self, action: #selector(likeButtonDidTap), for: .touchUpInside)
    }
    
    @objc func contactButtonDidTap() {
        delegate?.contactButtonDidTap()
    }
    
    @objc func likeButtonDidTap() {
        delegate?.likeButtonDidTap()
    }
}
