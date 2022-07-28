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
        navBarAppearance.configureWithTransparentBackground()
        return navBarAppearance
    }()
    
    private let animalDetailView = AnimalDetailView()
    
    private var defaultScrollYOffset: CGFloat = 0
    
    var item: Item
    
    init(item: Item? = nil) {
        self.item = item ?? Item(id: nil, detailImage: nil, noticeNumber: nil, noticeStartDate: nil, noticeEndDate: nil, kind: nil, color: nil, birth: nil, sexCd: nil, neutralizationStatus: nil, weight: nil, description: nil, discoverdPlace: nil, shelterName: nil, shelterAddress: nil, telNumber: nil)
        super.init(nibName: nil, bundle: nil)
    }
    
    // MARK: - Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpNavigationBar()
        setScrollView()
        setTabbar()
        setUpTapGesture()
        setAnimalInformation()
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
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Set Information

extension AnimalDetailViewController {
    private func setAnimalInformation() {
        guard let imageURLstring = item.detailImage else { return }
        let imageURL = URL(string: imageURLstring)
        
        self.animalDetailView.animalInfoView.noticeInfoView.noticeName.text = self.item.noticeNumber
        self.animalDetailView.animalInfoView.noticeInfoView.noticeDateNumber.text = self.item.noticeStartDate! + " - " + self.item.noticeEndDate!
        
        self.animalDetailView.animalInfoView.descriptionInfoView.kindInfoLabel.text = self.item.kind!
        self.animalDetailView.animalInfoView.descriptionInfoView.colorInfoLabel.text = self.item.color!
        self.animalDetailView.animalInfoView.descriptionInfoView.sexInfoLabel.text = self.item.sex!
        self.animalDetailView.animalInfoView.descriptionInfoView.neuteringInfoLabel.text = self.item.neutralizationStatus!
        self.animalDetailView.animalInfoView.descriptionInfoView.ageInfoLabel.text = String(self.item.age ?? -1)
        self.animalDetailView.animalInfoView.descriptionInfoView.weightInfoLabel.text = self.item.weight!
        self.animalDetailView.animalInfoView.descriptionInfoView.charactersInfoLabel.text = self.item.description!
        self.animalDetailView.animalInfoView.descriptionInfoView.locationInfoLabel.text = self.item.discoverdPlace!
        
        self.animalDetailView.animalInfoView.shelterInfoView.nameInfoLabel.text = self.item.shelterName!
        self.animalDetailView.animalInfoView.shelterInfoView.addressInfoLabel.text = self.item.shelterAddress!
        self.animalDetailView.animalInfoView.shelterInfoView.contactInfoLabel.text = self.item.telNumber!
        
        // 이미지를 다운 받는 시간동안 멈춤 현상을 방지하기 위해
        DispatchQueue.global().async {
            let data = try? Data(contentsOf: imageURL!)
            DispatchQueue.main.async {
                self.animalDetailView.animalImageView.image = UIImage(data: data!)
            }
        }
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
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
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
        
        alert.addAction(UIAlertAction(title: "전화 하기", style: .default, handler:{ _ in
            guard let url = NSURL(string: "tel://" + "\(self.item.telNumber ?? "")"),
                   UIApplication.shared.canOpenURL(url as URL) else { return }
            UIApplication.shared.open(url as URL, options: [:], completionHandler: nil)
            print("전화 하기 탭")
        }))
        
        alert.addAction(UIAlertAction(title: "주소 복사", style: .default, handler:{ _ in
            UIPasteboard.general.string = self.item.shelterAddress ?? ""
            print("주소 복사 탭")
        }))
        
        alert.addAction(UIAlertAction(title: "취소", style: .cancel, handler:{ _ in
            if let storedString = UIPasteboard.general.string {
                print(storedString)
            }
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

// MARK: - Animal Image View Tap

extension AnimalDetailViewController {
    private func setUpTapGesture() {
        self.animalDetailView.animalImageView.isUserInteractionEnabled = true
        self.animalDetailView.animalImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(animalImageViewDidTap)))
    }
    
    @objc func animalImageViewDidTap() {
        let vc = DetailImageViewController()
        vc.detailImageView.animalImageView.image = animalDetailView.animalImageView.image
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
    }
}
