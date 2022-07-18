//
//  AnimalListViewController.swift
//  Reborn
//
//  Created by 김남건 on 2022/07/18.
//

import UIKit

class AnimalListViewController: UIViewController {
    private let locationLabel: BaseLabel = {
        let label = BaseLabel(size: 20, weight: .semibold)
        label.text = "서울특별시"
        
        return label
    }()
    
    var locationMenu: UIMenu {
        let locations = ["서울특별시", "대전광역시", "부산광역시", "세종특별자치시", "충정북도", "충청남도", "경상북도", "경상남도", "전라북도", "전라남도", "강원도", "경기도", "제주특별자치도"]
        var actions = [UIAction]()
        
        for location in locations {
            actions.append(UIAction(title: location) { _ in self.changeLocation(to: location) })
        }
        
        return UIMenu(children: actions)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        configureNavigationBar()
    }
}

// MARK: - navigation bar button items
extension AnimalListViewController {
    private func configureNavigationBar() {
        addLocationItem()
    }
    
    // MARK: - location item
    private func addLocationItem() {
        let labelStack = generateLocationLabelStack()
        let button = wrapWithButton(subview: labelStack)
        
        if #available(iOS 14.0, *) {
            button.menu = locationMenu
            button.showsMenuAsPrimaryAction = true
        }
        
        let item = UIBarButtonItem(customView: button)
        navigationItem.leftBarButtonItem = item
    }
    
    private func generateLocationLabelStack() -> UIStackView {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.alignment = .center
        stack.spacing = 6
        
        let chevronImageView = UIImageView.ofSystemImage(systemName: "chevron.down", fontSize: 20)
        [locationLabel, chevronImageView].forEach { stack.addArrangedSubview($0) }
        
        return stack
    }
    
    private func wrapWithButton(subview: UIView) -> UIButton {
        let button = UIButton()
        
        button.translatesAutoresizingMaskIntoConstraints = false
        subview.translatesAutoresizingMaskIntoConstraints = false
        button.addSubview(subview)
        
        NSLayoutConstraint.activate([
            button.leadingAnchor.constraint(equalTo: subview.leadingAnchor),
            button.trailingAnchor.constraint(equalTo: subview.trailingAnchor),
            button.topAnchor.constraint(equalTo: subview.topAnchor),
            button.bottomAnchor.constraint(equalTo: subview.bottomAnchor)
        ])
        
        return button
    }
    
    private func changeLocation(to location: String) {
        locationLabel.text = location
        
        // TODO: 지역 변경 시 추가 로직 구현
    }
}
