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
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    // Name
    let nameStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .top
        stackView.spacing = 14
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    let nameInfoTitle: BaseLabel = {
        let label = BaseLabel(size: 14, textColor: .cDarkGray, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.widthAnchor.constraint(equalToConstant: 50).isActive = true
        label.text = "보호소명"
        return label
    }()
    let nameInfoLabel: BaseLabel = {
        let label = BaseLabel(size: 14, weight: .regular)
        label.text = ""
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // Address
    let addressStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .top
        stackView.spacing = 14
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    let addressInfoTitle: BaseLabel = {
        let label = BaseLabel(size: 14, textColor: .cDarkGray, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.widthAnchor.constraint(equalToConstant: 50).isActive = true
        label.text = "주소"
        return label
    }()
    let addressInfoLabel: BaseLabel = {
        let label = BaseLabel(size: 14, weight: .regular)
        label.text = ""
        label.numberOfLines = 0
        return label
    }()
    
    // Contact
    let contactStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .top
        stackView.spacing = 14
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    let contactInfoTitle: BaseLabel = {
        let label = BaseLabel(size: 14, textColor: .cDarkGray, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.widthAnchor.constraint(equalToConstant: 50).isActive = true
        label.text = "연락처"
        return label
    }()
    let contactInfoLabel: BaseLabel = {
        let label = BaseLabel(size: 14, weight: .regular)
        label.text = ""
        return label
    }()
    
    // MARK: - Methods
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        makeSubviews()
        makeConstraints()
    }
    
    private func makeSubviews() {
        [nameInfoTitle, nameInfoLabel].forEach { nameStackView.addArrangedSubview($0) }
        [addressInfoTitle, addressInfoLabel].forEach { addressStackView.addArrangedSubview($0) }
        [contactInfoTitle, contactInfoLabel].forEach { contactStackView.addArrangedSubview($0) }
        
        [nameStackView,
         addressStackView,
         contactStackView].forEach { stackView.addArrangedSubview($0) }
        
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
