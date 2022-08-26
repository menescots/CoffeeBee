//
//  PreparingForCoffeeVC.swift
//  CoffeeBee
//
//  Created by Agata Menes on 25/08/2022.
//

import UIKit
import Lottie

class PreparingForCoffeeVC: UIViewController {
    
    let step:Float=10
    @IBOutlet var CoffeNameLabel: UILabel!
    var coffeeToPrepare:String?
    
    @IBOutlet var uiSlider: UISlider!
    
    @IBOutlet var waterValueLabel: UILabel!
    @IBOutlet var coffeeValueLabel: UILabel!
    @IBOutlet var temperatureLabel: UILabel!
    
    
    @IBOutlet var fiveCups: UILabel!
    @IBOutlet var fourCups: UILabel!
    @IBOutlet var oneCup: UILabel!
    @IBOutlet var twoCups: UILabel!
    @IBOutlet var threeCups: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "BackgroundColor")
        CoffeNameLabel.text = coffeeToPrepare
    }
    
    @IBAction func sliderValueDidChange(_ sender: UISlider) {
        let roundedStepValue = round(sender.value / step) * step
        sender.value = roundedStepValue
        let intSliderValue = Int(sender.value)
        guard let coffeeToPrepare = coffeeToPrepare else {
            return
        }
        calculateWaterCoffeeRatio(selectedCoffee: coffeeToPrepare, water: intSliderValue)
        highlightNumberOfCups(water: intSliderValue)
        waterValueLabel.text = String(sender.value)
        
    }
    
    private func calculateWaterCoffeeRatio(selectedCoffee: String, water: Int) {
        switch selectedCoffee {
        case "Turkish coffee":
            coffeeValueLabel.text = String(water/12)
        case "Moka pot":
            coffeeValueLabel.text = String(water/12)
        case "French press ":
            coffeeValueLabel.text = String(water/15)
        case "AeroPress":
            coffeeValueLabel.text = String(water/16)
        case "Syphon":
            coffeeValueLabel.text = String(water/15)
        case "Cold Brew":
            coffeeValueLabel.text = String(water/8)
        case "Chemex":
            coffeeValueLabel.text = String(water/15)
        case "Hario V60":
            coffeeValueLabel.text = String(water/15)
        case "Espresso":
            coffeeValueLabel.text = String(water/2)
        default:
            return
        }
    }
    
    private func highlightNumberOfCups(water: Int){
        
        if water % 250 == 0{
            switch water {
            case 250:
                oneCup.textColor = UIColor(named: "pinkColor")
            case 500:
                twoCups.textColor = UIColor(named: "pinkColor")
            case 750:
                threeCups.textColor = UIColor(named: "pinkColor")
            case 1000:
                fourCups.textColor = UIColor(named: "pinkColor")
            case 1250:
                fiveCups.textColor = UIColor(named: "pinkColor")
            default:
                break
            }
        } else {
            oneCup.textColor = UIColor(named: "labelColor")
                twoCups.textColor = UIColor(named: "labelColor")
            threeCups.textColor = UIColor(named: "labelColor")
                fourCups.textColor = UIColor(named: "labelColor")
                fiveCups.textColor = UIColor(named: "labelColor")
        }
    }
}
