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
    
//    @objc func checkButtonTapped(_ sender: UITapGestureRecognizer) {
//        if let view = sender.view {
//            list[view.tag].isChecked.toggle()
//            tableView.reloadData()
//        } else {
//            print("UITapGestureReconizer nil 검출")
//            return
//        }
//    }
    
    @objc func starButtonTapped(_ sender: UIButton) {
        list[sender.tag].isStarred.toggle()
        tableView.reloadData()
    }
    
    @IBAction func addButtonTapped(_ sender: UIButton) {
        view.endEditing(true)
        print(#function)
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
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        list.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "thirdTableViewCell", for: indexPath) as! ThirdTableViewCell
        
        let row = list[indexPath.row]
        
        let symbolConfig = UIImage.SymbolConfiguration(hierarchicalColor: .label)
        var checkMarkSymbol = row.isChecked ? UIImage(systemName: "checkmark.square.fill") : UIImage(systemName: "checkmark.square")
        checkMarkSymbol = checkMarkSymbol?.applyingSymbolConfiguration(symbolConfig)
        
        var starSymbol = row.isStarred ? UIImage(systemName: "star.fill") : UIImage(systemName: "star")
        starSymbol = starSymbol?.applyingSymbolConfiguration(symbolConfig)
        
        cell.checkmark.tag = indexPath.row
        cell.starButton.tag = indexPath.row
        
        if row.isChecked {
            cell.itemLabel.attributedText = NSAttributedString(string: row.item, attributes: [.strikethroughStyle : NSUnderlineStyle.single.rawValue, .strikethroughColor : UIColor.label])
        } else {
            cell.itemLabel.attributedText = NSAttributedString(string: row.item, attributes: nil)
        }
        
        cell.checkmark.image = checkMarkSymbol
        cell.starButton.setImage(starSymbol, for: .normal)
        cell.containerView.layer.cornerRadius = 12
        
//        cell.checkmark.isUserInteractionEnabled = true
//        cell.checkmark.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(checkButtonTapped)))
        
        cell.starButton.addTarget(self, action: #selector(starButtonTapped), for: .touchUpInside)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        list[indexPath.row].isChecked.toggle()
        tableView.reloadData()
    }
}
