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
    
    private let daysLeftLabel: UILabel = {
        let label = BaseLabel(size: 12, textColor: .white, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "공고 종료 1일 전"
        
        return label
    }()
    
    private lazy var daysLeftView: UIView = {
        let view = UIView()
        view.backgroundColor = .cRed
        view.layer.cornerRadius = 12
        view.clipsToBounds = true
        
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(daysLeftLabel)
        
        NSLayoutConstraint.activate([
            daysLeftLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 14),
            daysLeftLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -14),
            daysLeftLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            view.heightAnchor.constraint(equalToConstant: 24)
        ])
        
        return view
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
        
        contentView.addSubview(daysLeftView)
        NSLayoutConstraint.activate([
            daysLeftView.topAnchor.constraint(equalTo: photoView.topAnchor),
            daysLeftView.leadingAnchor.constraint(equalTo: photoView.trailingAnchor, constant: 20)
        ])
    }
}
