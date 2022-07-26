//
//  AnimalInfoView.swift
//  Reborn
//
//  Created by peo on 2022/07/20.
//

import UIKit

final class AnimalInfoView: UIView {
    
    // MARK: - Properties
    
    let noticeInfoView: NoticeInfoView = {
        let noticeInfoView = NoticeInfoView()
        noticeInfoView.translatesAutoresizingMaskIntoConstraints = false
        return noticeInfoView
    }()
    
    let divider: UIView = {
        let view = UIView()
        view.backgroundColor = .cLightGray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let descriptionInfoView: DescriptionInfoView = {
        let descriptionInfoView = DescriptionInfoView()
        descriptionInfoView.translatesAutoresizingMaskIntoConstraints = false
        return descriptionInfoView
    }()
    
    let shelterInfoView: ShelterInfoView = {
        let shelterInfoView = ShelterInfoView()
        shelterInfoView.translatesAutoresizingMaskIntoConstraints = false
        return shelterInfoView
    }()
    
    // MARK: - Methods
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .white
        
        makeSubviews()
        makeConstraints()
    }
    
    private func makeSubviews() {
        [noticeInfoView,
         divider,
         descriptionInfoView,
         shelterInfoView].forEach { self.addSubview($0) }
    }
    
    private func makeConstraints() {
        let noticeInfoViewConstraints = [noticeInfoView.topAnchor.constraint(equalTo: self.topAnchor),
                                         noticeInfoView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
                                         noticeInfoView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20)]
        
        let dividerConstraints = [divider.topAnchor.constraint(equalTo: noticeInfoView.bottomAnchor, constant: 20),
                                  divider.leadingAnchor.constraint(equalTo: self.leadingAnchor),
                                  divider.trailingAnchor.constraint(equalTo: self.trailingAnchor),
                                  divider.heightAnchor.constraint(equalToConstant: 8)]
        
        let descriptionInfoViewConstraints = [descriptionInfoView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
                                              descriptionInfoView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
                                              descriptionInfoView.topAnchor.constraint(equalTo: divider.bottomAnchor, constant: 20)]
        
        let shelterInfoViewConstraints = [shelterInfoView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
                                          shelterInfoView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
                                          shelterInfoView.topAnchor.constraint(equalTo: descriptionInfoView.bottomAnchor, constant: 40)]
        
        [noticeInfoViewConstraints,
         dividerConstraints,
         descriptionInfoViewConstraints,
         shelterInfoViewConstraints].forEach { NSLayoutConstraint.activate($0) }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

