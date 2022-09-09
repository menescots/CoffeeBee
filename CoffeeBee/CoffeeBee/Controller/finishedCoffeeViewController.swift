//
//  finishedCoffeeViewController.swift
//  CoffeeBee
//
//  Created by Agata Menes on 08/09/2022.
//

import UIKit
import Lottie

class finishedCoffeeViewController: UIViewController {
    private var animationView: AnimationView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fireFinishAnimation()

    }
    private func fireFinishAnimation() {
        animationView = .init(name: "coffeeFinish")
        animationView!.frame = view.bounds
        animationView!.contentMode = .scaleAspectFit
        animationView!.loopMode = .loop

        animationView!.animationSpeed = 0.5
        view.addSubview(animationView!)
        animationView!.play()
    }
}
