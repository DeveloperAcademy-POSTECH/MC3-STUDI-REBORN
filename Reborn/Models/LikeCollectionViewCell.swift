//
//  LikeCollectionViewCell.swift
//  Reborn
//
//  Created by Hyemin Choi on 2022/07/19.
//

import UIKit

class LikeCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "LikeCollectionViewCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setImageViewConstraints()

    }

//    하트버튼
    private let heartImageView: UIImageView = {
        let image = UIImage(systemName: "heart.fill")
        let imageView = UIImageView(image: image)
        imageView.clipsToBounds = true
        imageView.tintColor = UIColor(named: "CRed")
        return imageView
    }()
    
//    이미지
    private let animalImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "1.png")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 14
        return imageView
    }()
    
//    레이블
    private let animalLabel: UILabel = {
        let label = UILabel()
        label.text = "공고 종료 1일 전"
        label.backgroundColor = UIColor(named: "CRed")
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 12, weight: .semibold)
        label.textAlignment = .center
        label.layer.cornerRadius = 12
        label.clipsToBounds = true
        return label
    }()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setImageViewConstraints() {
        self.addSubview(animalImageView)
        animalImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            animalImageView.topAnchor.constraint(equalTo: self.topAnchor),
            animalImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            animalImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            animalImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
        
        self.addSubview(animalLabel)
        animalLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            animalLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 27),
            animalLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),
            animalLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.6),
            animalLabel.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.1)
        ])
        
        self.addSubview(heartImageView)
        heartImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            heartImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 16),
            heartImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16)
        ])
    }
}




