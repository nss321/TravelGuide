//
//  ThirdTableViewController.swift
//  TravelGuide
//
//  Created by BAE on 1/4/25.
//

import UIKit

class ThirdTableViewController: UITableViewController {

    @IBOutlet var shoppingTextField: UITextField!
    
    let list = ["바나나", "똥", "전기충격기"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(self)
        setTextField()
    }

    func setTextField() {
        shoppingTextField.layer.cornerRadius = 12
        shoppingTextField.leftViewMode = .always
        shoppingTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: 0))
    }
    @IBAction func addButtonTapped(_ sender: UIButton) {
        view.endEditing(true)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        list.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "thirdTableViewCell", for: indexPath) as! ThirdTableViewCell
        
        let row = list[indexPath.row]
        
        cell.itemLabel.text = row
        cell.containerView.layer.cornerRadius = 12
        
        return cell
    }
}
