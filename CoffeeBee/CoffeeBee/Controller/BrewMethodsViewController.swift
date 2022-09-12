//
//  BrewMethodsViewController.swift
//  CoffeeBee
//
//  Created by Agata Menes on 23/08/2022.
//

import UIKit

class BrewMethodsViewController: UIViewController {
    var coffeeDesc: String?
    @IBOutlet var collectionView: UICollectionView!
    var coffeeMethods = [CoffeeMethods]()
    
    let mokaPot = CoffeeMethods(name: "Moka Pot", waterRatio: 8, grindSize: "Fine", time: 210, temperatureInC: 95)
    let turkishCoffee = CoffeeMethods(name: "Turkish coffee", waterRatio: 12, grindSize: "Extra-fine", time: 600, temperatureInC: 70)
    let frenchPress = CoffeeMethods(name: "French Press", waterRatio: 15, grindSize: "Coarse", time: 240, temperatureInC: 94)
    let aeroPress = CoffeeMethods(name: "AeroPress", waterRatio: 10, grindSize: "Fine", time: 150, temperatureInC: 90)
    let syphon = CoffeeMethods(name: "Syphon", waterRatio: 15, grindSize: "Medium", time: 150, temperatureInC: 84)
    let coldBrew = CoffeeMethods(name: "Cold Brew", waterRatio: 8, grindSize: "Coarse", time: 57600, temperatureInC: 20)
    let chemex = CoffeeMethods(name: "Chemex", waterRatio: 15, grindSize: "Medium-coarse", time: 600, temperatureInC: 94)
    let harioV60 = CoffeeMethods(name: "Hario V60", waterRatio: 15, grindSize: "Medium-coarse", time: 240, temperatureInC: 92)
    let espresso = CoffeeMethods(name: "Espresso", waterRatio: 2, grindSize: "Fine", time: 30, temperatureInC: 93)
    
    let coffeeMethodsImages: [UIImage] = [
        UIImage(named: "mokapot")!,
        UIImage(named: "cezve")!,
        UIImage(named: "frenchpress")!,
        UIImage(named: "aeropress")!,
        UIImage(named: "syphon")!,
        UIImage(named: "coldbrew")!,
        UIImage(named: "chemex")!,
        UIImage(named: "hariov60")!,
        UIImage(named: "espresso")!
    ]
    override func viewDidLoad() {
        super.viewDidLoad()
        coffeeMethods.append(contentsOf: [mokaPot, turkishCoffee, frenchPress, aeroPress, syphon, coldBrew, chemex, harioV60, espresso])
    }
}

extension BrewMethodsViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return coffeeMethods.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CoffeeCell", for: indexPath) as! CollectionViewCell
        cell.coffeeMethodLabel.text = coffeeMethods[indexPath.item].name
        cell.coffeeMethodImageView.image = coffeeMethodsImages[indexPath.item]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let yourWidth = collectionView.bounds.width/3.0
        let yourHeight = yourWidth + 60
        return CGSize(width: yourWidth, height: yourHeight)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.zero
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = SelectedCoffeeViewController()
        vc.selectedCoffeeImg = coffeeMethodsImages[indexPath.row]
        vc.selectedCoffeeMethod = coffeeMethods[indexPath.row]
        vc.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(vc, animated: true)
    }
}
