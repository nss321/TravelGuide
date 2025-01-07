//
//  CityDetailViewController.swift
//  TravelGuide
//
//  Created by BAE on 1/7/25.
//

import UIKit

class CityDetailViewController: UIViewController {

    var detail: Travel?
    
    @IBOutlet var cityImageView: UIImageView!
    @IBOutlet var cityLabel: UILabel!
    @IBOutlet var descLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupNavigation()
    }
    
    func setupNavigation() {
        navigationItem.title = "관광지 화면"
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage.symbolWithTint("chevron.left", .darkGray), style: .plain, target: self, action: #selector(popThisViewController))
    }
    
    func setupUI() {
        guard let detail else {
            loadError(log: "Travel Instance nil")
            return
        }
        guard let link = detail.travel_image, let url = URL(string: link) else {
            loadError(log: "Travel.travel_image nil")
            return
        }
        
        cityImageView.kf.setImage(with: url)
        cityImageView.contentMode = .scaleAspectFill
        cityImageView.clipsToBounds = true
        cityImageView.layer.cornerRadius = 12
        cityLabel.text = detail.title
        descLabel.text = detail.description
        
    }
    
    func loadError(log: String) {
        print("도시 정보를 알 수 없음.")
        cityImageView.image = UIImage.symbolWithTint("xmark", .systemGray)
        cityLabel.text = "정보를 불러올 수 없음 :<"
        descLabel.text = "지금은 정보를 불러올 수 없어요.\n잠시 후 다시 시도하시거나, 문의를 남겨주세요."
    }
    
    @objc func popThisViewController() {
        self.navigationController?.popViewController(animated: true)
    }

    @IBAction func popButtonTapped(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
}
