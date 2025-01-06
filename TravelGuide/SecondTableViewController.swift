//
//  SecondTableViewController.swift
//  TravelGuide
//
//  Created by BAE on 1/4/25.
//

import UIKit
import Kingfisher

class SecondTableViewController: UITableViewController {

    var travleInfo = TravelInfo().travel {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(self)
    }
    
    @objc func likeButtonTapped(_ sender: UIButton) {
//        print(sender.tag)
        travleInfo[sender.tag].like?.toggle()
    }
    
    func configureStars(for cell: SecondTableViewCell, grade: Double?, config: UIImage.SymbolConfiguration) {
        guard let grade = grade else {
            cell.gradeImageView.forEach {
                $0.image = UIImage(systemName: "star")?.applyingSymbolConfiguration(config)
            }
            return
        }
        
        let roundedGrade = Int(grade.rounded())
        
        if Int(grade + 1) == roundedGrade {
            for i in 0...(roundedGrade - 2) {
                cell.gradeImageView[i].image = UIImage(systemName: "star.fill")?.applyingSymbolConfiguration(config)
            }
            cell.gradeImageView[roundedGrade - 1].image = UIImage(systemName: "star.leadinghalf.filled")?.withTintColor(.systemYellow, renderingMode: .alwaysOriginal)
        } else {
            for i in 0...(roundedGrade - 1) {
                cell.gradeImageView[i].image = UIImage(systemName: "star.fill")?.applyingSymbolConfiguration(config)
            }
        }
    }
    
    func addCommaToNumber(number: Int) -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        if let outputString = numberFormatter.string(for: number) {
            return outputString
        } else {
            return ""
        }
    }


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        travleInfo.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = travleInfo[indexPath.row]
        let config = UIImage.SymbolConfiguration.preferringMulticolor()
        // addCommaToNumber 함수로 분리
//        let numberFormatter = NumberFormatter()
//        numberFormatter.numberStyle = .decimal
        
        switch row.ad {
        case true:
            let cell = tableView.dequeueReusableCell(withIdentifier: "advertiseTableViewCell", for: indexPath) as! AdvertiseTableViewCell
            cell.titleLabel.text = row.title
            return cell
            
        case false:
            let cell = tableView.dequeueReusableCell(withIdentifier: "secondTableViewCell", for: indexPath) as! SecondTableViewCell
            
            // 이전 Cell의 별점 초기화
            // MARK: 원래 row.grade 옵셔널 바인딩 후 nil 처리 부분에 작성했던 코드인데, 이렇게 구현하니 스크롤 후 테이블 뷰 리로드 시 별점 이미지가 이상하게 바뀌어서,, 앞부분으로 옮겨보니 해결됐습니다. 테이블 뷰 셀 재사용에 대한 이해가 부족한 것 같은데, 어떤 자료를 보면 도움이 될까요?
            cell.gradeImageView.forEach {
                $0.image = UIImage(systemName: "star")?.applyingSymbolConfiguration(config)
            }
            
            cell.titleLabel.text = row.title
            
            if let desc = row.description {
                cell.descLabel.text = desc
            } else {
                cell.descLabel.text = ""
            }
            
            // MARK: cell의 awakeFromNib에서 이미지 링크가 nil인 경우를 기본으로 설정해두고, 이부분에서는 nil이 아닐때만 이미지를 불러오도록 하는게 더 나은 코드일까요??
            if let imageLink = row.travel_image, let url = URL(string: imageLink) {
                // 아래 코드를 awakeFromNib으로
                cell.likeButton.isHidden = false
                cell.travelImageVIew.contentMode = .scaleAspectFill
                cell.travelImageVIew.kf.setImage(with: url)
            } else {
                cell.likeButton.isHidden = true
                cell.travelImageVIew.contentMode = .scaleAspectFit
                cell.travelImageVIew.image = UIImage(systemName: "xmark.circle.fill")?.applyingSymbolConfiguration(config)
            }
            
            // configureStars 함수로 분리
//            if let grade = row.grade {
//                if Int(grade + 1) == Int(grade.rounded()) {
//                    for i in 0...Int(grade.rounded())-2 {
//                        cell.gradeImageView[i].image = UIImage(systemName: "star.fill")?.applyingSymbolConfiguration(config)
//                    }
//                    cell.gradeImageView[Int(grade.rounded())-1].image = UIImage(systemName: "star.leadinghalf.filled")?.withTintColor(.systemYellow, renderingMode: .alwaysOriginal)
//                } else {
//                    for i in 0...Int(grade.rounded())-1 {
//                        cell.gradeImageView[i].image = UIImage(systemName: "star.fill")?.applyingSymbolConfiguration(config)
//                    }
//                }
//            } else {
//                print("row.grade nil 검출")
//                cell.gradeImageView.forEach {
//                    $0.image = UIImage(systemName: "star")?.applyingSymbolConfiguration(config)
//                }
//            }
            
            configureStars(for: cell, grade: row.grade, config: config)
            
            if let save = row.save {
                // 리뷰 수는 랜덤으로 지정
                let convertedReview = addCommaToNumber(number: Int.random(in: 1...2000))
                let convertedSave = addCommaToNumber(number: save)
                cell.reviewAndSaveLabel.text = "(\(convertedReview)) · 저장 \(convertedSave)"
            } else {
                cell.reviewAndSaveLabel.text = "(0) · 저장 (0)"
                cell.gradeImageView.forEach {
                    $0.image = UIImage(systemName: "star")?.applyingSymbolConfiguration(config)
                }
            }
            
            if let like = row.like {
                let likeButtonImage = like ? UIImage(systemName: "heart.fill") : UIImage(systemName: "heart")
                cell.likeButton.setImage(likeButtonImage, for: .normal)
            }
            cell.likeButton.tag = indexPath.row
            cell.likeButton.addTarget(self, action: #selector(likeButtonTapped), for: .touchUpInside)
            
            return cell
        }
    
        
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        var height: CGFloat
        switch travleInfo[indexPath.row].ad {
        case true:
            height = UIScreen.main.bounds.height * 0.15
            break
        case false:
            height = UIScreen.main.bounds.height / 6
            break
        }
        
        return height
    }

    
}
