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

enum Region {
    
    case none
    case seoul
    case busan
    case daegu
    case incheon
    case gwangju
    case daejeon
    case ulsan
    case gyeonggi
    case gangwon
    case choongbook
    case choongnam
    case jeonbook
    case jeonnam
    case gyeongbook
    case gyeongnam
    case jeju
    
    var query: String {
        switch self {
        case .none:
            return ""
        case .seoul:
            return "upr_cd=6110000"
        case .busan:
            return "upr_cd=6260000"
        case .daegu:
            return "upr_cd=6270000"
        case .incheon:
            return "upr_cd=6280000"
        case .gwangju:
            return "upr_cd=6290000"
        case .daejeon:
            return "upr_cd=6300000"
        case .ulsan:
            return "upr_cd=6310000"
        case .gyeonggi:
            return "upr_cd=6410000"
        case .gangwon:
            return "upr_cd=6420000"
        case .choongbook:
            return "upr_cd=6430000"
        case .choongnam:
            return "upr_cd=6440000"
        case .jeonbook:
            return "upr_cd=6450000"
        case .jeonnam:
            return "upr_cd=6460000"
        case .gyeongbook:
            return "upr_cd=6470000"
        case .gyeongnam:
            return "upr_cd=6480000"
        case .jeju:
            return "upr_cd=6500000"
        }
    }
    
    var name: String {
        switch self {
        case .none:
            return "전국"
        case .seoul:
            return "서울특별시"
        case .busan:
            return "부산광역시"
        case .daegu:
            return "대구광역시"
        case .incheon:
            return "인천광역시"
        case .gwangju:
            return "광주광역시"
        case .daejeon:
            return "대전광역시"
        case .ulsan:
            return "울산광역시"
        case .gyeonggi:
            return "경기도"
        case .gangwon:
            return "강원도"
        case .choongbook:
            return "충청북도"
        case .choongnam:
            return "충청남도"
        case .jeonbook:
            return "전라북도"
        case .jeonnam:
            return "전라남도"
        case .gyeongbook:
            return "경상북도"
        case .gyeongnam:
            return "경상남도"
        case .jeju:
            return "제주특별자치도"
        }
    }
    
}


