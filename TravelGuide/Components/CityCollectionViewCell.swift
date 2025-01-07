//
//  CityCollectionViewCell.swift
//  TravelGuide
//
//  Created by BAE on 1/7/25.
//

import UIKit

class CityCollectionViewCell: UICollectionViewCell {

    static let identifier = "CityCollectionViewCell"
    @IBOutlet var cityCircleView: UIImageView!
    @IBOutlet var cityLabel: UILabel!
    @IBOutlet var subLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        cityCircleView.contentMode = .scaleAspectFill
        cityCircleView.clipsToBounds = true
        cityCircleView.layer.cornerRadius = (UIScreen.main.bounds.width-36)/2 / 2
    }
    
    func config(row: City) {
        cityLabel.text = "\(row.city_name)|\(row.city_english_name)"
        subLabel.text = row.city_explain
        cityCircleView.kf.setImage(with: URL(string: row.city_image))
    }
}
