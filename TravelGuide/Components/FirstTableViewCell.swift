//
//  FirstTableViewCell.swift
//  TravelGuide
//
//  Created by BAE on 1/4/25.
//

import UIKit

class FirstTableViewCell: UITableViewCell {

    @IBOutlet var photoImageView: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var subtitleLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        print(#function)
        titleLabel.font = .boldSystemFont(ofSize: 24)
        subtitleLabel.font = .systemFont(ofSize: 16)
        subtitleLabel.textColor = .secondaryLabel
        photoImageView.clipsToBounds = true
        photoImageView.layer.cornerRadius = 12
        dateLabel.font = .systemFont(ofSize: 16)
        dateLabel.textColor = .secondaryLabel
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
