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
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    // Kind
    let kindInfo: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .leading
        stackView.spacing = 40
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    let kindInfoTitle: BaseLabel = {
        let label = BaseLabel(size: 14, textColor: .cDarkGray, weight: .regular)
        label.text = "품종"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let kindInfoLabel: BaseLabel = {
        let label = BaseLabel(size: 14, weight: .regular)
        label.text = "[개] 불독"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // Color
    let colorInfo: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .leading
        stackView.spacing = 40
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    let colorInfoTitle: BaseLabel = {
        let label = BaseLabel(size: 14, textColor: .cDarkGray, weight: .regular)
        label.text = "색상"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let colorInfoLabel: BaseLabel = {
        let label = BaseLabel(size: 14, weight: .regular)
        label.text = "베이지"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // Sex
    let sexInfo: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .leading
        stackView.spacing = 40
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    let sexInfoTitle: BaseLabel = {
        let label = BaseLabel(size: 14, textColor: .cDarkGray, weight: .regular)
        label.text = "성별"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let sexInfoLabel: BaseLabel = {
        let label = BaseLabel(size: 14, weight: .regular)
        label.text = "M"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // Neutering
    let neuteringInfo: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .leading
        stackView.spacing = 27
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    let neuteringInfoTitle: BaseLabel = {
        let label = BaseLabel(size: 14, textColor: .cDarkGray, weight: .regular)
        label.text = "중성화"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let neuteringInfoLabel: BaseLabel = {
        let label = BaseLabel(size: 14, weight: .regular)
        label.text = "Y"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // Age
    let ageInfo: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .leading
        stackView.spacing = 40
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    let ageInfoTitle: BaseLabel = {
        let label = BaseLabel(size: 14, textColor: .cDarkGray, weight: .regular)
        label.text = "나이"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let ageInfoLabel: BaseLabel = {
        let label = BaseLabel(size: 14, weight: .regular)
        label.text = "2018(년생)"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // Weight
    let weightInfo: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .leading
        stackView.spacing = 40
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    let weightInfoTitle: BaseLabel = {
        let label = BaseLabel(size: 14, textColor: .cDarkGray, weight: .regular)
        label.text = "체중"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let weightInfoLabel: BaseLabel = {
        let label = BaseLabel(size: 14, weight: .regular)
        label.text = "5(Kg)"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // Characters
    let charactersInfo: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .leading
        stackView.spacing = 40
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    let charactersInfoTitle: BaseLabel = {
        let label = BaseLabel(size: 14, textColor: .cDarkGray, weight: .regular)
        label.text = "특징"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let charactersInfoLabel: BaseLabel = {
        let label = BaseLabel(size: 14, weight: .regular)
        label.text = "온순하고 차분함, 사상충감염"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // Location
    let locationInfo: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .leading
        stackView.spacing = 14
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    let locationInfoTitle: BaseLabel = {
        let label = BaseLabel(size: 14, textColor: .cDarkGray, weight: .regular)
        label.text = "발견장소"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let locationInfoLabel: BaseLabel = {
        let label = BaseLabel(size: 14, weight: .regular)
        label.text = "가야읍 왕궁2길 19-1"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: - Methods
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        makeSubviews()
        makeConstraints()
    }
    
    private func makeSubviews() {
        [kindInfoTitle, kindInfoLabel].forEach { kindInfo.addArrangedSubview($0) }
        [colorInfoTitle, colorInfoLabel].forEach { colorInfo.addArrangedSubview($0) }
        [sexInfoTitle, sexInfoLabel].forEach { sexInfo.addArrangedSubview($0) }
        [neuteringInfoTitle, neuteringInfoLabel].forEach { neuteringInfo.addArrangedSubview($0) }
        [ageInfoTitle, ageInfoLabel].forEach { ageInfo.addArrangedSubview($0) }
        [weightInfoTitle, weightInfoLabel].forEach { weightInfo.addArrangedSubview($0) }
        [charactersInfoTitle, charactersInfoLabel].forEach { charactersInfo.addArrangedSubview($0) }
        [locationInfoTitle, locationInfoLabel].forEach { locationInfo.addArrangedSubview($0) }
        
        [title, stackView].forEach { self.addSubview($0) }
        [kindInfo,
         colorInfo,
         sexInfo,
         neuteringInfo,
         ageInfo,
         weightInfo,
         charactersInfo,
         locationInfo].forEach { stackView.addArrangedSubview($0) }
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
