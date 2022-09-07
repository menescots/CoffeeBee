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
    let syphon = CoffeeMethods(name: "Syphon", waterRatio: 15, grindSize: "Medium", time: 150, temperatureInC: 90)
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
    
    private let coffeeMethodDesc = [
    "Turkish coffee is a style of coffee prepared in a cezve using very finely ground coffee beans without filtering. Turkish coffee is a rich, thick, and delightful drink to be enjoyed slowly with good company.",
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
