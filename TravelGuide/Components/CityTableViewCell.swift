//
//  CityTableViewCell.swift
//  TravelGuide
//
//  Created by BAE on 1/7/25.
//

import UIKit

class CityTableViewCell: UITableViewCell {

    static let identifier = "CityTableViewCell"
    
    @IBOutlet var containerView: UIView!
    @IBOutlet var cityImageView: UIImageView!
    @IBOutlet var cityLabel: UILabel!
    @IBOutlet var citySubLabel: UILabel!
    @IBOutlet var subLabelDimView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupCell()
    }
    
    func setupCell() {
        containerView.backgroundColor = .black
        containerView.layer.cornerRadius = 30
        containerView.layer.shadowOffset = CGSize(width: 5, height: 5)
        containerView.layer.shadowOpacity = 0.7
        containerView.layer.shadowRadius = 5
        containerView.layer.shadowColor = UIColor.gray.cgColor
        containerView.layer.maskedCorners = CACornerMask(arrayLiteral: .layerMinXMinYCorner, .layerMaxXMaxYCorner)
        
        cityImageView.alpha = 0.8
        cityImageView.clipsToBounds = true
        cityImageView.layer.cornerRadius = 30
        cityImageView.layer.maskedCorners = CACornerMask(arrayLiteral: .layerMinXMinYCorner, .layerMaxXMaxYCorner)
        
        subLabelDimView.layer.cornerRadius = 30
        subLabelDimView.layer.maskedCorners = CACornerMask(arrayLiteral: .layerMaxXMaxYCorner)
        
    }
    
    func config(row: City) {
        cityLabel.text = "\(row.city_name)|\(row.city_english_name)"
        citySubLabel.text = row.city_explain
        cityImageView.kf.setImage(with: URL(string: row.city_image))
    }
    
}
