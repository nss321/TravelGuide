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


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        travleInfo.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = travleInfo[indexPath.row]
        let cell = UITableViewCell()
        let config = UIImage.SymbolConfiguration.preferringMulticolor()
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        
        switch row.ad {
        case true:
            let cell = tableView.dequeueReusableCell(withIdentifier: "advertiseTableViewCell", for: indexPath) as! AdvertiseTableViewCell
            cell.titleLabel.text = row.title
            cell.containerView.clipsToBounds = true
            cell.containerView.layer.cornerRadius = 12
            return cell
            
        case false:
            let cell = tableView.dequeueReusableCell(withIdentifier: "secondTableViewCell", for: indexPath) as! SecondTableViewCell
            
            // 이전 Cell의 별점 초기화
            cell.gradeImageView.forEach {
                $0.image = UIImage(systemName: "star")?.applyingSymbolConfiguration(config)
            }
            
            cell.titleLabel.text = row.title
            
            if let desc = row.description {
                cell.descLabel.text = desc
            } else {
                cell.descLabel.text = ""
            }
            
            if let imageLink = row.travel_image, let url = URL(string: imageLink) {
                cell.travelImageVIew.kf.setImage(with: url)
            } else {
                cell.travelImageVIew.image = UIImage(systemName: "xmark.circle.fill")?.applyingSymbolConfiguration(config)
            }
            
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
                let numberOfReviews = Int.random(in: 1...2000)
                let convertedReview = numberFormatter.string(for: numberOfReviews)
                let convertedSave = numberFormatter.string(for: save)
//                cell.reviewAndSaveLabel.text = "(\(convertedReview!)) · 저장 \(convertedSave!)"
            } else {
                cell.reviewAndSaveLabel.text = "(0) · 저장 (0)"
                cell.gradeImageView.forEach {
                    $0.image = UIImage(systemName: "star")?.applyingSymbolConfiguration(config)
                }
            }
            
            if let like = row.like {
                let likeButtonImage = like ? UIImage(systemName: "heart.fill") : UIImage(systemName: "heart")
                cell.likeButton.setImage(likeButtonImage, for: .normal)
            } else {
                cell.likeButton.setImage(UIImage(systemName: "heart"), for: .normal)
            }
            cell.likeButton.tag = indexPath.row
            cell.likeButton.tintColor = .red
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
