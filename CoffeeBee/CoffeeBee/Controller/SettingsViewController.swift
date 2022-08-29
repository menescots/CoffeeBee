//
//  SettingsViewController.swift
//  CoffeeBee
//
//  Created by Agata Menes on 29/08/2022.
//

import UIKit

class SettingsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func selectTemperatureUnit(_ sender: UISegmentedControl) {
        let selectedUnit = sender.titleForSegment(at: sender.selectedSegmentIndex)
        UserDefaults.standard.set(selectedUnit, forKey: "tempUnit")
    }
    
    
    @IBAction func selectWeightUnit(_ sender: UISegmentedControl) {
        let selectedUnit = sender.titleForSegment(at: sender.selectedSegmentIndex)
        UserDefaults.standard.set(selectedUnit, forKey: "weightUnit")
    }
}
