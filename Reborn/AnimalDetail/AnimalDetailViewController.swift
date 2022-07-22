//
//  AnimalDetailViewController.swift
//  Reborn
//
//  Created by peo on 2022/07/18.
//

import UIKit

final class AnimalDetailViewController: UIViewController {
    
    // MARK: - Properties
    
    private var navBarAppearance: UINavigationBarAppearance = {
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.configureWithOpaqueBackground()
        navBarAppearance.backgroundColor = .clear
        navBarAppearance.shadowColor = .clear
        return navBarAppearance
    }()
    
    private let animalDetailView = AnimalDetailView()
    
    private var defaultScrollYOffset: CGFloat = 0

    // MARK: - Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpNavigationBar()
        setScrollView()
        setTabbar()
        setUpTapGesture()
    }
    
    override func loadView() {
        super.loadView()
        self.view = animalDetailView
    }
    
    private func setUpNavigationBar() {
        self.navigationController?.navigationBar.tintColor = .white
        
        setNavBarAppearance()
    }
    
    private func setNavBarAppearance() {
        self.navigationController?.navigationBar.standardAppearance = navBarAppearance
        self.navigationController?.navigationBar.compactAppearance = navBarAppearance
        self.navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
    }
}

// MARK: - Scroll Delegate

extension AnimalDetailViewController: UIScrollViewDelegate {
    
    private func setScrollView() {
        animalDetailView.scrollView.delegate = self
        
        // 아래 구문을 실행하면 이미지가 상단 상태바까지 적용이 됨
        animalDetailView.scrollView.contentInsetAdjustmentBehavior = .scrollableAxes
        
        // 상세 화면에 들어가게 되면, ScrollView의 Scroll Y축 Offset값이 iPhone13기준 -91의 값을 가지고 있으며
        // Navigation Bar의 색상 변경 기능을 위해 해당 값을 저장함
        defaultScrollYOffset = self.animalDetailView.scrollView.contentOffset.y
    }
    
    // TODO: - 이미지 비율 자연스럽게 변경 추후 구현
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        // 일정 거리만큼 스크롤 시, 이미지의 비율을 변경하여 아래 정보들의 배치가 안 무너지게 설정
        if scrollView.contentOffset.y > defaultScrollYOffset - 44 {
//            detailView.animalImageView.contentMode = .scaleToFill
        } else {
//            detailView.animalImageView.contentMode = .scaleAspectFill
        }
        
        // 밑으로 내릴수록 Navigation Bar의 아이템 색상을 검게, 배경색을 하얗게 변경
        if scrollView.contentOffset.y > defaultScrollYOffset {
            let position = scrollView.contentOffset.y + defaultScrollYOffset
            self.navigationController?.navigationBar.tintColor = .init(red: (1 - position / 185), green: (1 - position / 185), blue: (1 - position / 185), alpha: 1)
            
            navBarAppearance.backgroundColor = .init(white: position / 185, alpha: position / 185)
            navBarAppearance.shadowColor = .init(red: 0, green: 0, blue: 0, alpha: ((position / 185) * 0.3))
        } else {
            // 위로 올릴수록 Navigation Bar의 아이템 색상을 하얗게, 배경색을 투명하게 변경
            self.navigationController?.navigationBar.tintColor = .white
            
            navBarAppearance.backgroundColor = .clear
            navBarAppearance.shadowColor = .clear
        }
        
        setNavBarAppearance()
    }
}

// MARK: - Tabbar Delegate

extension AnimalDetailViewController: AnimalDetailTabbarDelegate {
    
    private func setTabbar() {
        animalDetailView.tabbar.delegate = self
    }
    
    // TODO: - 전화 걸기 기능 추후 구현
    
    func contactButtonDidTap() {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: "전화 " + "010 1234 1234", style: .default , handler:{ _ in
            print("전화 걸기")
        }))
        
        alert.addAction(UIAlertAction(title: "취소", style: .cancel, handler:{ _ in
            print("취소 버튼 탭")
        }))
        
        self.present(alert, animated: true, completion: {
            print("액션 시트 올라옴")
        })
    }
    
    // TODO: - 관심 목록 추가 기능 추후 구현
    
    func likeButtonDidTap() {
        
    }
}

extension AnimalDetailViewController {
    private func setUpTapGesture() {
        self.animalDetailView.animalImageView.isUserInteractionEnabled = true
        self.animalDetailView.animalImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(animalImageViewDidTap)))
    }
    
    // MARK: - Animal Image View Tap
    
    @objc func animalImageViewDidTap() {
        let vc = DetailImageViewController()
//        vc.detailImageView.animalImageView.image = animalDetailView.animalImageView.image
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
    }
}
