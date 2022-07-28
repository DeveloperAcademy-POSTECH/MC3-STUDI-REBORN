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
    private let networkManager = NetworkManager.shared
    private let coreDataManager = CoreDataManager.shared
    
    var currentPage = 1
    var currentRegion: Region = .none
    var currentKind: Kind?
    var animalItems = [Item]()
    
    let container: UIView = {
        let container: UIView = UIView()
        container.backgroundColor = .cDarkGray!.withAlphaComponent(0.5)
        return container
    }()
    
    let activityView: UIActivityIndicatorView = {
        let activityView = UIActivityIndicatorView(style: .large)
        activityView.color = .white
        return activityView
    }()
    
    func showActivityIndicator() {
        container.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height)
        activityView.center = view.center
        
        container.addSubview(activityView)
        self.view.addSubview(container)
        
        activityView.startAnimating()
    }
    
    func hideActivityIndicator() {
        activityView.stopAnimating()
        container.removeFromSuperview()
    }
    
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
    var isFetchable = true // tableView의 스크롤이 맨 밑에 닿을 때 데이터를 한번만 fetch하도록 하기 위해 사용
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshTable(refresh:)), for: .valueChanged)
        
        return refreshControl
    }()
    
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
    
    private lazy var resultMessageView: UIView = {
        let containerView = UIView()
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 10
        
        let resultImageView = UIImageView.ofSystemImage(systemName: "x.circle", fontSize: 60, color: .cRed)
        
        [resultImageView, resultMessageLabel].forEach { stackView.addArrangedSubview($0) }
        
        containerView.translatesAutoresizingMaskIntoConstraints = false
        stackView.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor)
        ])
        
        view.addSubview(containerView)
        NSLayoutConstraint.activate([
            containerView.leadingAnchor.constraint(equalTo: tableView.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: tableView.trailingAnchor),
            containerView.topAnchor.constraint(equalTo: tableView.topAnchor),
            containerView.bottomAnchor.constraint(equalTo: tableView.bottomAnchor)
        ])
        return containerView
    }()
    
    private let resultMessageLabel = BaseLabel(size: 14, textColor: .cBlack, weight: .regular)
    
    private func showResultMessageView(message: String) {
        resultMessageLabel.text = message
        resultMessageView.isHidden = false
    }
    
    private func hideResultMessageView() {
        resultMessageView.isHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        configureNavigationBar()
        setupTableView()
        initializeData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
        let appearnace = UINavigationBarAppearance()
        appearnace.configureWithOpaqueBackground()
        appearnace.backgroundColor = .white
        
        navigationController?.navigationBar.tintColor = .black
        navigationController?.navigationBar.standardAppearance = appearnace
        navigationController?.navigationBar.compactAppearance = appearnace
        navigationController?.navigationBar.scrollEdgeAppearance = appearnace
    }
    
    private func configureNavigationBar() {
        navigationItem.leftBarButtonItem = locationItem
        navigationItem.backButtonTitle = ""
        
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
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.refreshControl = refreshControl
        
        addTableViewHeader()
    }
    
    private func addTableViewHeader() {
        tableView.sectionHeaderHeight = AnimalListTableViewHeader.height
        let header = AnimalListTableViewHeader(frame: .zero, region: currentRegion)
        
        let size = CGSize(width: view.frame.width, height: AnimalListTableViewHeader.height)
        header.frame.size = size
        
        tableView.tableHeaderView = header
    }
    
    private func fetchData() {
        isFetchable = false
        hideResultMessageView()
        
        networkManager.fetchAnimal(pageNumber: currentPage, region: currentRegion, kind: currentKind) { [unowned self] result in
            switch result {
            case .success(let animalDatas):
                if self.currentPage == 1 {
                    self.animalItems = animalDatas
                } else {
                    self.animalItems += animalDatas
                }

            case .failure(let error):
                print(error)
                self.animalItems = []
                DispatchQueue.main.async {
                    self.showResultMessageView(message: "네트워크가 원활하지 않습니다.")
                }
            }
            
            // 데이터 받아온 후 메인 쓰레드에서 테이블 뷰 리로드
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.refreshControl.endRefreshing()
                self.isFetchable = true
                self.hideActivityIndicator()
            }
        }
    }
    
    private func initializeData() {
        showActivityIndicator()
        currentPage = 1
        scrollToTop()
        fetchData()
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
        
        initializeData()
    }
}

// MARK: - likeItem
extension AnimalListViewController {
    @objc private func goToLikeListViewController() {
        let likeListVC = LikeListViewController()
        
        navigationController?.pushViewController(likeListVC, animated: true)
    }
}

// MARK: - filterItem
extension AnimalListViewController: FilterDelegate {
    func applyFilter(kind: Kind?) {
        currentKind = kind
        
        initializeData()
    }
    
    @objc private func popUpFilterModal() {
        let filterVC = FilterViewController()
        filterVC.delegate = self
        
        navigationController?.present(filterVC, animated: true)
    }
}

// MARK: - UITableView
extension AnimalListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return animalItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: AnimalInfoCell.reuseID, for: indexPath) as! AnimalInfoCell
        animalItems[indexPath.row].isLiked = coreDataManager.getLikedAnimal(of: animalItems[indexPath.row]) != nil
        
        cell.animalItem = animalItems[indexPath.row]
        return cell
    }
}

extension AnimalListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        animalItems[indexPath.row].isLiked = coreDataManager.getLikedAnimal(of: animalItems[indexPath.row]) != nil
        let detailVC = AnimalDetailViewController(item: animalItems[indexPath.row])
        
        navigationController?.pushViewController(detailVC, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard isFetchable else { return }
        
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        
        if offsetY > contentHeight - scrollView.frame.height {
            currentPage += 1
            fetchData()
        }
    }
}

extension AnimalListViewController {
    @objc func refreshTable(refresh: UIRefreshControl) {
        currentPage = 1
        fetchData()
    }
    
    private func scrollToTop() {
        self.tableView.setContentOffset(CGPoint(x: 0, y: -90), animated: true)
    }
}
