//
//  SecondTableViewCell.swift
//  TravelGuide
//
//  Created by BAE on 1/4/25.
//

import UIKit

class SecondTableViewCell: UITableViewCell {

    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var descLabel: UILabel!
    @IBOutlet var gradeImageView: [UIImageView]!
    @IBOutlet var reviewAndSaveLabel: UILabel!
    @IBOutlet var travelImageVIew: UIImageView!
    @IBOutlet var likeButton: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        likeButton.tintColor = .systemRed
        likeButton.setImage(UIImage(systemName: "heart"), for: .normal)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
