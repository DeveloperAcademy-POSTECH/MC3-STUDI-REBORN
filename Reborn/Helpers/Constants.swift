//
//  Constants.swift
//  Animals
//
//  Created by 정호윤 on 2022/07/12.
//

import Foundation

//MARK: - Name Space

struct AnimalApi {
    static let requestUrl = "http://apis.data.go.kr/1543061/abandonmentPublicSrvc/abandonmentPublic?_type=json"
    static let key = "serviceKey=n1TP%2BU609SiYa5OWk03fYi1r4ASh04%2F2g54Hixw8os6IIzkhypv3doFp8CT2m4s9jfgTm%2F1G%2BPspd3XmzkbDcw%3D%3D"
    static let stateQuery = "state=notice"
    static let pageNumberQuery = "pageNo=1"
    static let numberOfRowsQuery = "numOfRows=20"
}

struct Location {
    static let none = ""
    static let seoul = "upr_cd=6110000"
    static let gyeonggi = "upr_cd=6410000"
}
