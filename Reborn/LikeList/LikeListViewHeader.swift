//
//  LikeListViewHeader.swift
//  Reborn
//
//  Created by Hyemin Choi on 2022/07/26.
//

import UIKit

final class LikeListViewHeader: UICollectionReusableView {
    
    private let label: UILabel = {
        let label = UILabel()
        label.frame = CGRect(x: 20, y: 108, width: 350, height: 66)
        label.textColor = .cBlack
        label.backgroundColor = .cBeige
        label.text = "🐶  공고 종료된 아이들은 \n자동으로 목록에서 사라져요"
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        label.textAlignment = .center
        label.clipsToBounds = true
        label.layer.cornerRadius = 14
        label.numberOfLines = 0
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setBanner()
        setCollectionViewConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func setBanner() {
        let bannerView = UIStackView()
    }
    
    //공고종료 배너 오토레이아웃
    func setCollectionViewConstraints(){
        self.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: self.topAnchor, constant: 108),
            label.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            label.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            label.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }

}


