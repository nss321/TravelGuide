//
//  CityCollectionViewCell.swift
//  TravelGuide
//
//  Created by BAE on 1/7/25.
//

import UIKit

final class CityCollectionViewCell: UICollectionViewCell {

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
    
    func config(row: City, currentText: String) {
        
        let name = "\(row.city_name) | \(row.city_english_name)"
        let explain = row.city_explain
        
        cityLabel.attributedText = changeAllMatches(for: currentText, in: name)
        subLabel.attributedText = changeAllMatches(for: currentText, in: explain)
        cityCircleView.kf.setImage(with: URL(string: row.city_image))
        
    }
    
    func changeAllMatches(for pattern: String, in text: String) -> NSMutableAttributedString? {
        let attrStr = NSMutableAttributedString(string: text)
        do {
            let regex = try NSRegularExpression(pattern: pattern, options: [.caseInsensitive])
            
            let results = regex.matches(in: text, range: NSRange(location:0, length:text.count))
            results.forEach {
                attrStr.addAttribute(.backgroundColor, value: UIColor.systemYellow, range: $0.range)
            }
            
        } catch let error {
            print("invalid pattern: \(error.localizedDescription)")
            return nil
        }
        return  attrStr
    }
    
    
}
