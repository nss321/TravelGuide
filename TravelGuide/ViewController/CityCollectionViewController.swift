//
//  CityCollectionViewController.swift
//  TravelGuide
//
//  Created by BAE on 1/7/25.
//

import UIKit
import RegexBuilder

final class CityCollectionViewController: UIViewController {

    @IBOutlet var searchTextField: UITextField!
    @IBOutlet var cityCollectionView: UICollectionView!
    @IBOutlet var regionSegmentedControl: UISegmentedControl!
    
    let cityInfo = CityInfo().city
    var domesticCities: [City] {
        cityInfo.filter { $0.domestic_travel }
    }
    var overseasCities: [City] {
        cityInfo.filter { !$0.domestic_travel }
    }
    var filterdList: [City] = [] {
        didSet {
            cityCollectionView.reloadData()
        }
    }
    var currentText = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        searchTextField.addTarget(self, action: #selector(returnKeyTapped), for: .editingDidEndOnExit)
        searchTextField.addTarget(self, action: #selector(realTimeSearching), for: .editingChanged)
        regionSegmentedControl.addTarget(self, action: #selector(regionSegmentedChanged), for: .valueChanged)
    }
    
    func setupUI() {
//        print(UIDevice.current.name)
        cityCollectionView.dataSource = self
        cityCollectionView.delegate = self
        let xib = UINib(nibName: "CityCollectionViewCell", bundle: nil)
        cityCollectionView.register(xib, forCellWithReuseIdentifier: CityCollectionViewCell.identifier)
        
        
        /// 개발 해상도
        /// 16pro max ->  440 996 / 1 : 2.17
        /// 14              ->  390 996 / 1 : 2.16
        /// SE3           ->  375 996 / 1 : 1.77

        
        let device = UIDevice.current.name.contains("SE")
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(
            width: (UIScreen.main.bounds.width-36)/2,
            height: device ? (UIScreen.main.bounds.height / 3) : (UIScreen.main.bounds.height*0.85) / 3
        )
        layout.minimumLineSpacing = 12
        layout.minimumInteritemSpacing = 12
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        cityCollectionView.collectionViewLayout = layout
    }
    
    @objc func returnKeyTapped(_ sender: UITextField) {
        view.endEditing(true)
        if searchTextField.text! == "" {
            showSimpleAlert(title: "경고", message: "공백을 입력했습니다.", handler: nil)
        } else if filterdList.isEmpty {
            showSimpleAlert(title: "검색 결과", message: "검색 결과가 없습니다 (´;︵;`) ", handler: nil)
            searchTextField.text = ""
        }
        cityCollectionView.reloadData()
    }
    
    @objc func realTimeSearching(_ sender: UITextField) {
//        print(searchTextField.text!)
        searchingText()
    }
    
    func searchingText() {
        guard let item = searchTextField.text else { return }
        
        if item == " " {
            filterdList.removeAll()
            cityCollectionView.reloadData()
            return
        } else if item == "" {
            filterdList = cityInfo
            cityCollectionView.reloadData()
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
//                print("\($0.city_name)")
                print("도시:\($0.city_name), 검출 문자: \(item)")
                self.currentText = item
                filterdList.append($0)
            }
        }
    }
    
    @objc func regionSegmentedChanged(_ sender: UISegmentedControl) {
        view.endEditing(true)
        searchTextField.text = ""
        cityCollectionView.reloadData()
    }

}

extension CityCollectionViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if searchTextField.isEditing {
            return filterdList.count
        } else {
            switch regionSegmentedControl.selectedSegmentIndex {
            case 0:
                return cityInfo.count
            case 1:
                return domesticCities.count
            case 2:
                return overseasCities.count
            default:
                return cityInfo.count
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CityCollectionViewCell.identifier, for: indexPath) as! CityCollectionViewCell
//        cell.layer.borderColor = UIColor.red.cgColor
//        cell.layer.borderWidth = 1
        
        if searchTextField.isEditing {
//            cell.config(row: filterdList[indexPath.row])
            cell.config(row: filterdList[indexPath.row], currentText: self.currentText)
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
