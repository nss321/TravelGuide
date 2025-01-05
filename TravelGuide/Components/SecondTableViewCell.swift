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
    
    @IBOutlet var travelImageView: UIImageView!
    
    @IBOutlet var gradeImageView: [UIImageView]!
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
