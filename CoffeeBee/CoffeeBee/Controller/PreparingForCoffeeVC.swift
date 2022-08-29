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
        
        guard let coffeeToPrepare = coffeeToPrepare else {
            return
        }
        calculateWaterCoffeeRatio(selectedCoffee: coffeeToPrepare, water: 250)
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
        
    }
    
    private func calculateWaterCoffeeRatio(selectedCoffee: String, water: Int) {
        switch selectedCoffee {
        case "Turkish coffee":
            calculateTempAndCoffee(water: water, celsius: 70, ratio: 12)
        case "Moka Pot":
            calculateTempAndCoffee(water: water, celsius: 95, ratio: 12)
        case "French press ":
            calculateTempAndCoffee(water: water, celsius: 94, ratio: 15)
        case "AeroPress":
            calculateTempAndCoffee(water: water, celsius: 90, ratio: 16)
        case "Syphon":
            calculateTempAndCoffee(water: water, celsius: 90, ratio: 15)
        case "Cold Brew":
            calculateTempAndCoffee(water: water, celsius: 20, ratio: 8)
        case "Chemex":
            calculateTempAndCoffee(water: water, celsius: 94, ratio: 15)
        case "Hario V60":
            calculateTempAndCoffee(water: water, celsius: 92, ratio: 15)
        case "Espresso":
            calculateTempAndCoffee(water: water, celsius: 70, ratio: 2)
        default:
            return
        }
    }
    
    private func calculateTempAndCoffee(water: Int, celsius: Double, ratio: Double) {
        let selectedTempUnit = UserDefaults.standard.value(forKey: "tempUnit")
        let selectedWeightUnit = UserDefaults.standard.value(forKey: "weightUnit")
        let coffeeGrams = Double(water) / ratio
        
        guard let selectedTempUnit = selectedTempUnit as? String,
                let selectedWeightUnit = selectedWeightUnit as? String else {
            return
        }

        switch selectedTempUnit {
        case "Celsius":
            temperatureLabel.text = String("\(celsius)C")
        case "Fahrenheit":
            let temp = celsius * 1.8 + 32
            temperatureLabel.text = String("\(temp)F")
        default:
            break
            
        }
        
        switch selectedWeightUnit {
        case "Grams":
            coffeeValueLabel.text = String("\(coffeeGrams.roundTo(places: 2))g")
            waterValueLabel.text = String("\(water)ml")
        case "Ounces":
            let coffeeOuncesLong = coffeeGrams/28.34952
            let coffeeOunces = coffeeOuncesLong.roundTo(places: 2)
            let waterInOunces = Double(water)*0.033814
            
            coffeeValueLabel.text = String("\(coffeeOunces)oz")
            waterValueLabel.text = String("\(waterInOunces.roundTo(places: 2))fl oz")
        default:
            break
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
