//
//  BaseLabel.swift
//  Reborn
//
//  Created by peo on 2022/07/18.
//

import UIKit

final class BaseLabel: UILabel {
    
    init(
        size: CGFloat = 16,
        textColor: UIColor? = .cBlack,
        weight: UIFont.Weight = .regular
    ) {
        super.init(frame: .zero)
        self.textColor = textColor
        self.font = .systemFont(ofSize: size, weight: weight)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}
