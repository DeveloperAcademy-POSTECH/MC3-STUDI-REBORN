//
//  CustomDelegates.swift
//  Animals
//
//  Created by 정호윤 on 2022/07/19.
//

import Foundation

protocol FilterDelegate: AnyObject {
    func applyFilter(kind: String, neutralizationStatus: String)
}
