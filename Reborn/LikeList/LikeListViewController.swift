//
//  LikeListViewController.swift
//  Reborn
//
//  Created by Hyemin Choi on 2022/07/19.
//

import UIKit

final class LikeListViewController: UIViewController {

    private lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
    
    private let flowLayout = UICollectionViewFlowLayout()

    //공고종료 배너
//    private let label: UILabel = {
//        let label = UILabel()
//        label.frame = CGRect(x: 20, y: 108, width: 350, height: 66)
//        label.textColor = .cBlack
//        label.backgroundColor = .cBeige
//        label.text = "🐶  공고 종료된 아이들은 \n자동으로 목록에서 사라져요"
//        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
//        label.textAlignment = .center
//        label.clipsToBounds = true
//        label.layer.cornerRadius = 14
//        label.numberOfLines = 0
//        return label
//    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setNavBar()
//        setBanner()
        setCollectionView()
        setCollectionViewConstraints()
    }
    //네비게이션 바
    func setNavBar() {
        navigationItem.title = "관심 목록"
        navigationController?.navigationBar.tintColor = .cBlack
    }
    //배너
//    func setBanner() {
//        view.addSubview(label)
//    }
    
    //컬렉션뷰
    func setCollectionView() {
        collectionView.dataSource = self
        flowLayout.scrollDirection = .vertical
        flowLayout.itemSize = CGSize(width: 165, height: 210)
        flowLayout.sectionInset = .init(top: 20, left: 20, bottom: 20, right: 20)
        flowLayout.minimumInteritemSpacing = 20
        flowLayout.minimumLineSpacing = 16
        flowLayout.headerReferenceSize = CGSize(width: 350, height: 66)
        
        collectionView.register(LikeCollectionViewCell.self, forCellWithReuseIdentifier: LikeCollectionViewCell.identifier)
        collectionView.register(LikeListViewHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "LikeListViewHeader")
    }
    
    //컬렉션뷰 오토레이아웃
    func setCollectionViewConstraints(){
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

extension LikeListViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LikeCollectionViewCell.identifier, for: indexPath) as! LikeCollectionViewCell
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "LikeListViewHeader", for: indexPath) as! LikeListViewHeader
        return header
    }
}

