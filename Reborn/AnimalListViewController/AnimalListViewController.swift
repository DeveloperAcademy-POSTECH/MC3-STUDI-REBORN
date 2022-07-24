//
//  AnimalListViewController.swift
//  Reborn
//
//  Created by 김남건 on 2022/07/18.
//

import UIKit

final class CustomButton: UIButton {
    override var isHighlighted: Bool {
        didSet {
            alpha = isHighlighted ? 0.5 : 1
        }
    }
}

final class AnimalListViewController: UIViewController {
    var currentRegion: Region = .none
    let animalItems = [Item]()
    
    private lazy var regionLabel: BaseLabel = {
        let label = BaseLabel(size: 20, weight: .semibold)
        label.text = currentRegion.name
        
        return label
    }()
    
    var regionMenu: UIMenu {
        let actions = Region.allCases.map { region in
            UIAction(title: region.name) { _ in
                self.changeRegion(to: region)
            }
        }
        
        return UIMenu(children: actions)
    }
    
    var tableView = UITableView()
    
    private lazy var locationItem: UIBarButtonItem = {
        let labelStack = generateLocationLabelStack()
        let button = wrapWithButton(subview: labelStack)
        
        if #available(iOS 14.0, *) {
            button.menu = regionMenu
            button.showsMenuAsPrimaryAction = true
        }
        
        return UIBarButtonItem(customView: button)
    }()
    
    private lazy var likeItem: UIBarButtonItem = {
        let button = CustomButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setBackgroundImage(UIImage(systemName: "heart"), for: .normal)
        button.tintColor = .cBlack
        
        NSLayoutConstraint.activate([
            button.widthAnchor.constraint(equalToConstant: 27.33),
            button.heightAnchor.constraint(equalToConstant: 24.33)
        ])
        
        button.addTarget(self, action: #selector(goToLikeListViewController), for: .touchUpInside)
        
        return UIBarButtonItem(customView: button)
    }()
    
    private lazy var filterItem: UIBarButtonItem = {
        let button = CustomButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setBackgroundImage(UIImage(systemName: "slider.horizontal.3"), for: .normal)
        button.tintColor = .cBlack
        
        NSLayoutConstraint.activate([
            button.widthAnchor.constraint(equalToConstant: 27.33),
            button.heightAnchor.constraint(equalToConstant: 24.33)
        ])
        
        button.addTarget(self, action: #selector(popUpFilterModal), for: .touchUpInside)
        
        return UIBarButtonItem(customView: button)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        configureNavigationBar()
        setupTableView()
    }
    
    private func configureNavigationBar() {
        navigationItem.leftBarButtonItem = locationItem
        
        let spacer = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
        spacer.width = 15
        navigationItem.rightBarButtonItems = [filterItem, spacer, likeItem]
    }
    
    private func setupTableView() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(AnimalInfoCell.self, forCellReuseIdentifier: AnimalInfoCell.reuseID)
        tableView.rowHeight = AnimalInfoCell.rowHeight
        
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        tableView.dataSource = self
        
        addTableViewHeader()
    }
    
    private func addTableViewHeader() {
        tableView.sectionHeaderHeight = AnimalListTableViewHeader.height
        let header = AnimalListTableViewHeader(frame: .zero, region: currentRegion)
        
        let size = CGSize(width: view.frame.width, height: AnimalListTableViewHeader.height)
        header.frame.size = size
        
        tableView.tableHeaderView = header
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
        [regionLabel, chevronImageView].forEach { stack.addArrangedSubview($0) }
        
        return stack
    }
    
    private func wrapWithButton(subview: UIView) -> UIButton {
        let button = CustomButton()
        
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
    
    private func changeRegion(to region: Region) {
        currentRegion = region
        regionLabel.text = region.name
        
        // TODO: 지역 변경 시 추가 로직 구현
        (tableView.tableHeaderView as! AnimalListTableViewHeader).currentRegion = region
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

extension AnimalListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: AnimalInfoCell.reuseID, for: indexPath) as! AnimalInfoCell
        
        return cell
    }
}

