//
//  ThirdTableViewCell.swift
//  TravelGuide
//
//  Created by BAE on 1/4/25.
//

import UIKit

final class ThirdTableViewCell: UITableViewCell {
    
    static let identifier = "ThirdTableViewCell"
    
    @IBOutlet private var containerView: UIView!
    @IBOutlet var checkmark: UIImageView!
    @IBOutlet private var itemLabel: UILabel!
    @IBOutlet var starButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        containerView.clipsToBounds = true
        containerView.layer.cornerRadius = 12
    }

    func config(row: ShoppingItem) {
        itemLabel.attributedText = NSAttributedString(
            string: row.item,
            attributes:
                row.isChecked ? [.strikethroughStyle : NSUnderlineStyle.single.rawValue, .strikethroughColor : UIColor.label] : nil
        )
        
        checkmark.image = row.isChecked ? UIImage.symbolWithTint("checkmark.square.fill", .label) : UIImage.symbolWithTint("checkmark.square", .label)
        
        let starSymbol = row.isStarred ? UIImage.symbolWithTint(star.fill, .label) : UIImage.symbolWithTint(star.zero, .label)
        starButton.setImage(starSymbol, for: .normal)
    }
}
