//
//  AdvertiseTableViewCell.swift
//  TravelGuide
//
//  Created by BAE on 1/5/25.
//

import UIKit

final class AdvertiseTableViewCell: UITableViewCell {

    static let identifier = "AdvertiseTableViewCell"
    
    @IBOutlet var containerView: UIView!
    @IBOutlet var titleLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        containerView.clipsToBounds = true
        containerView.layer.cornerRadius = 12
    }

    func config(row: Travel) {
        titleLabel.text = row.title
    }
}
