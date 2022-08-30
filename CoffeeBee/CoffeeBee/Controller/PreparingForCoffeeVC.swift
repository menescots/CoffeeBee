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
    var coffeeToPrepare:CoffeeMethods?
    
    @IBOutlet var waterValueLabel: UILabel!
    @IBOutlet var coffeeValueLabel: UILabel!
    @IBOutlet var temperatureLabel: UILabel!
    
    @IBOutlet var fiveCups: UILabel!
    @IBOutlet var fourCups: UILabel!
    @IBOutlet var oneCup: UILabel!
    @IBOutlet var twoCups: UILabel!
    @IBOutlet var threeCups: UILabel!
    
    @IBOutlet var methodLabel: UILabel!
    @IBOutlet var rangeOfGrindLabel: UILabel!
    @IBOutlet var timeLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "BackgroundColor")
        guard let coffeeToPrepare = coffeeToPrepare else {
            return
        }
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.hour, .minute, .second]
        formatter.unitsStyle = .abbreviated
        let formattedString = formatter.string(from: TimeInterval(coffeeToPrepare.time))!
 
        CoffeNameLabel.text = coffeeToPrepare.name
        methodLabel.text = coffeeToPrepare.name
        rangeOfGrindLabel.text = coffeeToPrepare.grindSize
        timeLabel.text = formattedString
        
        calculateTempAndCoffee(water: 250)
        highlightNumberOfCups(water: 250)
    }
    
    @IBAction func sliderValueDidChange(_ sender: UISlider) {
        let roundedStepValue = round(sender.value / step) * step
        sender.value = roundedStepValue
        let intSliderValue = Int(sender.value)
        
        calculateTempAndCoffee(water: intSliderValue)
        highlightNumberOfCups(water: intSliderValue)
    }
    
    private func calculateTempAndCoffee(water: Int) {
        let selectedTempUnit = UserDefaults.standard.value(forKey: "tempUnit")
        let selectedWeightUnit = UserDefaults.standard.value(forKey: "weightUnit")
        guard let coffeeToPrepare = coffeeToPrepare else {
            return
        }

        let coffeeTemperatureInCelsius = coffeeToPrepare.temperatureInC
        let coffeeRatio = coffeeToPrepare.waterRatio
        let coffeeInGrams = water / coffeeRatio
        
        guard let selectedTempUnit = selectedTempUnit as? String,
              let selectedWeightUnit = selectedWeightUnit as? String else {
            return
        }

        switch selectedTempUnit {
        case "Celsius":
            temperatureLabel.text = String("\(coffeeTemperatureInCelsius)C")
        case "Fahrenheit":
            let temperatureInF = Double(coffeeTemperatureInCelsius) * 1.8 + 32
            temperatureLabel.text = String("\(temperatureInF.roundTo(places: 0))F")
        default:
            break
            
        }
        
        switch selectedWeightUnit {
        case "Grams":
            coffeeValueLabel.text = String("\(coffeeInGrams)g")
            waterValueLabel.text = String("\(water)ml")
        case "Ounces":
            let coffeeOuncesLong = Double(coffeeInGrams)/28.34952
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
