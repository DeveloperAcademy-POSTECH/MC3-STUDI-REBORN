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
    var animalItem: Item! {
        didSet {
            configureCell(animalItem: animalItem)
        }
    }
    
    var coreDataManager: CoreDataManager {
        CoreDataManager.shared
    }
    
    private let photoView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalToConstant: 140),
            imageView.heightAnchor.constraint(equalToConstant: 140)
        ])
        
        imageView.layer.cornerRadius = 14
        imageView.clipsToBounds = true
        imageView.backgroundColor = .gray
        
        return imageView
    }()
    
    let leftDaysView = LeftDaysView()
    
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
        button.addTarget(self, action: #selector(tapHeartButton), for: .touchUpInside)
        NSLayoutConstraint.activate([
            button.widthAnchor.constraint(equalToConstant: 22),
            button.heightAnchor.constraint(equalToConstant: 22)
        ])
        
        return button
    }()
    
    var isLiked = false {
        didSet {
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
        
        contentView.addSubview(leftDaysView)
        NSLayoutConstraint.activate([
            leftDaysView.topAnchor.constraint(equalTo: photoView.topAnchor),
            leftDaysView.leadingAnchor.constraint(equalTo: photoView.trailingAnchor, constant: 20)
        ])
        
        let infoStack = generateInfoStack()
        contentView.addSubview(infoStack)
        NSLayoutConstraint.activate([
            infoStack.leadingAnchor.constraint(equalTo: leftDaysView.leadingAnchor),
            infoStack.topAnchor.constraint(equalTo: leftDaysView.bottomAnchor, constant: 14)
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
    
    @objc private func tapHeartButton() {
        // TODO: Core Data 작업 추가
        if isLiked {
            coreDataManager.deleteLikedAnimal(animalItem)
        } else {
            coreDataManager.saveAnimal(animalItem)
        }
        
        isLiked = coreDataManager.getLikedAnimal(of: animalItem) != nil
        animalItem.isLiked = isLiked
        print(coreDataManager.getAllLikedAnimals().map { $0.id })
    }
    
    @objc private func changeHeartImage() {
        heartButton.setBackgroundImage(UIImage(systemName: isLiked ? "heart.fill" : "heart"), for: .normal)
        heartButton.tintColor = isLiked ? .cRed : .cDarkGray
    }
    
    private func configureCell(animalItem: Item) {
        leftDaysView.leftDays = animalItem.noticeLeftDays ?? 0
        speciesLabel.text = animalItem.kind ?? "품종"
        sexAgeLabel.text = "\(animalItem.sex ?? "성별 미상") · \(animalItem.age ?? 0)세"
        shelterLabel.text = animalItem.shelterName ?? "보호소 미상"
        isLiked = animalItem.isLiked
        
        guard let urlString = animalItem.detailImage, let url = URL(string: urlString) else { return }
        
        DispatchQueue.global().async {
            guard let data = try? Data(contentsOf: url) else { return }
            guard urlString == url.absoluteString else { return }
            
            DispatchQueue.main.async {
                self.photoView.image = UIImage(data: data)
            }
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        photoView.image = nil
        isLiked = false
        leftDaysView.leftDays = 0
        speciesLabel.text = "품종"
        sexAgeLabel.text = "성별 · 나이"
        shelterLabel.text = "보호소"
    }
}
