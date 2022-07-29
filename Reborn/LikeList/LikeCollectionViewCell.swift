//
//  LikeCollectionViewCell.swift
//  Reborn
//
//  Created by Hyemin Choi on 2022/07/19.
//

import UIKit

final class LikeCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "LikeCollectionViewCell"
    private let coreDataManager = CoreDataManager.shared
    weak var delegate: LikedAnimalCellDelegate?
    var index: Int!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setImageViewConstraints()

    }
    
    var likedAnimal: LikedAnimal! {
        didSet {
            leftDaysView.leftDays = likedAnimal.leftDays
            setImage(urlString: likedAnimal.detailImage)
        }
    }
    
    //하트버튼
    private lazy var heartButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(systemName: "heart.fill"), for: UIControl.State.normal)
        button.clipsToBounds = true
        button.tintColor = .cRed
        button.addTarget(self, action: #selector(heartButtonTouch), for: .touchUpInside)
        return button
    }()
    
    //동물이미지
    private let animalImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .gray
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 14
        return imageView
    }()
    
    //공고날짜 레이블
    private let leftDaysView = LeftDaysView(leftDays: 1)
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //오토레이아웃
    func setImageViewConstraints() {
        self.addSubview(animalImageView)
        animalImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            animalImageView.topAnchor.constraint(equalTo: self.topAnchor),
            animalImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            animalImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            animalImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
        
        self.addSubview(leftDaysView)
        leftDaysView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            leftDaysView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            leftDaysView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),
        ])
        
        contentView.addSubview(heartButton)
        heartButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            heartButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 16),
            heartButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16)
        ])
    }
    
    var isLiked = true
    
    //하트버튼 터치
    @objc func heartButtonTouch(){
        isLiked.toggle()
        changeHeartImage()
        delegate?.didClickHeartButton(at: index)
    }
    
    private func changeHeartImage() {
        heartButton.setBackgroundImage(UIImage(systemName: isLiked ? "heart.fill" : "heart"), for: .normal)
        heartButton.tintColor = isLiked ? .cRed : .cGray
    }
    
    private func setImage(urlString: String?) {
        guard let urlString = urlString, let url = URL(string: urlString) else { return }
        
        DispatchQueue.global().async {
            guard let data = try? Data(contentsOf: url) else { return }
            guard urlString == url.absoluteString else { return }
            
            DispatchQueue.main.async {
                self.animalImageView.image = UIImage(data: data)
            }
        }
    }
}

