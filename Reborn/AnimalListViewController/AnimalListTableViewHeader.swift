//
//  BenefitHeader.swift
//  Reborn
//
//  Created by 김남건 on 2022/07/20.
//

import UIKit

final class AnimalListTableViewHeader: UIView {
    static let id = "BenefitHeader"
    static let height: CGFloat = 125
    
    var currentRegion: Region {
        didSet {
            linkLabel.text = "🎉 \(currentRegion.name)의 입양 혜택을 확인해보세요"
        }
    }
    
    private lazy var linkLabel: UILabel = {
        let linkLabel = BaseLabel(size: 16, weight: .semibold)
        linkLabel.text = "🎉 전국의 입양 혜택을 확인해보세요"
        
        return linkLabel
    }()
    
    private var linkUrlString = "https://www.naver.com"
    
    init(frame: CGRect, region: Region) {
        currentRegion = region
        super.init(frame: frame)
        linkLabel.text = "🎉 \(currentRegion.name)의 입양 혜택을 확인해보세요"
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.alignment = .leading
        
        let topLabel = generateTopLabel()
        stackView.addArrangedSubview(topLabel)
        
        
        let linkView = generateLinkView()
        stackView.addArrangedSubview(linkView)
        
        NSLayoutConstraint.activate([
            linkView.leadingAnchor.constraint(equalTo: stackView.leadingAnchor),
            linkView.trailingAnchor.constraint(equalTo: stackView.trailingAnchor),
            linkView.heightAnchor.constraint(equalToConstant: 66)
        ])
        
        addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - 40),
            stackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    func generateTopLabel() -> UILabel {
        let topLabel = BaseLabel(size: 22, weight: .semibold)
        topLabel.textColor = .cBlack
        topLabel.text = "입양을 기다리는 아이들"
        
        return topLabel
    }
    
    func generateLinkView() -> UIView {
        let linkContentStack = UIStackView()
        linkContentStack.translatesAutoresizingMaskIntoConstraints = false
        linkContentStack.axis = .horizontal
        linkContentStack.spacing = 6
        
        linkContentStack.addArrangedSubview(linkLabel)
        
        let chevronImageView = UIImageView.ofSystemImage(systemName: "chevron.right", fontSize: 16)
        linkContentStack.addArrangedSubview(chevronImageView)
        
        let linkView = UIView()
        linkView.translatesAutoresizingMaskIntoConstraints = false
        linkView.backgroundColor = .cBeige
        linkView.layer.cornerRadius = 14
        linkView.clipsToBounds = true
        
        linkView.addSubview(linkContentStack)
        NSLayoutConstraint.activate([
            linkContentStack.centerXAnchor.constraint(equalTo: linkView.centerXAnchor),
            linkContentStack.centerYAnchor.constraint(equalTo: linkView.centerYAnchor)
        ])
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(openLink))
        linkView.addGestureRecognizer(gesture)
        
        return linkView
    }
    
    @objc func openLink() {
        guard let url = URL(string: linkUrlString), UIApplication.shared.canOpenURL(url) else { return }
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
        // 출처: https://zeddios.tistory.com/375 [ZeddiOS:티스토리]
    }
}
