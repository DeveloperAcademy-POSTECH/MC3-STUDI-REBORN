//
//  AnimalListViewController.swift
//  Reborn
//
//  Created by Park Kangwook on 2022/07/18.
//

import UIKit

// MARK: - AnimalListViewController
class AnimalListViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white

    }
}

// MARK: - UITableViewDataSource 프로토콜
extension AnimalListViewController: UITableViewDataSource {
    
    // MARK: - cell 개수
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    // MARK: - cell 데이터
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: AnimalInfoCell.identifier, for: indexPath) as? AnimalInfoCell else { return UITableViewCell() }

        return cell
    }
    
    // MARK: - cell 높이
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
