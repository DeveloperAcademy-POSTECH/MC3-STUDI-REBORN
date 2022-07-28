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
    private let coreDataManager = CoreDataManager.shared
    
    lazy var likedAnimals = coreDataManager.getAllLikedAnimals()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setNavBar()
        setCollectionView()
        setCollectionViewConstraints()
        
        
//        likedAnimals = Core Data에서 데이터들을 가져옴
    }
    //네비게이션 바
    func setNavBar() {
        navigationItem.title = "관심 목록"
        navigationController?.navigationBar.tintColor = .cBlack
    }
    
    //컬렉션뷰
    func setCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        flowLayout.scrollDirection = .vertical
        let width = (UIScreen.main.bounds.width - 60) / 2
        let height = width * 4 / 3
        flowLayout.itemSize = CGSize(width: width, height: height)
        flowLayout.sectionInset = .init(top: 20, left: 20, bottom: 20, right: 20)
        flowLayout.minimumInteritemSpacing = 20
        flowLayout.minimumLineSpacing = 16
        flowLayout.headerReferenceSize = CGSize(width: 350, height: 105)
        
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

extension LikeListViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return likedAnimals.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LikeCollectionViewCell.identifier, for: indexPath) as! LikeCollectionViewCell
        cell.likedAnimal = likedAnimals[indexPath.row]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "LikeListViewHeader", for: indexPath) as! LikeListViewHeader
        return header
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let vc = AnimalDetailViewController(likedAnimals[indexPath.row])
//        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}


//extension LikeListViewController: UICollectionViewDelegate {
//    func present(_ viewControllerToPresent: UIViewController,
//        animated flag: Bool,
//      completion: (() -> Void)? = nil)
//}

//extension LikeListViewController: UICollectionViewDelegate {
//    func CollectionView(_ collectionView: UICollectionView, didSelectRowAt indexPath: IndexPath) {
//        performSegue(withIdentifier: "AnimalDetailView", sender: nil)
//    }
//}
