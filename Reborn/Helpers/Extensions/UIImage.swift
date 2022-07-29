//
//  UIImage.swift
//  Reborn
//
//  Created by peo on 2022/07/29.
//

import UIKit

extension UIImage {
    func resized(width: CGFloat = 440, height: CGFloat = 420) -> UIImage {
        var size: CGSize = .init(width: width, height: height)
        if self.size.width > self.size.height {
            size.width = self.size.width * (height / self.size.height)
        }
        return UIGraphicsImageRenderer(size: size).image { _ in
            draw(in: CGRect(origin: .zero, size: size))
        }
    }
}
