//
//  ShadowTestViewController.swift
//  TravelGuide
//
//  Created by BAE on 1/6/25.
//

import UIKit

class ShadowTestViewController: UIViewController {

    @IBOutlet var container: UIView!
    @IBOutlet var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        container.layer.cornerRadius = 30
        container.layer.shadowOffset = CGSize(width: 5, height: 5)
        container.layer.shadowOpacity = 0.7
        container.layer.shadowRadius = 5
        container.layer.shadowColor = UIColor.gray.cgColor
        container.layer.maskedCorners = CACornerMask(arrayLiteral: .layerMinXMinYCorner, .layerMaxXMaxYCorner)
        
        imageView.kf.setImage(with: URL(string: "https://thumbnews.nateimg.co.kr/view610///news.nateimg.co.kr/orgImg/is/2024/02/20/isp20240219000080.800x.0.jpg"))
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 30
        imageView.layer.maskedCorners = CACornerMask(arrayLiteral: .layerMinXMinYCorner, .layerMaxXMaxYCorner)
    }
    


}
