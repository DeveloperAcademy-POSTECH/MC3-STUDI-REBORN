//
//  AnimalListViewController.swift
//  Reborn
//
//  Created by Park Kangwook on 2022/07/18.
//

import UIKit
// TODO: private 체크

// MARK: - AnimalListViewController
final class AnimalListViewController: UIViewController {

    private var tableView: UITableView!

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
    
    //관심목록 이동 함수
    @objc private func goToLike() {
        if let from = navigationController {
            let destination = LikeDemoViewController()
            from.pushViewController(destination, animated: true)
        }
    }
    
    //필터 모달 구현 함수
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
