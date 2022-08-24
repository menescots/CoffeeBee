//
//  BrewMethodsViewController.swift
//  CoffeeBee
//
//  Created by Agata Menes on 23/08/2022.
//

import UIKit

class BrewMethodsViewController: UIViewController {

    @IBOutlet var collectionView: UICollectionView!
    let coffeeMethods = [
        "Turkish coffee",
        "Moka Pot",
        "French press",
        "AeroPress",
        "Syphon",
        "Cold Brew",
        "Chemex",
        "Hario V60",
        "Espresso",
    ]
    
    let coffeeMethodsImages: [UIImage] = [
        UIImage(named: "cezve")!,
        UIImage(named: "mokapot")!,
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
    }

}

extension BrewMethodsViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return coffeeMethods.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CoffeeCell", for: indexPath) as! CollectionViewCell
        cell.coffeeMethodLabel.text = coffeeMethods[indexPath.item]
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
}
