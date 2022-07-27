//
//  LeftDaysView.swift
//  Reborn
//
//  Created by 김남건 on 2022/07/22.
//

import UIKit

class LeftDaysView: UIView {
    private lazy var label: BaseLabel = {
        let label = BaseLabel(size: 12, textColor: .white, weight: .semibold)
        label.text = "공고 종료 \(leftDays!)일 전"
        
        return label
    }()
    
    var leftDays: Int! {
        didSet {
            self.backgroundColor = viewColor
            label.text = "공고 종료 \(leftDays!)일 전"
        }
    }
    
    var viewColor: UIColor? {
        switch leftDays! {
        case 0...3:
            return .cRed
        case 4...6:
            return .cOrange
        case 7...:
            return .cGreen
        default:
            return .cGray
        }
    }
    
    init(leftDays: Int = 0) {
        super.init(frame: .zero)
        self.leftDays = leftDays
        setup()
    }
    
    private func setup() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = viewColor
        self.layer.cornerRadius = 12
        self.clipsToBounds = true
        
        label.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(label)
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 14),
            label.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -14),
            label.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            self.heightAnchor.constraint(equalToConstant: 24)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
