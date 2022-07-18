//
//  AnimalInfoCell.swift
//  Reborn
//
//  Created by Park Kangwook on 2022/07/18.
//

import UIKit

// MARK: - AnimalInfoCell
class AnimalInfoCell: UITableViewCell {

    static let identifier = "AnimalInfoCell"

    // MARK: - init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    // MARK: - fatalError
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
