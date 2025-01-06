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
        print(#function)
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
        
        cell.subtitleLabel.text = row.subtitle
        
        cell.photoImageView.kf.setImage(with: url)
        
        cell.dateLabel.text = convertMagazineDate(stringDate: row.date)
    
//        print(convertMagazineDate(stringDate: row.date))
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UIScreen.main.bounds.height * 0.6
    }
    
}
