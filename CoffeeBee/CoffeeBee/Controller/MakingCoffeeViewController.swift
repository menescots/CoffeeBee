//
//  MakingCoffeeViewController.swift
//  CoffeeBee
//
//  Created by Agata Menes on 31/08/2022.
//

import UIKit
import AVFoundation
import Lottie
class MakingCoffeeViewController: UIViewController {
    
    private var coffees = [String]()
    private let scrollView = UIScrollView()
    var coffeeStepInfo: Method?
    var coffeeToPrepare: CoffeeMethods?
    var waterAmount: String?
    var coffeeAmount: String?
    var WaterTemperature: String?
    private var coundDownSound: AVAudioPlayer?
    private var animationView: AnimationView?
    private var isItLastPage = false
    private weak var timer: Timer?
    private var timeLeft = 0
    
    private let dateFormatter : DateComponentsFormatter = {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.minute, .second]
        formatter.zeroFormattingBehavior = .pad
        return formatter
    }()
    
    private let pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.backgroundColor = UIColor(named: "BackgroundColor")
        pageControl.currentPageIndicatorTintColor = UIColor(named: "labelColor")
        return pageControl
    }()
    private let stepLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = UIColor(named: "labelColor")
        label.font = .systemFont(ofSize: 22, weight: .light)
        label.minimumScaleFactor = 0.5
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    private let nextStepButton: UIButton = {
        let button = UIButton()
        button.setTitle("Next", for: .normal)
        button.layer.cornerRadius = 25
        button.alpha = 0.85
        button.backgroundColor = UIColor(named: "labelColor")
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "BackgroundColor")
        scrollView.delegate = self
        pageControl.addTarget(self,
                              action: #selector(pageControlDidChange),
                              for: .valueChanged)
        nextStepButton.addTarget(self,
                                 action: #selector(nextStepButtonTapped),
                                 for: .touchUpInside)
        let coffeeInfo = coffeeStepInfo
        guard let coffeeInfo = coffeeInfo else {
            return
        }
        coffees = coffeeInfo.pictures
        pageControl.numberOfPages = coffees.count
        print(coffees)
        view.addSubview(pageControl)
        view.addSubview(scrollView)
        view.addSubview(stepLabel)
        view.addSubview(nextStepButton)
        changeStepAndNextLabel(stepIndex: 0)
        
    }

    @objc private func pageControlDidChange(_ sender: UIPageControl) {
        let current = sender.currentPage
        scrollView.setContentOffset(CGPoint(x: CGFloat(current) * view.frame.size.width, y: 0),
                                    animated: true)
    }
    
    @objc private func nextStepButtonTapped(_ sender: UIButton){
        changePageForward()
        
        if isItLastPage {
            print("last")
            removeSubviews()
            fireFinishAnimation()
            //isItLastPage = false
        } else if pageControl.currentPage == coffees.count-1 {
            print("change to finish")
            nextStepButton.setTitle("Finish", for: .normal)
            //isItLastPage = true
        } else {
            timer?.invalidate()
            timerOccurs()
        }
    }
    private func removeSubviews(){
        view.subviews.forEach({ $0.removeFromSuperview() })
    }
    private func fireFinishAnimation() {
        animationView = .init(name: "coffeeFinish")
        animationView!.frame = view.bounds
        animationView!.contentMode = .scaleAspectFit
        animationView!.loopMode = .playOnce

        animationView!.animationSpeed = 0.5
        view.addSubview(animationView!)
        animationView!.play()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
            self.dismiss(animated: true)
        }
    }
    private func changePageForward() {
        if scrollView.contentOffset.x < self.view.bounds.width * CGFloat(coffees.count-1) {
            scrollView.contentOffset.x +=  self.view.bounds.width
        }
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        pageControl.frame = CGRect(x: 10,
                                   y: scrollView.bottom+10,
                                   width: view.frame.size.width-20,
                                   height: 50)
        scrollView.frame = CGRect(x: 0,
                                  y: view.top+10,
                                  width: view.frame.size.width,
                                  height: 400)
        stepLabel.frame = CGRect(x: 0,
                                 y: pageControl.bottom+25,
                                 width: view.frame.size.width-30,
                                 height: 100)
        stepLabel.center.x = view.center.x
        nextStepButton.frame = CGRect(x: 0,
                                      y: view.bottom-80,
                                      width: view.frame.size.width-20,
                                      height: 50)
        nextStepButton.center.x = view.center.x
        if scrollView.subviews.count >= 2 {
            configureScrollView()
        }
    }

    private func configureScrollView(){
        scrollView.contentSize = CGSize(width: view.frame.size.width*CGFloat((coffees.count)),
                                        height: scrollView.frame.size.height)
        scrollView.isPagingEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
        for index in 0..<coffees.count {
            let page = UIImageView(frame: CGRect(x: CGFloat(index) * view.frame.size.width,
                                            y: 0,
                                            width: view.frame.size.width-10,
                                            height: scrollView.frame.size.height-10))
            page.image = UIImage(named: coffees[index])
            page.contentMode = .scaleAspectFit
            page.backgroundColor = UIColor(named: "BackgroundColor")
            scrollView.addSubview(page)
        }
    }
    private func changeStepAndNextLabel(stepIndex: Int){
        guard let coffeeInfo = coffeeStepInfo,
              let waterAmount = waterAmount,
              let coffeeAmount = coffeeAmount,
              let waterTemperature = WaterTemperature,
              let coffeeGrindSize = coffeeToPrepare?.grindSize else {
            return
        }
        let coffeeSteps = coffeeInfo.steps
        let stepInfo = coffeeSteps[stepIndex]
        let stepDesc = stepInfo.step
        let replacedStep = stepDesc.replacingOccurrences(of: "water_amount", with: waterAmount).replacingOccurrences(of: "coffee_amount", with: coffeeAmount).replacingOccurrences(of: "temperature", with: waterTemperature).replacingOccurrences(of: "grind_size", with: coffeeGrindSize.lowercased())
        stepLabel.text = replacedStep
    }

    private func timerOccurs(){
        guard let coffeeInfo = coffeeStepInfo else {
            return
        }
        let coffeeSteps = coffeeInfo.steps
        let stepInfo = coffeeSteps[pageControl.currentPage]
        guard let timerTime = stepInfo.timer else {
            nextStepButton.setTitle("Next", for: .normal)
            return
        }
        timeLeft = timerTime
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 1.0,
                                     repeats: true) { [self] timer in
            self.nextStepButton.setTitle(self.dateFormatter.string(from: TimeInterval(timeLeft)), for: .normal)
            if timeLeft == 0 {
                pauseTimer()
                changePageForward()
                self.nextStepButton.setTitle("Next", for: .normal)
            } else {
                timeLeft -= 1
                print(timeLeft)
            }
        }
        
    }
    private func pauseTimer() {
        if timer != nil {
           timer!.invalidate()
           timer = nil
        }
    }
}

extension MakingCoffeeViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        pageControl.currentPage = Int(scrollView.contentOffset.x / scrollView.frame.size.width)
        changeStepAndNextLabel(stepIndex: pageControl.currentPage)
        if pageControl.currentPage == coffees.count-1 {
            nextStepButton.setTitle("Finish", for: .normal)
            //isItLastPage = true
        }
        timer?.invalidate()
        timerOccurs()
    }
}
