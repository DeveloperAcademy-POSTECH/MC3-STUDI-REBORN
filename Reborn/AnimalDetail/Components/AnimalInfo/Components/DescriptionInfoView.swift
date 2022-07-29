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
    let kindStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 14
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    let kindInfoTitle: BaseLabel = {
        let label = BaseLabel(size: 14, textColor: .cDarkGray, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.widthAnchor.constraint(equalToConstant: 50).isActive = true
        label.text = "품종"
        return label
    }()
    let kindInfoLabel: BaseLabel = {
        let label = BaseLabel(size: 14, weight: .regular)
        label.text = ""
        return label
    }()
    
    // Color
    let colorStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 14
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    let colorInfoTitle: BaseLabel = {
        let label = BaseLabel(size: 14, textColor: .cDarkGray, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.widthAnchor.constraint(equalToConstant: 50).isActive = true
        label.text = "색상"
        return label
    }()
    let colorInfoLabel: BaseLabel = {
        let label = BaseLabel(size: 14, weight: .regular)
        label.text = ""
        return label
    }()
    
    // Sex
    let sexStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 14
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    let sexInfoTitle: BaseLabel = {
        let label = BaseLabel(size: 14, textColor: .cDarkGray, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.widthAnchor.constraint(equalToConstant: 50).isActive = true
        label.text = "성별"
        return label
    }()
    let sexInfoLabel: BaseLabel = {
        let label = BaseLabel(size: 14, weight: .regular)
        label.text = ""
        return label
    }()
    
    // Neutering
    let neuteringStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 14
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    let neuteringInfoTitle: BaseLabel = {
        let label = BaseLabel(size: 14, textColor: .cDarkGray, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.widthAnchor.constraint(equalToConstant: 50).isActive = true
        label.text = "중성화"
        return label
    }()
    let neuteringInfoLabel: BaseLabel = {
        let label = BaseLabel(size: 14, weight: .regular)
        label.text = ""
        return label
    }()
    
    // Age
    let ageStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 14
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    let ageInfoTitle: BaseLabel = {
        let label = BaseLabel(size: 14, textColor: .cDarkGray, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.widthAnchor.constraint(equalToConstant: 50).isActive = true
        label.text = "나이"
        return label
    }()
    let ageInfoLabel: BaseLabel = {
        let label = BaseLabel(size: 14, weight: .regular)
        label.text = ""
        return label
    }()
    
    // Weight
    let weightStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 14
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    let weightInfoTitle: BaseLabel = {
        let label = BaseLabel(size: 14, textColor: .cDarkGray, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.widthAnchor.constraint(equalToConstant: 50).isActive = true
        label.text = "체중"
        return label
    }()
    let weightInfoLabel: BaseLabel = {
        let label = BaseLabel(size: 14, weight: .regular)
        label.text = ""
        return label
    }()
    
    // Characters
    let charactersStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .top
        stackView.spacing = 14
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    let charactersInfoTitle: BaseLabel = {
        let label = BaseLabel(size: 14, textColor: .cDarkGray, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.widthAnchor.constraint(equalToConstant: 50).isActive = true
        label.text = "특징"
        return label
    }()
    let charactersInfoLabel: BaseLabel = {
        let label = BaseLabel(size: 14, weight: .regular)
        label.text = ""
        label.numberOfLines = 0
        return label
    }()
    
    // Location
    let locationStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .top
        stackView.spacing = 14
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    let locationInfoTitle: BaseLabel = {
        let label = BaseLabel(size: 14, textColor: .cDarkGray, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.widthAnchor.constraint(equalToConstant: 50).isActive = true
        label.text = "발견장소"
        return label
    }()
    let locationInfoLabel: BaseLabel = {
        let label = BaseLabel(size: 14, weight: .regular)
        label.text = ""
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
        [kindInfoTitle, kindInfoLabel].forEach { kindStackView.addArrangedSubview($0)}
        [colorInfoTitle, colorInfoLabel].forEach { colorStackView.addArrangedSubview($0)}
        [sexInfoTitle, sexInfoLabel].forEach { sexStackView.addArrangedSubview($0)}
        [neuteringInfoTitle, neuteringInfoLabel].forEach { neuteringStackView.addArrangedSubview($0)}
        [ageInfoTitle, ageInfoLabel].forEach { ageStackView.addArrangedSubview($0)}
        [weightInfoTitle, weightInfoLabel].forEach { weightStackView.addArrangedSubview($0)}
        [charactersInfoTitle, charactersInfoLabel].forEach { charactersStackView.addArrangedSubview($0)}
        [locationInfoTitle, locationInfoLabel].forEach { locationStackView.addArrangedSubview($0)}
        
        [kindStackView,
         colorStackView,
         sexStackView,
         neuteringStackView,
         ageStackView,
         weightStackView,
         charactersStackView,
         locationStackView].forEach { stackView.addArrangedSubview($0) }
        
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
