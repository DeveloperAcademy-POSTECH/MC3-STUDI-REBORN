//
//  Animal.swift
//  Animals
//
//  Created by 정호윤 on 2022/07/11.
//

import Foundation

// MARK: - Animal
struct Animal: Codable {
    let response: Response
}

// MARK: - Response
struct Response: Codable {
    let header: Header
    let body: Body
}

// MARK: - Body
struct Body: Codable {
    let items: Items
    let numOfRows, pageNo, totalCount: Int
}

// MARK: - 유기동물 데이터 배열
struct Items: Codable {
    let item: [Item]
}

// MARK: - 유기동물 데이터
struct Item: Codable {
    
    let thumbnailImage: String?         // 메인화면 이미지
    
    let detailImage: String?            // 상세화면 이미지
    let noticeNumber: String?
    let noticeStartDate: String?
    let noticeEndDate: String?
    
    let kind: String?
    let color: String?
    let birth: String?                    // 나이 - 2019(년생)
    let sexCd: String?                    // 성별 - M, F, Q
    let neutralizationStatus: String?   // 중성화 여부 - Y, N, U
    let weight: String?
    let description: String?            // 특징
    let discoverdPlace: String?         // 발견장소
    
    let shelterName: String?
    let shelterAddress: String?
    let telNumber: String?              // 담당자 연락처
    
    // 응답 메시지 항목명 원하는 이름으로
    enum CodingKeys: String, CodingKey {
        case thumbnailImage = "filename"
        case detailImage = "popfile"
        case noticeNumber = "noticeNo"
        case noticeStartDate = "noticeSdt"
        case noticeEndDate = "noticeEdt"
        case kind = "kindCd"
        case color = "colorCd"
        case birth = "age"
        case sexCd = "sexCd"
        case neutralizationStatus = "neuterYn"
        case weight = "weight"
        case description = "specialMark"
        case discoverdPlace = "happenPlace"
        case shelterName = "careNm"
        case shelterAddress = "careAddr"
        case telNumber = "officetel"
    }
    
    // 공고 종료일 계산
    var noticeLeftDays: Int? {
        let now = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyyMMdd"
        
        let formattedDate = formatter.date(from: noticeEndDate ?? "0")
        let leftDays = now.distance(to: formattedDate!) / (60 * 60 * 24)
        return Int(leftDays)
    }
    
    // 성별 한글로 바꿔줌
    var sex: String? {
        if sexCd == "M" {
            return "남"
        } else if sexCd == "F" {
            return "여"
        } else {
            return "미상"
        }
    }
    
    // 나이 계산
    var age: Int? {
        Calendar.current.component(.year, from: Date()) - (Int(birth?.prefix(4) ?? "0") ?? 0) + 1
    }
    
}

// MARK: - Header
struct Header: Codable {
    let reqNo: Int
    let resultCode, resultMsg: String
}

