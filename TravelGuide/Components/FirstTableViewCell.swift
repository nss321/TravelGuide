//
//  FirstTableViewCell.swift
//  TravelGuide
//
//  Created by BAE on 1/4/25.
//

import UIKit

final class FirstTableViewCell: UITableViewCell {

    static let identifier = "FirstTableViewCell"
    
    @IBOutlet private var photoImageView: UIImageView!
    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var subtitleLabel: UILabel!
    @IBOutlet private var dateLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        
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

    }

    func config(row: Magazine) {
        titleLabel.text = row.title
        subtitleLabel.text = row.subtitle
        dateLabel.text = FirstTableViewController.convertMagazineDate(stringDate: row.date)
        photoImageView.kf.setImage(with: URL(string: row.photo_image))
    }
    
    
}
