//
//  AnimalInfoCell.swift
//  Reborn
//
//  Created by 김남건 on 2022/07/19.
//

import UIKit

final class AnimalInfoCell: UITableViewCell {
    static let reuseID = "AnimalInfoCell"
    static let rowHeight: CGFloat = 172
    
    private let photoView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        
        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalToConstant: 140),
            imageView.heightAnchor.constraint(equalToConstant: 140)
        ])
        
        imageView.layer.cornerRadius = 14
        imageView.clipsToBounds = true
        imageView.backgroundColor = .gray
        
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        contentView.addSubview(photoView)
        NSLayoutConstraint.activate([
            photoView.centerYAnchor.constraint(equalTo: centerYAnchor),
            photoView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20)
        ])
    }
}
