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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "BackgroundColor")
        CoffeNameLabel.text = coffeeToPrepare
       
    }
    
    
    @IBAction func sliderValueDidChange(_ sender: UISlider) {
        let roundedStepValue = round(sender.value / step) * step
        sender.value = roundedStepValue
        print("slider value; \(sender.value)")
        waterValueLabel.text = String(Int(sender.value))
        
    }
}
