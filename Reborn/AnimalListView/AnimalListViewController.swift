//
//  AnimalListViewController.swift
//  Reborn
//
//  Created by Park Kangwook on 2022/07/18.
//

import UIKit

// MARK: - AnimalListViewController

final class AnimalListViewController: UIViewController {

    private var tableView: UITableView!
    
    // MARK: - 지역선택 변수
    
    private var locationText: BaseLabel = {
        let label = BaseLabel()
        label.text = "서울특별시"
        
        return label
    }()
    
    private var locationSymbol: UIImageView = {
        let label = UIImageView()
        label.image = UIImage(systemName: "chevron.down")
        label.tintColor = .black
        
        return label
    }()

    private var menuItems: [UIAction] {
        return [
            UIAction(title: "서울특별시", handler: { _ in self.locationText.text = "서울특별시" }),
            UIAction(title: "부산광역시", handler: { _ in self.locationText.text = "부산광역시" })]
    }

    private var locationMenu: UIMenu {
        return UIMenu(children: menuItems)
    }
    
    // MARK: - viewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white

        setupTableView()
        setupNavBarButton()
    }
    
    // MARK: - setupTableView
    
    private func setupTableView() {
        tableView = UITableView(frame: .zero)
        view.addSubview(tableView)
        
        tableView.dataSource = self
        tableView.delegate = self
        
        //tableView의 constraint 설정
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor)
        ])
        
        //AnimalInfoCell 등록
        tableView.register(AnimalInfoCell.self, forCellReuseIdentifier: AnimalInfoCell.identifier)
    }
    
    // MARK: - setupNavBarButton
    
    private func setupNavBarButton() {
        //NavigationBarButtonItem 구성
        navigationItem.leftBarButtonItem = generateButtonItemFromStack()
        navigationItem.rightBarButtonItems = [
            UIBarButtonItem(image: UIImage(systemName: "slider.horizontal.3"), style: .plain, target: self, action: #selector(goToFilter)),
            UIBarButtonItem(image: UIImage(systemName: "heart"), style: .plain, target: self, action: #selector(goToLike))
        ]
        
        //NavigationBarButtonItem 색 변경
        navigationItem.leftBarButtonItem?.tintColor = .black
        navigationItem.rightBarButtonItems?.forEach({ item in
            item.tintColor = .black
        })
    }
    
    // MARK: - 지역선택 함수
    
    private func generateButtonItemFromStack() -> UIBarButtonItem {
        // 1. Stack -> Button
        let button = UIButton()
        let stack = generateLocationStack()
        button.addSubview(stack)
        
        // 1-2. Button, Stack의 AutoLayout 조정 (Button의 영역을 Stack만큼 준다)
        button.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            button.topAnchor.constraint(equalTo: stack.topAnchor),
            button.leadingAnchor.constraint(equalTo: stack.leadingAnchor),
            button.trailingAnchor.constraint(equalTo: stack.trailingAnchor),
            button.bottomAnchor.constraint(equalTo: stack.bottomAnchor)
        ])
        
        // 1-3. Button에 menu 추가
        if #available(iOS 14.0, *) {
            button.menu = locationMenu
            button.showsMenuAsPrimaryAction = true
        }
        
        // 2. Button -> BarButtonItem
        let buttonItem = UIBarButtonItem()
        buttonItem.customView = button
        
        return buttonItem
    }
    
    private func generateLocationStack() -> UIStackView {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.alignment = .center
        stack.spacing = 6
        
        stack.addArrangedSubview(locationText)
        stack.addArrangedSubview(locationSymbol)
        
        return stack
    }

    // MARK: - 관심목록 이동 함수
    
    @objc private func goToLike() {
        if let from = navigationController {
            let destination = LikeDemoViewController()
            from.pushViewController(destination, animated: true)
        }
    }
    
    // MARK: - 필터 모달 구현 함수
    
    @objc private func goToFilter() {
        let destination = FilterDemoViewController()
        present(destination, animated: true, completion: nil)
    }
}

// MARK: - UITableViewDataSource 프로토콜

extension AnimalListViewController: UITableViewDataSource {
    
    //cell 개수
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    //cell 데이터
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: AnimalInfoCell.identifier, for: indexPath) as? AnimalInfoCell else { return UITableViewCell() }
        return cell
    }
    
    //cell 높이
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 172
    }
}

// MARK: - UITableViewDelegate 프로토콜

extension AnimalListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
