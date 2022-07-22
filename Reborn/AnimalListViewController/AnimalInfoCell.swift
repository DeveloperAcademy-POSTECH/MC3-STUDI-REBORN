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
    
    private let speciesLabel: BaseLabel = {
        let label = BaseLabel(size: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "품종"
        
        return label
    }()
    
    private let sexAgeLabel: BaseLabel = {
        let label = BaseLabel(size: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "성별, 나이"
        
        return label
    }()
    
    private let shelterLabel: BaseLabel = {
        let label = BaseLabel(size: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "보호소"
        
        return label
    }()
    
    private lazy var heartButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setBackgroundImage(UIImage(systemName: isLiked ? "heart.fill" : "heart"), for: .normal)
        button.tintColor = isLiked ? .cRed : .cDarkGray
        button.addTarget(self, action: #selector(toggleHeart), for: .touchUpInside)
        NSLayoutConstraint.activate([
            button.widthAnchor.constraint(equalToConstant: 22),
            button.heightAnchor.constraint(equalToConstant: 22)
        ])
        
        return button
    }()
    
    var isLiked = false {
        didSet {
            // TODO: Core Data 작업 추가
            changeHeartImage()
        }
    }
    
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
        
        let infoStack = generateInfoStack()
        contentView.addSubview(infoStack)
        NSLayoutConstraint.activate([
            infoStack.leadingAnchor.constraint(equalTo: daysLeftView.leadingAnchor),
            infoStack.topAnchor.constraint(equalTo: daysLeftView.bottomAnchor, constant: 14)
        ])
        
        contentView.addSubview(heartButton)
        NSLayoutConstraint.activate([
            heartButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            heartButton.bottomAnchor.constraint(equalTo: photoView.bottomAnchor)
        ])
    }
    
    private func generateInfoStack() -> UIStackView {
        let speicesRow = generateInfoRow(imageName: "pawprint.circle", label: speciesLabel)
        let sexAgeRow = generateInfoRow(imageName: "info.circle", label: sexAgeLabel)
        let shelterRow = generateInfoRow(imageName: "location.circle", label: shelterLabel)
        
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = 8
        stack.alignment = .leading
        
        [speicesRow, sexAgeRow, shelterRow].forEach { stack.addArrangedSubview($0) }
        
        return stack
    }
    
    private func generateInfoRow(imageName: String, label: UILabel) -> UIStackView {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.spacing = 5
        stack.alignment = .center
        
        let imageView = UIImageView.ofSystemImage(systemName: imageName, fontSize: 12, weight: .regular, color: .cDarkGray)
        [imageView, label].forEach { stack.addArrangedSubview($0) }
        
        return stack
    }
    
    @objc private func toggleHeart() {
        isLiked.toggle()
    }
    
    @objc private func changeHeartImage() {
        heartButton.setBackgroundImage(UIImage(systemName: isLiked ? "heart.fill" : "heart"), for: .normal)
        heartButton.tintColor = isLiked ? .cRed : .cDarkGray
    }
}
