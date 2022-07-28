//
//  LikedAnimal+Extensions.swift
//  Reborn
//
//  Created by 김남건 on 2022/07/28.
//

import Foundation

extension LikedAnimal {
    var leftDays: Int {
        let now = Date()
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyyMMdd"
        
        let formattedDate = formatter.date(from: noticeEndDate ?? "0")
        let leftDays = now.distance(to: formattedDate!) / (60 * 60 * 24)
        return Int(leftDays)
    }
}
