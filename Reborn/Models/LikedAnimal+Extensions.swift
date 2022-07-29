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
    
    var item: Item {
        var item = Item()
        item.id = id
        item.isLiked = true
        
        item.detailImage = self.detailImage
        item.noticeNumber = self.noticeNumber
        item.noticeStartDate = self.noticeStartDate
        item.noticeEndDate = self.noticeEndDate
        
        item.kind = self.kind
        item.color = self.color
        item.birth = self.birth
        item.sexCd = self.sexCd
        item.neutralizationStatus = self.neutralizationStatus
        
        item.weight = self.weight
        item.description = self.descript
        item.discoverdPlace = self.discoveredPlace
        
        item.shelterName = self.shelterName
        item.shelterAddress = self.shelterAddress
        item.telNumber = self.telNumber
        
        return item
    }
}
