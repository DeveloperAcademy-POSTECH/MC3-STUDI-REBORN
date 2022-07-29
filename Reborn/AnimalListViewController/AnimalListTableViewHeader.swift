//
//  BenefitHeader.swift
//  Reborn
//
//  Created by 김남건 on 2022/07/20.
//

import UIKit

final class AnimalListTableViewHeader: UIView {
    static let id = "BenefitHeader"
    static let height: CGFloat = 125
    
    var currentRegion: Region {
        didSet {
            linkLabel.text = "🎉 \(currentRegion.name)의 입양 혜택을 확인해보세요"
        }
    }
    
    private lazy var linkLabel: UILabel = {
        let linkLabel = BaseLabel(size: 16, weight: .semibold)
        linkLabel.text = "🎉 전국의 입양 혜택을 확인해보세요"
        
        return linkLabel
    }()
    
    private var linkUrlString: String {
        switch currentRegion {
        case .none:
            return "https://www.google.co.kr/search?q=%EC%A0%84%EA%B5%AD+%EC%9C%A0%EA%B8%B0%EB%8F%99%EB%AC%BC+%EC%9E%85%EC%96%91+%ED%98%9C%ED%83%9D&client=safari&channel=ipad_bm&source=hp&ei=9oPjYueYF4aq4t4Ps-eYkAE&iflsig=AJiK0e8AAAAAYuOSBjTlUM6mCc--Miwu5NU3G3Cfsch_&ved=0ahUKEwjn69jiwZ35AhUGldgFHbMzBhIQ4dUDCAw&uact=5&oq=%EC%A0%84%EA%B5%AD+%EC%9C%A0%EA%B8%B0%EB%8F%99%EB%AC%BC+%EC%9E%85%EC%96%91+%ED%98%9C%ED%83%9D&gs_lcp=Cgdnd3Mtd2l6EAMyBQghEKABOgsIABCABBCxAxCDAToLCC4QgAQQxwEQ0QM6BAgAEAM6CwguEIAEELEDEIMBOhEILhCABBCxAxCDARDHARDRAzoICAAQgAQQsQM6DQguEIAEELEDEIMBEAo6BwgAEIAEEAo6CQgAEIAEEAoQKjoFCAAQgAQ6BQguEIAEOg0ILhCABBDHARDRAxAKOg0IABCABBCxAxBGEIACOggILhCABBDUAjoICC4QgAQQsQM6BAguEAM6CwguEIAEELEDENQCOgQIABAeOgYIABAeEA9QAFj5H2D2IGgGcAB4BIAB6AGIAd0nkgEGMC4yNi42mAEAoAEBsAEA&sclient=gws-wiz"
        case .seoul:
            return "https://animal.seoul.go.kr/support2"
        case .busan:
            return "http://bsanimal.co.kr/etc/adopt.asp"
        case .daegu:
            return "https://info.daegu.go.kr/newshome/mtnmain.php?mtnkey=articleview&mkey=scatelist&mkey2=2&aid=254342"
        case .incheon:
            return "https://www.incheon.go.kr/IC010205/view?repSeq=DOM_0000000004819100&curPage=2&beginDt=2022-05-22&srchRepTitle=&srchRepContents=도시&endDt=2022-05-28&srchMainManagerDeptNm="
        case .gwangju:
            return "http://www.kcanimal.or.kr/board_notice01/board_content.asp?board_idx=86&tname=board_notice01&page1=1"
        case .daejeon:
            return "https://www.daejeon.go.kr/ani/AniNoticeView.do?ntatcSeq=1389823625&menuSeq=3107&pageIndex=1&searchCondition=TITLE&searchKeyword=%EC%9E%85%EC%96%91"
        case .ulsan:
            return "https://www.ulsannamgu.go.kr/namgu/unit/cpnAnimal/index.do"
        case .gyeonggi:
            return "https://www.gg.go.kr/bbs/boardView.do?bIdx=45238988&bsIdx=706&bcIdx=0&menuId=2839&isManager=false&isCharge=false&page=1"
        case .gangwon:
            return "https://www.google.com/search?q=%EA%B0%95%EC%9B%90%EB%8F%84+%EC%9C%A0%EA%B8%B0%EB%8F%99%EB%AC%BC+%EC%9E%85%EC%96%91+%ED%98%9C%ED%83%9D&client=safari&rls=en&sxsrf=ALiCzsZhBus9Slt5aWKrdW3JOCSXDTCxIg%3A1658996858395&ei=ekjiYrXrF6iq3LUPt7az6As&ved=0ahUKEwi1kLbzlJv5AhUoFbcAHTfbDL0Q4dUDCA0&uact=5&oq=%EA%B0%95%EC%9B%90%EB%8F%84+%EC%9C%A0%EA%B8%B0%EB%8F%99%EB%AC%BC+%EC%9E%85%EC%96%91+%ED%98%9C%ED%83%9D&gs_lcp=Cgdnd3Mtd2l6EAM6BwgAEEcQsANKBAhBGABKBAhGGABQxgVYiAtgygtoBHABeAKAAb8CiAHQCpIBBzAuNC4yLjGYAQCgAQHIAQrAAQE&sclient=gws-wiz"
        case .choongbook:
            return "https://www.google.com/search?client=safari&rls=en&q=%EC%B6%A9%EC%B2%AD%EB%B6%81%EB%8F%84+%EC%9C%A0%EA%B8%B0%EB%8F%99%EB%AC%BC+%EC%9E%85%EC%96%91+%ED%98%9C%ED%83%9D&ie=UTF-8&oe=UTF-8"
        case .choongnam:
            return "https://www.google.com/search?q=%EC%B6%A9%EC%B2%AD%EB%82%A8%EB%8F%84+%EC%9C%A0%EA%B8%B0%EB%8F%99%EB%AC%BC+%EC%9E%85%EC%96%91+%ED%98%9C%ED%83%9D&client=safari&rls=en&sxsrf=ALiCzsbihKWDU1VZ6_njQ8ebLmdOhMYtRw%3A1658996733955&ei=_UfiYur8Ofzaz7sPvKqjiAM&ved=0ahUKEwiq74q4lJv5AhV87XMBHTzVCDEQ4dUDCA0&uact=5&oq=%EC%B6%A9%EC%B2%AD%EB%82%A8%EB%8F%84+%EC%9C%A0%EA%B8%B0%EB%8F%99%EB%AC%BC+%EC%9E%85%EC%96%91+%ED%98%9C%ED%83%9D&gs_lcp=Cgdnd3Mtd2l6EANKBAhBGAFKBAhGGABQrQRYwA1g-Q1oA3AAeAGAAYICiAGiBpIBBTAuMi4ymAEAoAEBwAEB&sclient=gws-wiz"
        case .jeonbook:
            return "https://www.google.com/search?q=%EC%A0%84%EB%9D%BC%EB%B6%81%EB%8F%84+%EC%9C%A0%EA%B8%B0%EB%8F%99%EB%AC%BC+%EC%9E%85%EC%96%91+%ED%98%9C%ED%83%9D&client=safari&rls=en&sxsrf=ALiCzsa6pFA7M0R28WKo1TOFFGcZZWqGyw%3A1658996827998&ei=W0jiYv_IPOKzz7sPnIKr4AU&ved=0ahUKEwi_4vbklJv5AhXi2XMBHRzBClwQ4dUDCA0&uact=5&oq=%EC%A0%84%EB%9D%BC%EB%B6%81%EB%8F%84+%EC%9C%A0%EA%B8%B0%EB%8F%99%EB%AC%BC+%EC%9E%85%EC%96%91+%ED%98%9C%ED%83%9D&gs_lcp=Cgdnd3Mtd2l6EAM6BwgAEEcQsANKBAhBGABKBAhGGABQ3ApY-A5gzg9oAnABeAGAAYcCiAGKCJIBBTAuMi4zmAEAoAEByAEKwAEB&sclient=gws-wiz"
        case .jeonnam:
            return "https://www.google.com/search?q=%EC%A0%84%EB%9D%BC%EB%82%A8%EB%8F%84+%EC%9C%A0%EA%B8%B0%EB%8F%99%EB%AC%BC+%EC%9E%85%EC%96%91+%ED%98%9C%ED%83%9D&client=safari&rls=en&sxsrf=ALiCzsZc0Qb9rL6OcOrT5Zg5KIcUoKZypg%3A1658996843994&ei=a0jiYqKkPNKE8QOyu73IDQ&ved=0ahUKEwjihcfslJv5AhVSQnwKHbJdD9kQ4dUDCA0&uact=5&oq=%EC%A0%84%EB%9D%BC%EB%82%A8%EB%8F%84+%EC%9C%A0%EA%B8%B0%EB%8F%99%EB%AC%BC+%EC%9E%85%EC%96%91+%ED%98%9C%ED%83%9D&gs_lcp=Cgdnd3Mtd2l6EAM6BwgAEEcQsANKBAhBGABKBAhGGABQ4wVY8A9gqBBoA3ABeACAAe4BiAGOBZIBBTAuMy4xmAEAoAEByAECwAEB&sclient=gws-wiz"
        case .gyeongbook:
            return "https://www.google.com/search?q=%EA%B2%BD%EC%83%81%EB%B6%81%EB%8F%84+%EC%9C%A0%EA%B8%B0%EB%8F%99%EB%AC%BC+%EC%9E%85%EC%96%91+%ED%98%9C%ED%83%9D&client=safari&rls=en&sxsrf=ALiCzsZfAEGKysC5YWpWm2ZJqvzZx2aoeg%3A1658996822849&ei=VkjiYsDCM82T3LUP8rW7wA0&ved=0ahUKEwjAxbzilJv5AhXNCbcAHfLaDtgQ4dUDCA0&uact=5&oq=%EA%B2%BD%EC%83%81%EB%B6%81%EB%8F%84+%EC%9C%A0%EA%B8%B0%EB%8F%99%EB%AC%BC+%EC%9E%85%EC%96%91+%ED%98%9C%ED%83%9D&gs_lcp=Cgdnd3Mtd2l6EAMyBwgAEEcQsAMyBwgAEEcQsAMyBwgAEEcQsAMyBwgAEEcQsAMyBwgAEEcQsAMyBwgAEEcQsAMyBwgAEEcQsANKBAhBGABKBAhGGABQ_AFY3QVgowZoAXABeACAAQCIAQCSAQCYAQCgAQHIAQfAAQE&sclient=gws-wiz"
        case .gyeongnam:
            return "https://www.google.com/search?q=%EA%B2%BD%EC%83%81%EB%82%A8%EB%8F%84+%EC%9C%A0%EA%B8%B0%EB%8F%99%EB%AC%BC+%EC%9E%85%EC%96%91+%ED%98%9C%ED%83%9D&client=safari&rls=en&sxsrf=ALiCzsYcaGZYEvpJZSYtrFg5_TGGn-HErw%3A1658996773538&ei=JUjiYsewIIOqz7sPvuu7kA4&ved=0ahUKEwiH1_rKlJv5AhUD1XMBHb71DuIQ4dUDCA0&uact=5&oq=%EA%B2%BD%EC%83%81%EB%82%A8%EB%8F%84+%EC%9C%A0%EA%B8%B0%EB%8F%99%EB%AC%BC+%EC%9E%85%EC%96%91+%ED%98%9C%ED%83%9D&gs_lcp=Cgdnd3Mtd2l6EANKBAhBGAFKBAhGGABQuwVYugtg8wtoA3AAeAGAAfcBiAHhCpIBBTEuMy40mAEAoAEBwAEB&sclient=gws-wiz"
        case .jeju:
            return "https://www.jeju.go.kr/animal/news/notice.htm?act=view&seq=1345248"
        }
    }
    
    init(frame: CGRect, region: Region) {
        currentRegion = region
        super.init(frame: frame)
        linkLabel.text = "🎉 \(currentRegion.name)의 입양 혜택을 확인해보세요"
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.alignment = .leading
        
        let topLabel = generateTopLabel()
        stackView.addArrangedSubview(topLabel)
        
        
        let linkView = generateLinkView()
        stackView.addArrangedSubview(linkView)
        
        NSLayoutConstraint.activate([
            linkView.leadingAnchor.constraint(equalTo: stackView.leadingAnchor),
            linkView.trailingAnchor.constraint(equalTo: stackView.trailingAnchor),
            linkView.heightAnchor.constraint(equalToConstant: 66)
        ])
        
        addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - 40),
            stackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    func generateTopLabel() -> UILabel {
        let topLabel = BaseLabel(size: 22, weight: .semibold)
        topLabel.textColor = .cBlack
        topLabel.text = "입양을 기다리는 아이들"
        
        return topLabel
    }
    
    func generateLinkView() -> UIView {
        let linkContentStack = UIStackView()
        linkContentStack.translatesAutoresizingMaskIntoConstraints = false
        linkContentStack.axis = .horizontal
        linkContentStack.spacing = 6
        
        linkContentStack.addArrangedSubview(linkLabel)
        
        let chevronImageView = UIImageView.ofSystemImage(systemName: "chevron.right", fontSize: 16)
        linkContentStack.addArrangedSubview(chevronImageView)
        
        let linkView = UIView()
        linkView.translatesAutoresizingMaskIntoConstraints = false
        linkView.backgroundColor = .cBeige
        linkView.layer.cornerRadius = 14
        linkView.clipsToBounds = true
        
        linkView.addSubview(linkContentStack)
        NSLayoutConstraint.activate([
            linkContentStack.centerXAnchor.constraint(equalTo: linkView.centerXAnchor),
            linkContentStack.centerYAnchor.constraint(equalTo: linkView.centerYAnchor)
        ])
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(openLink))
        linkView.addGestureRecognizer(gesture)
        
        return linkView
    }
    
    @objc func openLink() {
        guard let url = URL(string: linkUrlString), UIApplication.shared.canOpenURL(url) else { return }
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
        // 출처: https://zeddios.tistory.com/375 [ZeddiOS:티스토리]
    }
}
