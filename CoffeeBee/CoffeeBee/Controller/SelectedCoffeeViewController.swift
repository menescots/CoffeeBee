//
//  SelectedCoffeeViewController.swift
//  CoffeeBee
//
//  Created by Agata Menes on 24/08/2022.
//

import UIKit

class SelectedCoffeeViewController: UIViewController {
    var selectedCoffeeImg: UIImage?
    var selectedCoffeeMethod: CoffeeMethods?
    var coffeeInfo: Method?
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
        coffeeNameLabel.text = selectedCoffeeMethod?.name
        view.addSubview(coffeeImage)
        view.addSubview(coffeeNameLabel)
        view.addSubview(brewMethodDesc)
        view.addSubview(makeThisCoffeeButton)
        
        let infoButton = UIButton(type: .infoLight)
        infoButton.addTarget(self, action: #selector(getInfoAction), for: .touchUpInside)
        let infoBarButtonItem = UIBarButtonItem(customView: infoButton)
        navigationItem.rightBarButtonItem = infoBarButtonItem
        
        makeThisCoffeeButton.addTarget(self, action: #selector(makeThisCoffeeButtonTapped), for: .touchUpInside)
        if let localData = self.readLocalFile(forName: "methods") {
            self.parse(jsonData: localData)
        }
    }

   @objc private func getInfoAction() {
       let infoVC = CoffeeInformationVC()
       guard let coffeeInfo = coffeeInfo else {
           return
       }
       infoVC.websiteToLoad = coffeeInfo.pageURL
       navigationController?.pushViewController(infoVC, animated: true)
    }
    private func readLocalFile(forName name: String) -> Data? {
        do {
            if let bundlePath = Bundle.main.path(forResource: name,
                                                 ofType: "json"),
                let jsonData = try String(contentsOfFile: bundlePath).data(using: .utf8) {
                return jsonData
            }
        } catch {
            print(error)
        }
        return nil
    }
    
    private func parse(jsonData: Data) {
        do {
            let decodedData = try JSONDecoder().decode(MethodList.self,
                                                       from: jsonData)
            coffeeInfo = decodedData.methods.first(where: {$0.name == selectedCoffeeMethod?.name})
            guard let coffeeInfo = coffeeInfo else {
                return
            }

            brewMethodDesc.text = coffeeInfo.desc
        } catch {
            print("decode error \(error)")
        }
    }
    @objc private func makeThisCoffeeButtonTapped() {
        print("siema")
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "preapreCoffeeVc") as! PreparingForCoffeeVC
        vc.hidesBottomBarWhenPushed = true
        vc.coffeeToPrepare = selectedCoffeeMethod
        vc.coffeeInfo = coffeeInfo
        self.navigationController?.pushViewController(vc, animated: true)
        
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
                                            y: view.bottom-80,
                                      width: view.frame.size.width-20,
                                      height: 50)
        makeThisCoffeeButton.center.x = self.view.center.x
        
    }
}
