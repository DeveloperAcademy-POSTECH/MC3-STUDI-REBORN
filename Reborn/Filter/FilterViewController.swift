//
//  FilterViewController.swift
//  Animals
//
//  Created by 정호윤 on 2022/07/18.
//

import UIKit

final class FilterViewController: UIViewController {
    
    private var filters: Set<String> = []
    
    weak var delegate: FilterDelegate?
    
    enum Tag: Int {
        case dog = 1
        case cat
        case etc
    }
    
    // MARK: - 품종
    private let headerLabel: UILabel = {
        let label = UILabel()
        label.text = "품종"
        label.font = .boldSystemFont(ofSize: 18)
        return label
    }()
    
    private let dogButton: FilterCategoryButton = {
        let button = FilterCategoryButton()
        button.setTitle("🐶강아지", for: .normal)
        button.tag = Tag.dog.rawValue
        button.addTarget(self, action: #selector(categoryButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private let catButton: FilterCategoryButton = {
        let button = FilterCategoryButton()
        button.setTitle("🐱고양이", for: .normal)
        button.tag = Tag.cat.rawValue
        button.addTarget(self, action: #selector(categoryButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private let etcButton: FilterCategoryButton = {
        let button = FilterCategoryButton()
        button.setTitle("기타", for: .normal)
        button.tag = Tag.etc.rawValue
        button.addTarget(self, action: #selector(categoryButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var buttonStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [dogButton, catButton, etcButton])
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        stackView.spacing = 10
        return stackView
    }()
    
    private lazy var superStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [headerLabel, buttonStack])
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.spacing = 20
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
    @objc private func categoryButtonTapped(sender: FilterCategoryButton) {
        sender.isOn.toggle()
        
        if sender.isOn == true {
            switch sender.tag {
            case Tag.dog.rawValue:
                filters.insert("개")
            case Tag.cat.rawValue:
                filters.insert("고양이")
            case Tag.etc.rawValue:
                filters.insert("기타")
            default:
                filters.insert(sender.currentTitle ?? "")
            }
        } else {
            switch sender.tag {
            case Tag.dog.rawValue:
                filters.remove("개")
            case Tag.cat.rawValue:
                filters.remove("고양이")
            case Tag.etc.rawValue:
                filters.remove("기타")
            default:
                filters.remove(sender.currentTitle ?? "")
            }
        }
        
        print(filters)
    }
    
    @objc private func resetButtonTapped(sender: UIButton) {
        [dogButton, catButton, etcButton].forEach { $0.isOn = false }
        filters.removeAll()
    }
    
    @objc private func applyButtonTapped(sender: UIButton) {
        let filtersArray = Array(filters)
        delegate?.applyFilter(by: filtersArray)
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
    func setSuperStackConstraints() {
        view.addSubview(superStack)
        superStack.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            superStack.topAnchor.constraint(equalTo: view.topAnchor, constant: 65),
            superStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            superStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }
    
    func setbottomButtonStackViewConstraints() {
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


