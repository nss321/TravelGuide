//
//  ThirdTableViewCell.swift
//  TravelGuide
//
//  Created by BAE on 1/4/25.
//

import UIKit

class ThirdTableViewCell: UITableViewCell {
    
    @IBOutlet var containerView: UIView!
    @IBOutlet var checkmark: UIImageView!
    @IBOutlet var itemLabel: UILabel!
    @IBOutlet var starButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        containerView.clipsToBounds = true
        containerView.layer.cornerRadius = 12
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
