//
//  ADDetaileViewController.swift
//  TravelGuide
//
//  Created by BAE on 1/7/25.
//

import UIKit

class AdDetaileViewController: UIViewController {

    var ad: Travel?
    
    @IBOutlet var advertisementLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigation()
        setupUI()
    }
    
    func setupNavigation() {
        navigationItem.title = "광고 화면"
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage.symbolWithTint("xmark", .darkGray), style: .plain, target: self, action: #selector(popThisViewController))
    }
    
    func setupUI() {
        if let ad {
            advertisementLabel.text = ad.title
        }
    }
    
    @objc func popThisViewController() {
        dismiss(animated: true) {
            print("Dismiss: AdDetailViewContoller ")
        }
    }

}
