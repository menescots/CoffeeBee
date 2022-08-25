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
    
    private let coffeeMethodDesc = [
    "Turkish coffee is a style of coffee prepared in a cezve using very finely ground coffee beans without filtering. Turkish coffee is a rich, thick, and delightful drink to be enjoyed slowly with good company.",
    "A compact Italian-made eight-sided wonder, the moka pot makes espresso-style coffee without the need for a large, expensive, high-maintenance machine. Invented in 1933 by Italian engineer Alfonso Bialetti.",
    "For French press coffee, the grinds stay in the bottom of the beaker throughout the entire process. Because the grinds remain in contact with the coffee, the bean extraction never ends, creating an oily and bold taste.",
    "The Aeropress is a piston-style brewer that forces coffee through a thin paper filter directly into a cup. Aeropress coffee has a clean taste with clearly defined flavor notes thanks to the paper filter that stops any oil and sediment from getting in the cup.",
    "Siphon (vacuum pot) coffee is a brewing method that involves a process of mixing coffee with boiling water ascended from the flask through siphonage to extract and filter the coffee.",
    "Cold-brewed coffee, or cold brew, is coffee made by steeping ground coffee in room-temperature water for several hours, usually 12 to 18 hours or even longer, then straining out the grounds and chilling it before serving it either as-is, over ice, or diluted with water.",
    "Chemex is a pour-over method, which means that the water passes through a bed of coffee and a filter, normally made out of paper. In contrast to say a French press, the Chemex will give you a remarkably clean cup of coffee.",
    "The name stems from the shape of the device. It is “V” shaped with angles of 60 degrees. The internal sides also have interior ridges which help with air flow during the brewing method. Filter paper is inserted into the V shape and coffee grounds placed within the filter paper. The brewed coffee then drips into your cup.",
    "Espresso is a type of coffee. More specifically, it's a method of brewing coffee that uses high water pressure and finely ground beans to make a small, concentrated shot. One of espresso's defining characteristics is a top layer of foam known as the crema. "
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
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = SelectedCoffeeViewController()
        vc.selectedCoffeeImg = coffeeMethodsImages[indexPath.row]
        vc.selectedCoffeeName = coffeeMethods[indexPath.row]
        vc.selectedCoffeeDesc = coffeeMethodDesc[indexPath.row]
        vc.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(vc, animated: true)
    }
}
