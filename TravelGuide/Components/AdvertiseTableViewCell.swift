//
//  AdvertiseTableViewCell.swift
//  TravelGuide
//
//  Created by BAE on 1/5/25.
//

import UIKit

class AdvertiseTableViewCell: UITableViewCell {

    @IBOutlet var containerView: UIView!
    @IBOutlet var titleLabel: UILabel!
    
    
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
