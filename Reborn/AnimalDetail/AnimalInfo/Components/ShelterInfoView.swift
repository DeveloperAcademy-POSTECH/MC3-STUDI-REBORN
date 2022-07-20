//
//  ShelterInfoView.swift
//  Reborn
//
//  Created by peo on 2022/07/20.
//

import UIKit

final class ShelterInfoView: UIView {
    
    // MARK: - Properties
    
    let title: BaseLabel = {
        let label = BaseLabel(size: 18, weight: .bold)
        label.text = "아이가 머무는 곳"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    // Name
    let nameInfo: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .leading
        stackView.spacing = 14
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    let nameInfoTitle: BaseLabel = {
        let label = BaseLabel(size: 14, textColor: .cDarkGray, weight: .regular)
        label.text = "보호소명"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let nameInfoLabel: BaseLabel = {
        let label = BaseLabel(size: 14, weight: .regular)
        label.text = "경주시 동물사랑보호센터"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // Address
    let addressInfo: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .leading
        stackView.spacing = 40
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    let addressInfoTitle: BaseLabel = {
        let label = BaseLabel(size: 14, textColor: .cDarkGray, weight: .regular)
        label.text = "주소"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let addressInfoLabel: BaseLabel = {
        let label = BaseLabel(size: 14, weight: .regular)
        label.text = "경상북도 경주시 천북면 천북로 8-4"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // Contact
    let contactInfo: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .leading
        stackView.spacing = 27
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    let contactInfoTitle: BaseLabel = {
        let label = BaseLabel(size: 14, textColor: .cDarkGray, weight: .regular)
        label.text = "연락처"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let contactInfoLabel: BaseLabel = {
        let label = BaseLabel(size: 14, weight: .regular)
        label.text = "010-1234-1234"
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
        [title, stackView].forEach { self.addSubview($0) }
        [nameInfo, addressInfo, contactInfo].forEach { stackView.addArrangedSubview($0) }
        
        [nameInfoTitle, nameInfoLabel].forEach { nameInfo.addArrangedSubview($0) }
        [addressInfoTitle, addressInfoLabel].forEach { addressInfo.addArrangedSubview($0) }
        [contactInfoTitle, contactInfoLabel].forEach { contactInfo.addArrangedSubview($0) }
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
