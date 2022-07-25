//
//  FilterViewController.swift
//  Animals
//
//  Created by 정호윤 on 2022/07/18.
//

import UIKit

final class FilterViewController: UIViewController {
    
    private var kind: String?
    private var neutralizationStatus: String?
    
    weak var delegate: FilterDelegate?
    
    // MARK: - 품종
    private let kindLabel: UILabel = {
        let label = UILabel()
        label.text = "품종"
        label.font = .boldSystemFont(ofSize: 18)
        return label
    }()
    
    private let dogButton: FilterCategoryButton = {
        let button = FilterCategoryButton()
        button.setTitle("🐶강아지", for: .normal)
        button.addTarget(self, action: #selector(kindButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private let catButton: FilterCategoryButton = {
        let button = FilterCategoryButton()
        button.setTitle("🐱고양이", for: .normal)
        button.addTarget(self, action: #selector(kindButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private let etcButton: FilterCategoryButton = {
        let button = FilterCategoryButton()
        button.setTitle("기타", for: .normal)
        button.addTarget(self, action: #selector(kindButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var firstButtonStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [dogButton, catButton, etcButton])
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        stackView.spacing = 10
        return stackView
    }()
    
    private lazy var firstSuperStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [kindLabel, firstButtonStack])
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.spacing = 20
        return stackView
    }()
    
    // MARK: - 중성화 여부
    
    private let neutralizedLabel: UILabel = {
        let label = UILabel()
        label.text = "중성화 여부"
        label.font = .boldSystemFont(ofSize: 18)
        return label
    }()
    
    private let yesButton: FilterCategoryButton = {
        let button = FilterCategoryButton()
        button.setTitle("예", for: .normal)
        button.addTarget(self, action: #selector(neutralizedButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private let noButton: FilterCategoryButton = {
        let button = FilterCategoryButton()
        button.setTitle("아니오", for: .normal)
        button.addTarget(self, action: #selector(neutralizedButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private let spacer: FilterCategoryButton = {
        let button = FilterCategoryButton()
        button.backgroundColor = .clear
        return button
    }()
    
    private lazy var secondButtonStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [yesButton, noButton, spacer])
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        stackView.spacing = 10
        return stackView
    }()
    
    private lazy var secondSuperStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [neutralizedLabel, secondButtonStack])
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.spacing = 20
        return stackView
    }()
    
    // MARK: - super stack
    
    private lazy var superStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [firstSuperStack, secondSuperStack])
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.spacing = 40
        return stackView
    }()
    
    // MARK: - 하단 버튼
    private let resetButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "goforward"), for: .normal)
        button.tintColor = .systemGray
        button.addTarget(self, action: #selector(resetButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private let applyButton: UIButton = {
        let button = UIButton()
        button.clipsToBounds = true
        button.layer.cornerRadius = 14
        button.backgroundColor = .systemGreen
        
        button.setTitle("적용하기", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 17, weight: .semibold)
        button.setTitleColor(.white, for: .normal)
        
        button.addTarget(self, action: #selector(applyButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var bottomButtonStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [resetButton, applyButton])
        stackView.axis = .horizontal
        stackView.distribution = .fillProportionally
        stackView.alignment = .fill
        stackView.spacing = 20
        return stackView
    }()
    
    // MARK: - buttonSelected
    
    func deselectKindButtons() {
        dogButton.isOn = false
        catButton.isOn = false
        etcButton.isOn = false
    }
    
    func deselectNeutralizationButtons() {
        yesButton.isOn = false
        noButton.isOn = false
    }
    
    @objc private func kindButtonTapped(sender: FilterCategoryButton) {
        deselectKindButtons()
        sender.isOn.toggle()
        
        if sender.isOn == true {
            switch sender.titleLabel?.text {
            case "🐶강아지": kind = "upkind=417000"
            case "🐱고양이": kind = "upkind=422400"
            case "기타": kind = "upkind=429900"
            default: kind = nil
            }
        } else {
            kind = nil
        }
    }
    
    @objc private func neutralizedButtonTapped(sender: FilterCategoryButton) {
        deselectNeutralizationButtons()
        sender.isOn.toggle()
        
        switch sender.titleLabel?.text {
        case "예": neutralizationStatus = "neuter_yn=Y"
        case "아니오": neutralizationStatus = "neuter_yn=N"
        default: neutralizationStatus = nil
        }
    }
    
    @objc private func resetButtonTapped(sender: UIButton) {
        [dogButton, catButton, etcButton, yesButton, noButton].forEach { $0.isOn = false }
        kind = nil
        neutralizationStatus = nil
    }
    
    @objc private func applyButtonTapped(sender: UIButton) {
        delegate?.applyFilter(kindQuery: kind ?? "", neutralizationStatusQuery: neutralizationStatus ?? "")
        dismiss(animated: true)
    }
    
    // MARK: - viewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setSuperStackConstraints()
        setbottomButtonStackViewConstraints()
    }
    
    // MARK: - autolayouts
    
    private func setSuperStackConstraints() {
        view.addSubview(superStack)
        superStack.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            superStack.topAnchor.constraint(equalTo: view.topAnchor, constant: 65),
            superStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            superStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }
    
    private func setbottomButtonStackViewConstraints() {
        view.addSubview(bottomButtonStackView)
        bottomButtonStackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            bottomButtonStackView.heightAnchor.constraint(equalToConstant: 52),
            bottomButtonStackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -40),
            bottomButtonStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            bottomButtonStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }
    
}


