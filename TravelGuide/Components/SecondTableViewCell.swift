//
//  SecondTableViewCell.swift
//  TravelGuide
//
//  Created by BAE on 1/4/25.
//

import UIKit

final class SecondTableViewCell: UITableViewCell {

    static let identifier = "SecondTableViewCell"
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var descLabel: UILabel!
    @IBOutlet var gradeImageView: [UIImageView]!
    @IBOutlet var reviewAndSaveLabel: UILabel!
    @IBOutlet var travelImageVIew: UIImageView!
    @IBOutlet var likeButton: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        print(#function)
        likeButton.tintColor = .systemRed
        likeButton.setImage(UIImage(systemName: "heart"), for: .normal)
        travelImageVIew.contentMode = .scaleAspectFit
        likeButton.isHidden = false
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        print(#function)
        gradeImageView.forEach {
            $0.image = UIImage.symbolWithTint(star.zero, .systemYellow)
        }
    }

    func config(row: Travel) {
        print(#function)
        if let imageLink = row.travel_image, let url = URL(string: imageLink) {
            likeButton.isHidden = false
            travelImageVIew.contentMode = .scaleAspectFill
            travelImageVIew.kf.setImage(with: url)
        } else {
            likeButton.isHidden = true
            travelImageVIew.contentMode = .scaleAspectFit
            travelImageVIew.image = UIImage.symbolWithTint("xmark.circle.fill", .systemRed)
        }
        
        if let save = row.save {
            let convertedReview = addCommaToNumber(number: Int.random(in: 1...2000))
            let convertedSave = addCommaToNumber(number: save)
            reviewAndSaveLabel.text = "(\(convertedReview)) · 저장 \(convertedSave)"
        } else {
            reviewAndSaveLabel.text = "(0) · 저장 (0)"
            gradeImageView.forEach {
                $0.image = UIImage.symbolWithTint(star.zero, .systemYellow)
            }
        }
        
        if let like = row.like {
            let likeButtonImage = like ? UIImage(systemName: "heart.fill") : UIImage(systemName: "heart")
            likeButton.setImage(likeButtonImage, for: .normal)
        }
        titleLabel.text = row.title
        descLabel.text = row.description ?? ""
        configureStars(grade: row.grade ?? 0)
    }

    private func configureStars(grade: Double?) {
        let config = UIImage.SymbolConfiguration.preferringMulticolor()
        guard let grade = grade else {
            gradeImageView.forEach {
                $0.image = UIImage.symbolWithTint(star.zero, .systemYellow)
            }
            return
        }
        
        let roundedGrade = Int(grade.rounded())
        
        if Int(grade + 1) == roundedGrade {
            for i in 0...(roundedGrade - 2) {
                gradeImageView[i].image = UIImage.symbolWithTint(star.fill, .systemYellow)
            }
            gradeImageView[roundedGrade - 1].image = UIImage.symbolWithTint(star.half, .systemYellow)
        } else {
            for i in 0...(roundedGrade - 1) {
                gradeImageView[i].image = UIImage.symbolWithTint(star.fill, .systemYellow)
            }
        }
    }
    
    private func addCommaToNumber(number: Int) -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        if let outputString = numberFormatter.string(for: number) {
            return outputString
        } else {
            return ""
        }
    }
}
