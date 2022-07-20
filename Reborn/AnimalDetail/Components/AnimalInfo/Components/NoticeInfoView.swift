//
//  NoticeInfoView.swift
//  Reborn
//
//  Created by peo on 2022/07/20.
//

import UIKit

final class NoticeInfoView: UIView {
    
    // MARK: - Properties
    
    let noticeName: BaseLabel = {
        let label = BaseLabel(size: 18, weight: .bold)
        label.text = "경남-함안-2022-00286"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let noticeDate: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    let noticeDateTitle: BaseLabel = {
        let label = BaseLabel(size: 14, textColor: .cDarkGray, weight: .regular)
        label.text = "공고 기간"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let noticeDateNumber: BaseLabel = {
        let label = BaseLabel(size: 14, weight: .regular)
        label.text = "20220702 - 20220712"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: - Methods
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .white
        makeSubviews()
        makeConstraints()
    }
    
    private func makeSubviews() {
        [noticeDateTitle, noticeDateNumber].forEach { self.noticeDate.addArrangedSubview($0) }
        
        [noticeName, noticeDate].forEach { self.addSubview($0) }
    }
    
    private func makeConstraints() {
        let noticeNameConstraints = [noticeName.leadingAnchor.constraint(equalTo: self.leadingAnchor),
                                     noticeName.topAnchor.constraint(equalTo: self.topAnchor),]

        let noticeDateConstraints = [noticeDate.topAnchor.constraint(equalTo: noticeName.bottomAnchor, constant: 8),
                                     noticeDate.leadingAnchor.constraint(equalTo: noticeName.leadingAnchor),
                                     noticeDate.bottomAnchor.constraint(equalTo: self.bottomAnchor)]
        
        [noticeNameConstraints, noticeDateConstraints].forEach { NSLayoutConstraint.activate($0) }
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}
