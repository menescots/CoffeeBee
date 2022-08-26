//
//  SelectedCoffeeViewController.swift
//  CoffeeBee
//
//  Created by Agata Menes on 24/08/2022.
//

import UIKit

class SelectedCoffeeViewController: UIViewController {
    var selectedCoffeeImg: UIImage?
    var selectedCoffeeName: String?
    var selectedCoffeeDesc: String?
    
    private var coffeeImage: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    private let coffeeNameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 30, weight: .semibold)
        label.textColor = UIColor(named: "labelColor")
        return label
    }()
    
    private let brewMethodDesc: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(named: "labelColor")
        label.font = .systemFont(ofSize: 20, weight: .light)
        label.textAlignment = .justified
        label.sizeToFit()
        label.numberOfLines = 0
        return label
    }()
    
    private let makeThisCoffeeButton: UIButton = {
        let button = UIButton()
        button.setTitle("Make this coffee", for: .normal)
        button.backgroundColor = UIColor(named: "labelColor")
        button.layer.opacity = 0.7
        button.setTitleColor(UIColor(named: "BackgroundColor"), for: .normal)
        button.layer.cornerRadius = 25
        button.layer.masksToBounds = true
        button.titleLabel?.font = .systemFont(ofSize: 17, weight: .light)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "BackgroundColor")
        guard let selectedCoffeeImg = selectedCoffeeImg else {
            return
        }
        coffeeImage.image = selectedCoffeeImg
        coffeeNameLabel.text = selectedCoffeeName
        brewMethodDesc.text = selectedCoffeeDesc
        
        view.addSubview(coffeeImage)
        view.addSubview(coffeeNameLabel)
        view.addSubview(brewMethodDesc)
        view.addSubview(makeThisCoffeeButton)
        makeThisCoffeeButton.addTarget(self, action: #selector(makeThisCoffeeButtonTapped), for: .touchUpInside)
    }

    @objc private func makeThisCoffeeButtonTapped() {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let newView = storyBoard.instantiateViewController(withIdentifier: "preapreCoffeeVc") as! PreparingForCoffeeVC
        newView.hidesBottomBarWhenPushed = true
        newView.coffeeToPrepare = selectedCoffeeName
        self.navigationController?.pushViewController(newView, animated: true)
        
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let size = view.frame.width/3
        coffeeImage.frame = CGRect(x: (view.frame.width-size)/2,
                                   y: view.directionalLayoutMargins.top+30,
                                   width: view.frame.width,
                                   height: 200)
        coffeeImage.contentMode = .scaleAspectFit
        coffeeImage.center.x = self.view.center.x
        
        coffeeNameLabel.frame = CGRect(x: (view.frame.width-size)/2,
                                       y: coffeeImage.bottom+20,
                                      width: view.frame.width,
                                      height: 30)
        coffeeNameLabel.center.x = self.view.center.x
        coffeeNameLabel.textAlignment = .center
        
        brewMethodDesc.frame = CGRect(x: (view.frame.width-size)/2,
                                       y: coffeeNameLabel.bottom+10,
                                      width: view.frame.width-50,
                                      height: 220)
        brewMethodDesc.center.x = self.view.center.x
        
        makeThisCoffeeButton.frame = CGRect(x: (view.frame.width-size)/2,
                                            y: view.bottom-100,
                                      width: 200,
                                      height: 50)
        makeThisCoffeeButton.center.x = self.view.center.x
        
    }
}
