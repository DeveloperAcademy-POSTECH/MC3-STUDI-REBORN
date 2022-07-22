//
//  UIImageView.swift
//  Reborn
//
//  Created by 김남건 on 2022/07/18.
//

import UIKit

extension UIImageView {
    static func ofSystemImage(systemName: String, fontSize: CGFloat, weight: UIImage.SymbolWeight = .semibold, color: UIColor? = .cBlack) -> UIImageView {
        let image = UIImage(systemName: systemName)
        let configuration = UIImage.SymbolConfiguration(pointSize: fontSize, weight: weight)
        
        let imageView = UIImageView(image: image)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.preferredSymbolConfiguration = configuration
        imageView.tintColor = color
        
        return imageView
    }
}
