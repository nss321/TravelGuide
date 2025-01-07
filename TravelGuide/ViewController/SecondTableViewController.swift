//
//  SecondTableViewController.swift
//  TravelGuide
//
//  Created by BAE on 1/4/25.
//

import UIKit
import Kingfisher

class SecondTableViewController: UITableViewController {

    var travleInfo = TravelInfo().travel
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(self)
    }
    
    @objc func likeButtonTapped(_ sender: UIButton) {
//        print(sender.tag)
        travleInfo[sender.tag].like?.toggle()
        tableView.reloadRows(at: [IndexPath(row: sender.tag, section: 0)], with: .automatic)
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        travleInfo.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = travleInfo[indexPath.row]
        
        switch row.ad {
        case true:
            let cell = tableView.dequeueReusableCell(withIdentifier: AdvertiseTableViewCell.identifier, for: indexPath) as! AdvertiseTableViewCell
            cell.config(row: row)
            return cell
            
        case false:
            let cell = tableView.dequeueReusableCell(withIdentifier: SecondTableViewCell.identifier, for: indexPath) as! SecondTableViewCell
            cell.config(row: row)
            cell.likeButton.tag = indexPath.row
            cell.likeButton.addTarget(self, action: #selector(likeButtonTapped), for: .touchUpInside)
            
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        var height: CGFloat
        switch travleInfo[indexPath.row].ad {
        case true:
            height = UIScreen.main.bounds.height * 0.15
            break
        case false:
            height = UIScreen.main.bounds.height / 6
            break
        }
        
        return height
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let row = travleInfo[indexPath.row]
        
        if row.ad {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "AdDetaileViewController") as! AdDetaileViewController
            vc.ad = row
            navigationController?.pushViewController(vc, animated: true)
        } else {
            let vc = self.storyboard?.instantiateViewController(identifier: "CityDetailViewController") as! CityDetailViewController
            vc.detail = row
            navigationController?.pushViewController(vc, animated: true)
            
        }
        
    }
    
}
