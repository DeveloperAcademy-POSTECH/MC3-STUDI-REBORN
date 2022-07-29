//
//  FilterCategoryButton.swift
//  Animals
//
//  Created by 정호윤 on 2022/07/18.
//

import UIKit

final class FilterCategoryButton: UIButton {
    
    var isOn: Bool = false {
        didSet {
            setView()
        }
    }
    
    // MARK: - init
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.clipsToBounds = true
        self.layer.cornerRadius = 18
        self.titleLabel?.font = .systemFont(ofSize: 16, weight: .regular)
        setView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - setView
    private func setView() {
        if isOn == false {
            self.backgroundColor = .systemGray6
            self.setTitleColor(.systemGray, for: .normal)
        } else {
            self.backgroundColor = .cGreen
            self.setTitleColor(.white, for: .normal)
        }
    }
    
}
