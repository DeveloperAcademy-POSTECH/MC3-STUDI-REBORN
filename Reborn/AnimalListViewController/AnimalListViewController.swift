//
//  AnimalListViewController.swift
//  Reborn
//
//  Created by 김남건 on 2022/07/18.
//

import UIKit

final class AnimalListViewController: UIViewController {
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
    
    private lazy var locationItem: UIBarButtonItem = {
        let labelStack = generateLocationLabelStack()
        let button = wrapWithButton(subview: labelStack)
        
        if #available(iOS 14.0, *) {
            button.menu = locationMenu
            button.showsMenuAsPrimaryAction = true
        }
        
        return UIBarButtonItem(customView: button)
    }()
    
    private lazy var likeItem: UIBarButtonItem = {
        let likeImageView = UIImageView.ofSystemImage(systemName: "heart", fontSize: 22, weight: .medium)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(goToLikeListViewController))
        likeImageView.gestureRecognizers = [tapGesture]
        
        return UIBarButtonItem(customView: likeImageView)
    }()
    
    private lazy var filterItem: UIBarButtonItem = {
        let filterImageView = UIImageView.ofSystemImage(systemName: "slider.horizontal.3", fontSize: 22, weight: .medium)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(popUpFilterModal))
        filterImageView.gestureRecognizers = [tapGesture]
        
        return UIBarButtonItem(customView: filterImageView)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        configureNavigationBar()
    }
    
    private func configureNavigationBar() {
        navigationItem.leftBarButtonItem = locationItem
        
        let spacer = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
        spacer.width = 15
        navigationItem.rightBarButtonItems = [filterItem, spacer, likeItem]
    }
}

// MARK: - locationItem
extension AnimalListViewController {
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

// MARK: - likeItem
extension AnimalListViewController {
    @objc private func goToLikeListViewController() {
        // TODO: LikeListViewController로 변경
        let dummyVC = UIViewController()
        dummyVC.view.backgroundColor = .black
        
        navigationController?.pushViewController(dummyVC, animated: true)
    }
}

// MARK: - filterItem
extension AnimalListViewController {
    @objc private func popUpFilterModal() {
        // TODO: FilterViewController로 변경
        let dummyVC = UIViewController()
        dummyVC.view.backgroundColor = .black
        
        navigationController?.present(dummyVC, animated: true)
    }
}
