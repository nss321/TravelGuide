//
//  CityCollectionViewController.swift
//  TravelGuide
//
//  Created by BAE on 1/7/25.
//

import UIKit

class CityCollectionViewController: UIViewController {

    let cityInfo = CityInfo().city

    @IBOutlet var cityCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
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

}

extension CityCollectionViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        cityInfo.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let row = cityInfo[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CityCollectionViewCell.identifier, for: indexPath) as! CityCollectionViewCell
        cell.config(row: row)
//        cell.layer.borderColor = UIColor.red.cgColor
//        cell.layer.borderWidth = 1
        return cell
    }
    
}
