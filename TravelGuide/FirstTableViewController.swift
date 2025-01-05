//
//  FirstTableViewController.swift
//  TravelGuide
//
//  Created by BAE on 1/4/25.
//

import UIKit
import Kingfisher

class FirstTableViewController: UITableViewController {

    let magazines = MagazineInfo().magazine
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        print(self)
//        print(Int.max)
    }
    
    func convertMagazineDate(stringDate: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyMMdd"
        guard let date = formatter.date(from: stringDate) else {
            print("can not convert string to date")
            return ""
        }
        formatter.dateFormat = "yy년 M월 dd일"
        return formatter.string(from: date)
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return magazines.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "firstTableViewCell", for: indexPath) as! FirstTableViewCell
        let row = magazines[indexPath.row]
        let url = URL(string: row.photo_image)
        
        cell.titleLabel.text = row.title
        cell.titleLabel.font = .boldSystemFont(ofSize: 24)
        
        cell.subtitleLabel.text = row.subtitle
        cell.subtitleLabel.font = .systemFont(ofSize: 16)
        cell.subtitleLabel.textColor = .gray
        
        cell.photoImageView.kf.setImage(with: url)
        cell.photoImageView.clipsToBounds = true
        cell.photoImageView.layer.cornerRadius = 12
        
        cell.dateLabel.text = convertMagazineDate(stringDate: row.date)
        cell.dateLabel.font = .systemFont(ofSize: 16)
        cell.dateLabel.textColor = .gray
    
//        print(convertMagazineDate(stringDate: row.date))
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UIScreen.main.bounds.height * 0.6
    }
    
}
