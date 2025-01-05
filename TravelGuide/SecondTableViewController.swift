//
//  SecondTableViewController.swift
//  TravelGuide
//
//  Created by BAE on 1/4/25.
//

import UIKit

class SecondTableViewController: UITableViewController {

    let travleInfo = TravelInfo().travel
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(self)
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        travleInfo.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "secondTableViewCell", for: indexPath) as! SecondTableViewCell
        
        let row = travleInfo[indexPath.row]
        
        
        
        return cell
        
    }

    
}
