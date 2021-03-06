//
//  BenefitHeader.swift
//  Reborn
//
//  Created by κΉλ¨κ±΄ on 2022/07/20.
//

import UIKit

final class AnimalListTableViewHeader: UIView {
    static let id = "BenefitHeader"
    static let height: CGFloat = 125
    
    private var linkLabel: UILabel = {
        let linkLabel = BaseLabel(size: 16, weight: .semibold)
        linkLabel.text = "π μμΈνΉλ³μμ μμ ννμ νμΈν΄λ³΄μΈμ"
        
        return linkLabel
    }()
    
    private var linkUrlString = "https://www.naver.com"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
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
        topLabel.text = "μμμ κΈ°λ€λ¦¬λ μμ΄λ€"
        
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
        // μΆμ²: https://zeddios.tistory.com/375 [ZeddiOS:ν°μ€ν λ¦¬]
    }
}
