//
//  AnimalInfoCell.swift
//  Reborn
//
//  Created by Park Kangwook on 2022/07/18.
//

import UIKit

// MARK: - AnimalInfoCell

final class AnimalInfoCell: UITableViewCell {

    static let identifier = "AnimalInfoCell"

    var animalImage = UIImageView()
    var animalKind = UILabel()
    var animalGenderAge = UILabel()
    var animalShelter = UILabel()
    var animalIsLiked = UIButton(type: .system)
    let daysLeftLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 12, weight: .semibold)
        label.textColor = .white
        label.text = "공고 종료 1일 전"
        return label
    }()
    
    // MARK: - init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.backgroundColor = .white
        
        [animalImage, animalKind, animalGenderAge, animalShelter, animalIsLiked, daysLeftLabel]
            .forEach { self.addSubview($0) }
        
        configure(text: "말티즈", imageName: "cat1", genderAge: "남 · 2세", shelter: "성주유기동물보호센터", isLiked: true)
        configureImage()
        configureAllText()
        configureLike()
        configureDaysLeftLabel()
        
        setImageConstraints()
        setAllTextConstraint()
        setLikeConstraint()
        setDaysLeftLabelConstraints()
    }
    
    // MARK: - configure 함수
    
    private func configure(text: String, imageName: String, genderAge: String, shelter: String, isLiked: Bool) {
        
        animalImage.image = UIImage(named: imageName)
        
        //text의 속성을 개별적으로 관리하고 싶아면 attributedText 사용
        //https://ios-development.tistory.com/359
        //https://www.hackingwithswift.com/articles/237/complete-guide-to-sf-symbols
        let kindSymbol = NSTextAttachment()
        kindSymbol.image = UIImage(systemName: "pawprint.circle")
        kindSymbol.image = UIImage(systemName: "pawprint.circle")?.withTintColor(.gray)

        let kindFullText = NSMutableAttributedString(attachment: kindSymbol)
        kindFullText.append(NSAttributedString(string: " \(text)"))
        animalKind.attributedText = kindFullText
        
        let genderAgeSymbol = NSTextAttachment()
        genderAgeSymbol.image = UIImage(systemName: "info.circle")
        genderAgeSymbol.image = UIImage(systemName: "info.circle")?.withTintColor(.gray)
        
        let genderAgeFullText = NSMutableAttributedString(attachment: genderAgeSymbol)
        genderAgeFullText.append(NSAttributedString(string: " \(genderAge)"))
        animalGenderAge.attributedText = genderAgeFullText
        
        let shelterSymbol = NSTextAttachment()
        shelterSymbol.image = UIImage(systemName: "location.circle")
        shelterSymbol.image = UIImage(systemName: "location.circle")?.withTintColor(.gray)

        let shelterFullText = NSMutableAttributedString(attachment: shelterSymbol)
        shelterFullText.append(NSAttributedString(string: " \(shelter)"))
        animalShelter.attributedText = shelterFullText
        
        if isLiked {
            animalIsLiked.setImage(UIImage(systemName: "heart.fill"),for: .normal)
        } else {
            animalIsLiked.setImage(UIImage(systemName: "heart"),for: .normal)
        }
    }

    // MARK: - configureImage 함수
    
    private func configureImage() {
        animalImage.clipsToBounds = true
        animalImage.layer.cornerRadius = 14
        animalImage.contentMode = .scaleAspectFill
    }
    
    // MARK: - configureText 함수
    
    private func configureAllText() {
        animalKind.numberOfLines = 0
        animalKind.adjustsFontSizeToFitWidth = true
        animalKind.font = .systemFont(ofSize: 14, weight: .regular)
        
        animalGenderAge.numberOfLines = 0
        animalGenderAge.adjustsFontSizeToFitWidth = true
        animalGenderAge.font = .systemFont(ofSize: 14, weight: .regular)
        
        animalShelter.numberOfLines = 0
        animalShelter.adjustsFontSizeToFitWidth = true
        animalShelter.font = .systemFont(ofSize: 14, weight: .regular)
    }
    
    // MARK: - configureLike 함수
    
    private func configureLike() {  //하트 크기, 색깔 불확실
        animalIsLiked.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        
        if animalIsLiked.currentImage == UIImage(systemName: "heart") {
            animalIsLiked.tintColor = .gray
        } else {
            animalIsLiked.tintColor = .systemPink
        }
    }
    
    // MARK: - configureDaysLeftLabel 함수
    
    private func configureDaysLeftLabel() {
        daysLeftLabel.translatesAutoresizingMaskIntoConstraints = false
        daysLeftLabel.backgroundColor = UIColor(named: "CRed")
        daysLeftLabel.layer.cornerRadius = 12
        daysLeftLabel.clipsToBounds = true
    }
    
    // MARK: - setImageConstraints 함수
    
    private func setImageConstraints() {
        animalImage.translatesAutoresizingMaskIntoConstraints = false   //false로 설정해야 오토레이아웃 가능
        
        //activate 한번에 묶는게 성능 향상에 좋음
        NSLayoutConstraint.activate([
            animalImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            animalImage.heightAnchor.constraint(equalToConstant: 140),
            animalImage.widthAnchor.constraint(equalToConstant: 140),
            animalImage.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
    // MARK: - setAllTextConstraint 함수
    
    private func setAllTextConstraint() {
        animalKind.translatesAutoresizingMaskIntoConstraints = false
        animalGenderAge.translatesAutoresizingMaskIntoConstraints = false
        animalShelter.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            animalKind.leadingAnchor.constraint(equalTo: animalImage.trailingAnchor, constant: 20),
            animalKind.topAnchor.constraint(equalTo: animalImage.topAnchor, constant: 38),
            
            animalGenderAge.leadingAnchor.constraint(equalTo: animalImage.trailingAnchor, constant: 20),
            animalGenderAge.topAnchor.constraint(equalTo: animalKind.bottomAnchor, constant: 6),

            animalShelter.leadingAnchor.constraint(equalTo: animalImage.trailingAnchor, constant: 20),
            animalShelter.topAnchor.constraint(equalTo: animalGenderAge.bottomAnchor, constant: 6)
        ])
    }

    // MARK: - setLikeConstraint 함수
    
    private func setLikeConstraint() {  //constant 불확실
        animalIsLiked.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            animalIsLiked.leadingAnchor.constraint(equalTo: animalImage.leadingAnchor, constant: 323),
            animalIsLiked.topAnchor.constraint(equalTo: animalImage.topAnchor, constant: 109)
        ])
    }
    
    // MARK: - setDaysLeftLabelConstraints 함수
    
    private func setDaysLeftLabelConstraints() {
        animalIsLiked.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            daysLeftLabel.topAnchor.constraint(equalTo: animalImage.topAnchor),
            daysLeftLabel.leadingAnchor.constraint(equalTo: animalImage.trailingAnchor, constant: 20)
        ])
    }
    
    // MARK: - fatalError
    
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
