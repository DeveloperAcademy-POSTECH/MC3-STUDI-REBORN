//
//  DescriptionInfoView.swift
//  Reborn
//
//  Created by peo on 2022/07/20.
//

import UIKit

final class DescriptionInfoView: UIView {
    
    // MARK: - Properties
    
    let title: BaseLabel = {
        let label = BaseLabel(size: 18, weight: .bold)
        label.text = "아이의 특징"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .leading
        stackView.distribution = .fillProportionally
        stackView.spacing = 0
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    let categoryStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    let informationStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    // Kind
    let kindInfoTitle: BaseLabel = {
        let label = BaseLabel(size: 14, textColor: .cDarkGray, weight: .regular)
        label.text = "품종"
        return label
    }()
    let kindInfoLabel: BaseLabel = {
        let label = BaseLabel(size: 14, weight: .regular)
        label.text = "[개] 불독"
        return label
    }()
    
    // Color
    let colorInfoTitle: BaseLabel = {
        let label = BaseLabel(size: 14, textColor: .cDarkGray, weight: .regular)
        label.text = "색상"
        return label
    }()
    let colorInfoLabel: BaseLabel = {
        let label = BaseLabel(size: 14, weight: .regular)
        label.text = "베이지"
        return label
    }()
    
    // Sex
    let sexInfoTitle: BaseLabel = {
        let label = BaseLabel(size: 14, textColor: .cDarkGray, weight: .regular)
        label.text = "성별"
        return label
    }()
    let sexInfoLabel: BaseLabel = {
        let label = BaseLabel(size: 14, weight: .regular)
        label.text = "M"
        return label
    }()
    
    // Neutering
    let neuteringInfoTitle: BaseLabel = {
        let label = BaseLabel(size: 14, textColor: .cDarkGray, weight: .regular)
        label.text = "중성화"
        return label
    }()
    let neuteringInfoLabel: BaseLabel = {
        let label = BaseLabel(size: 14, weight: .regular)
        label.text = "Y"
        return label
    }()
    
    // Age
    let ageInfoTitle: BaseLabel = {
        let label = BaseLabel(size: 14, textColor: .cDarkGray, weight: .regular)
        label.text = "나이"
        return label
    }()
    let ageInfoLabel: BaseLabel = {
        let label = BaseLabel(size: 14, weight: .regular)
        label.text = "2018(년생)"
        return label
    }()
    
    // Weight
    let weightInfoTitle: BaseLabel = {
        let label = BaseLabel(size: 14, textColor: .cDarkGray, weight: .regular)
        label.text = "체중"
        return label
    }()
    let weightInfoLabel: BaseLabel = {
        let label = BaseLabel(size: 14, weight: .regular)
        label.text = "5(Kg)"
        return label
    }()
    
    // Characters
    let charactersInfoTitle: BaseLabel = {
        let label = BaseLabel(size: 14, textColor: .cDarkGray, weight: .regular)
        label.text = "특징"
        return label
    }()
    let charactersInfoLabel: BaseLabel = {
        let label = BaseLabel(size: 14, weight: .regular)
        label.text = "온순하고 차분함, 사상충감염"
        label.numberOfLines = 0
        return label
    }()
    
    // Location
    let locationInfoTitle: BaseLabel = {
        let label = BaseLabel(size: 14, textColor: .cDarkGray, weight: .regular)
        label.text = "발견장소"
        return label
    }()
    let locationInfoLabel: BaseLabel = {
        let label = BaseLabel(size: 14, weight: .regular)
        label.text = "가야읍 왕궁2길 19-1"
        label.numberOfLines = 0
        return label
    }()
    
    // MARK: - Methods
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        makeSubviews()
        makeConstraints()
    }
    
    private func makeSubviews() {
        [kindInfoTitle,
         colorInfoTitle,
         sexInfoTitle,
         neuteringInfoTitle,
         ageInfoTitle,
         weightInfoTitle,
         charactersInfoTitle,
         locationInfoTitle].forEach { categoryStackView.addArrangedSubview($0) }
        
        [kindInfoLabel,
         colorInfoLabel,
         sexInfoLabel,
         neuteringInfoLabel,
         ageInfoLabel,
         weightInfoLabel,
         charactersInfoLabel,
         locationInfoLabel].forEach { informationStackView.addArrangedSubview($0) }
        
        [categoryStackView,
         informationStackView].forEach { stackView.addArrangedSubview($0) }
        
        [title, stackView].forEach { self.addSubview($0) }
    }
    
    private func makeConstraints() {
        let titleConstraints = [title.leadingAnchor.constraint(equalTo: self.leadingAnchor),
                                title.topAnchor.constraint(equalTo: self.topAnchor)]
        
        let stackViewConstraints = [stackView.leadingAnchor.constraint(equalTo: title.leadingAnchor),
                                    stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
                                    stackView.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 20),
                                    stackView.bottomAnchor.constraint(equalTo: bottomAnchor)]
        
        [titleConstraints, stackViewConstraints].forEach { NSLayoutConstraint.activate($0) }
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}
