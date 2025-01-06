//
//  CityTableViewController.swift
//  TravelGuide
//
//  Created by BAE on 1/6/25.
//

import UIKit

class CityTableViewController: UITableViewController {
    
    let cityInfo = CityInfo().city
    var domesticCities: [City] {
        cityInfo.filter { $0.domestic_travel }
    }
    var overseasCities: [City] {
        cityInfo.filter { !$0.domestic_travel }
    }
    var filterdList: [City] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    @IBOutlet var searchTextField: UITextField!
    @IBOutlet var regionSegmentedControl: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 160
        let nib = UINib(nibName: "CityTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: CityTableViewCell.identifier)
//        print(domesticCities)
//        print(overseasCities)
    }
    
    @IBAction func returnKeyTapped(_ sender: UITextField) {
        view.endEditing(true)
        if searchTextField.text! == "" {
            showSimpleAlert(title: "경고", message: "공백을 입력했습니다.", handler: nil)
        }
        tableView.reloadData()
    }
    
    @IBAction func realTimeSearching(_ sender: Any) {
        print(searchTextField.text!)
        searchingText()
//        print("검색 결과 : \(filterdList)")
    }
    
//    @discardableResult
    func searchingText() {
        guard let item = searchTextField.text else { return }
        
        if item == " " {
            filterdList.removeAll()
            tableView.reloadData()
            return
        } else if item == "" {
            filterdList = cityInfo
            tableView.reloadData()
            return
        }
        
        switch regionSegmentedControl.selectedSegmentIndex {
        case 0:
            findingKeyword(targetList: cityInfo, forWhat: item)
        case 1:
            findingKeyword(targetList: domesticCities, forWhat: item)
        case 2:
            findingKeyword(targetList: overseasCities, forWhat: item)
        default:
            print("Invalid SegmentedControl Index")
        }
    }
    
    func findingKeyword(targetList list: [City], forWhat item: String) {
        filterdList.removeAll()
        print("current: \(item)")
        list.forEach {
            if "\($0.city_name), \($0.city_english_name), \($0.city_explain)".lowercased().contains(item.lowercased()) {
                print("\($0.city_name)")
                print("검출 문자: \(item)")
                filterdList.append($0)
            }
        }
    }
    
    @IBAction func regionSegmentedChanged(_ sender: UISegmentedControl) {
        view.endEditing(true)
        searchTextField.text = ""
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchTextField.isEditing {
            return filterdList.count
        } else {
            switch regionSegmentedControl.selectedSegmentIndex {
            case 0:
                //            print(cityInfo.count)
                return cityInfo.count
            case 1:
                //            print(domesticCities.count)
                return domesticCities.count
            case 2:
                //            print(overseasCities.count)
                return overseasCities.count
            default:
                return cityInfo.count
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CityTableViewCell.identifier, for: indexPath) as! CityTableViewCell
        
        if searchTextField.isEditing {
            cell.config(row: filterdList[indexPath.row])
            return cell
        } else {
            switch regionSegmentedControl.selectedSegmentIndex {
            case 0:
                cell.config(row: cityInfo[indexPath.row])
                return cell
            case 1:
                cell.config(row: domesticCities[indexPath.row])
                return cell
            case 2:
                cell.config(row: overseasCities[indexPath.row])
                return cell
            default:
                cell.config(row: cityInfo[indexPath.row])
                return cell
            }
        }
        
    
    }

}
