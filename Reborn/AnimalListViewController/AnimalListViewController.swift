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
    
    // MARK: - 네트워크 매니저
    
    private var networkManager = NetworkManager.shared
    private var regionQuery = Region.none.query
    private var pageNumberQuery = 1
    private var fetchMore = false
    
    // MARK: - 유기동물 데이터 배열
    
    private var animals: [Item] = []
    
    private let locationLabel: BaseLabel = {
        let label = BaseLabel(size: 20, weight: .semibold)
        label.text = "전국"
        
        return label
    }()
    
    var locationMenu: UIMenu {
        let locations = ["전국", "서울특별시", "대전광역시", "부산광역시", "세종특별자치시", "충청북도", "충청남도", "경상북도", "경상남도", "전라북도", "전라남도", "강원도", "경기도", "제주특별자치도"]
        var actions = [UIAction]()
        
        for location in locations {
            actions.append(UIAction(title: location) { _ in
                self.changeLocation(to: location)
                self.makeRegionQuery(location)
                self.setDatas(by: self.regionQuery)
                self.showActivityIndicator()
            })
        }
        
        return UIMenu(children: actions)
    }
    
    var tableView = UITableView()
    
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
    
    // MARK: - UIRefreshControl
    //UIRefreshControl 인스턴스 생성
    let refreshControl = UIRefreshControl()
    
    func initRefresh() {
        //refreshControl의 값이 바뀔 때, refreshTable 함수 동작
        refreshControl.addTarget(self, action: #selector(refreshTable(refresh:)), for: .valueChanged)
        self.tableView.refreshControl = refreshControl
    }
    
    @objc func refreshTable(refresh: UIRefreshControl) {
        print("새로고침 시작")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.tableView.reloadData()
            refresh.endRefreshing() //endRefreshing으로 refreshControl 꺼준다 -> refreshControl이 default값으로 돌아감
        }
    }
    
    // MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        configureNavigationBar()
        setupTableView()
        
        setDatas()
        //당겨서 새로 고침
        initRefresh()
        
        //로딩화면
        showActivityIndicator()
    }
    
    // MARK: - Activity Indicator
    
    let container: UIView = {
        let container: UIView = UIView()
        container.backgroundColor = UIColor.black.withAlphaComponent(0.2)
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
        // TODO: - 로딩화면 사라지는 트리거 설정 (API Fetch 완료했을 때)
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) { self.hideActivityIndicator() }
    }
    
    func hideActivityIndicator() {
        activityView.stopAnimating()
        container.removeFromSuperview()
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
        let header = AnimalListTableViewHeader(frame: .zero)
        
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
        [locationLabel, chevronImageView].forEach { stack.addArrangedSubview($0) }
        
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
    
    private func changeLocation(to location: String) {
        locationLabel.text = location
        
        // TODO: 지역 변경 시 추가 로직 구현
    }
    
    // MARK: - fetch 함수들
    
    // 초기 세팅
    private func setDatas() {
        networkManager.fetchAnimal { result in
            switch result {
            case .success(let animalDatas):
                self.animals = animalDatas
                // 데이터 받아온 후 메인 쓰레드에서 테이블 뷰 리로드
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    // 지역에 맞는 데이터
    private func setDatas(by region: String) {
        networkManager.fetchAnimal(regionQuery: region) { result in
            switch result {
            case .success(let animalDatas):
                self.animals = animalDatas
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                    //스크롤 맨 위로 이동
                    self.scrollToTop()
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    // MARK: - 스크롤 맨 위로 이동하는 함수
    
    private func scrollToTop() {
        let topRow = IndexPath(row: 0, section: 0)
        // 첫번째 at - 목표 cell
        // 두번째 at - 목표 cell의 tableView 상에서 위치
        self.tableView.scrollToRow(at: topRow, at: .bottom, animated: true)
    }
    
    // MARK: - 지역 문자열로 regionQuery에 할당
    
    private func makeRegionQuery(_ string: String) {
        if string == "전국" {
            regionQuery = Region.none.query
        } else if string == "서울특별시" {
            regionQuery = Region.seoul.query
        } else if string == "부산광역시" {
            regionQuery = Region.busan.query
        } else if string == "대구광역시" {
            regionQuery = Region.daegu.query
        }  else if string == "인천광역시" {
            regionQuery = Region.incheon.query
        } else if string == "광주광역시" {
            regionQuery = Region.gwangju.query
        } else if string == "대전광역시" {
            regionQuery = Region.daejeon.query
        } else if string == "울산광역시" {
            regionQuery = Region.ulsan.query
        } else if string == "경기도" {
            regionQuery = Region.gyeonggi.query
        } else if string == "강원도" {
            regionQuery = Region.gangwon.query
        } else if string == "충청북도" {
            regionQuery = Region.choongbook.query
        } else if string == "충청남도" {
            regionQuery = Region.choongnam.query
        } else if string == "전라북도" {
            regionQuery = Region.jeonbook.query
        } else if string == "전라남도" {
            regionQuery = Region.jeonnam.query
        } else if string == "경상북도" {
            regionQuery = Region.gyeongbook.query
        } else if string == "경상남도" {
            regionQuery = Region.gyeongnam.query
        } else if string == "제주특별자치도" {
            regionQuery = Region.jeju.query
        }
    }
}

// MARK: - likeItem
extension AnimalListViewController {
    @objc private func goToLikeListViewController() {
        navigationController?.pushViewController(LikeListViewController(), animated: true)
    }
}

// MARK: - filterItem
extension AnimalListViewController {
    @objc private func popUpFilterModal() {
        navigationController?.present(FilterViewController(), animated: true)
    }
}

extension AnimalListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return animals.count
    }
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//            let detailVC = AnimalDetailViewController(item: animalItems[indexPath.row])
//
//            navigationController?.pushViewController(detailVC, animated: true)
//            tableView.deselectRow(at: indexPath, animated: true)
//        }
//
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: AnimalInfoCell.reuseID, for: indexPath) as! AnimalInfoCell
            
        //cell에 데이터 전달
        cell.imageUrl = animals[indexPath.row].detailImage
        cell.animal = animals[indexPath.row]
        
        // TODO: - 관심 동물임을 알 수 있는 지표
//        let currentAnimal = animals[indexPath.row]
//        if currentAnimal.isLiked {
//            cell.isLiked = true
//        }
        
        cell.selectionStyle = .none
        
        return cell
    }
}
