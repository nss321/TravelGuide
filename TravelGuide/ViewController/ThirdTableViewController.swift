//
//  ThirdTableViewController.swift
//  TravelGuide
//
//  Created by BAE on 1/4/25.
//

import UIKit

class ThirdTableViewController: UITableViewController {

    @IBOutlet var shoppingTextField: UITextField!
    
    var list: [ShoppingItem] = []
    
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
    
    @objc func starButtonTapped(_ sender: UIButton) {
        list[sender.tag].isStarred.toggle()
        tableView.reloadRows(at: [IndexPath(row: sender.tag, section: 0)], with: .automatic)
    }
    
    func addTextFieldText() {
        guard let item = shoppingTextField.text else {
            print("쇼핑 텍스트 필드 입력 에러: nil 검출")
            return
        }
        
        if item == "" {
            showSimpleAlert(title: "경고", message: "입력칸이 공백입니다.", handler: nil)
        } else {
            list.append(ShoppingItem(isChecked: false, item: item, isStarred: false))
            shoppingTextField.text = ""
            tableView.reloadData()
        }
    }
    
    @IBAction func addButtonTapped(_ sender: UIButton) {
        view.endEditing(true)
        print(#function)
        addTextFieldText()
    }
    
    @IBAction func shoppingTextFieldReturn(_ sender: UITextField) {
        view.endEditing(true)
        addTextFieldText()
    }
    
}

extension ThirdTableViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        list.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = list[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: ThirdTableViewCell.identifier, for: indexPath) as! ThirdTableViewCell
        
        cell.config(row: row)
        cell.checkmark.tag = indexPath.row
        cell.starButton.tag = indexPath.row
        cell.starButton.addTarget(self, action: #selector(starButtonTapped), for: .touchUpInside)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        list[indexPath.row].isChecked.toggle()
        tableView.reloadRows(at: [indexPath], with: .automatic)
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        // default editing style -> delete
        if editingStyle == .delete {
            list.remove(at: indexPath.row)
            tableView.reloadData()
        }
    }
    
    override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let checkButton = UIContextualAction(style: .normal, title: nil) { (UIContextualAction, UIView, success: @escaping (Bool) -> Void) in
            self.list[indexPath.row].isChecked.toggle()
            tableView.reloadRows(at: [indexPath], with: .automatic)
            success(true)
        }
        checkButton.image = UIImage(systemName: "checkmark")
        checkButton.backgroundColor = .tertiaryLabel
        
        
        let starButton = UIContextualAction(style: .normal, title: nil) { (UIContextualAction, UIView, success: @escaping (Bool) -> Void) in
            self.list[indexPath.row].isStarred.toggle()
            tableView.reloadRows(at: [indexPath], with: .automatic)
            success(true)
        }
        starButton.image = UIImage(systemName: "star.fill")
        starButton.backgroundColor = .quaternaryLabel
        
        return UISwipeActionsConfiguration(actions:[checkButton, starButton])
    }
    
}
