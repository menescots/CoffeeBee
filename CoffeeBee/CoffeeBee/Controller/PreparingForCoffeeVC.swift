//
//  PreparingForCoffeeVC.swift
//  CoffeeBee
//
//  Created by Agata Menes on 25/08/2022.
//

import UIKit
import Lottie

class PreparingForCoffeeVC: UIViewController {
    
    private let cupSlider: UISlider = {
        let mySlider = UISlider()
        mySlider.minimumValue = 250
        mySlider.maximumValue = 1250
        mySlider.isContinuous = true
        mySlider.tintColor = UIColor(named: "yellow")
        return mySlider
    }()
    
    private let temperatureLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 25, weight: .light)
        label.textColor = UIColor(named: "labelColor")
        label.text = "96 C"
        return label
    }()
    
    private let waterLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 25, weight: .light)
        label.textColor = UIColor(named: "labelColor")
        label.text = "250"
        return label
    }()
    
    private let coffeeGroundsLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 25, weight: .light)
        label.textColor = UIColor(named: "labelColor")
        label.text = "Test"
        return label
    }()
    
    let coffeImg = UIImage(named: "coffeeImg")
    let step:Float=10
    var coffeeToPrepare:String?
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "BackgroundColor")
        title = coffeeToPrepare
       
        cupSlider.addTarget(self, action: #selector(self.sliderValueDidChange(_:)), for: .valueChanged)
        cupSlider.setThumbImage(coffeImg, for: .normal)
        view.addSubview(cupSlider)
        view.addSubview(waterLabel)
        view.addSubview(coffeeGroundsLabel)
        view.addSubview(temperatureLabel)
    }
    
    @objc func sliderValueDidChange(_ sender:UISlider!){

        let roundedStepValue = round(sender.value / step) * step
        sender.value = roundedStepValue
        
        waterLabel.text = String(sender.value)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let size = view.frame.width/3
        cupSlider.frame = CGRect(x: (view.frame.width-size)/2,
                                 y: view.top+30,
                                 width: view.frame.width-50,
                                 height: 200)
        cupSlider.center.x = self.view.center.x
    }
}
