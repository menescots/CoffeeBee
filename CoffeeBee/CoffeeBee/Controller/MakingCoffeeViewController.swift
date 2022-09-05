//
//  MakingCoffeeViewController.swift
//  CoffeeBee
//
//  Created by Agata Menes on 31/08/2022.
//

import UIKit

class MakingCoffeeViewController: UIViewController {
    
    private var coffees = ["frenchpress", "mokapot", "syphon"]
    var chuj = [0: UIColor.red, 1: UIColor.gray, 2: UIColor.green]
    
    private let scrollView = UIScrollView()
    private let pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.backgroundColor = UIColor(named: "BackgroundColor")
        pageControl.currentPageIndicatorTintColor = UIColor(named: "labelColor")
        return pageControl
    }()
    private let stepLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.contentMode = .topLeft
        label.textColor = UIColor(named: "labelColor")
        label.text = "testesttesttesttesttesttesttesttesttesttesttestestesttesttesttesttesttesttesttesttesttestestesttesttesttesttesttesttesttesttesttestestestttesttesttesttesttesttesttesttest "
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
        pageControl.numberOfPages = coffees.count
        pageControl.addTarget(self,
                              action: #selector(pageControlDidChange),
                              for: .valueChanged)
        nextStepButton.addTarget(self,
                                 action: #selector(nextStepButtonTapped),
                                 for: .touchUpInside)
        view.addSubview(pageControl)
        view.addSubview(scrollView)
        view.addSubview(stepLabel)
        view.addSubview(nextStepButton)
    }

    @objc private func pageControlDidChange(_ sender: UIPageControl) {
        let current = sender.currentPage
        scrollView.setContentOffset(CGPoint(x: CGFloat(current) * view.frame.size.width, y: 0),
                                    animated: true)
    }
    
    @objc private func nextStepButtonTapped(_ sender: UIButton){
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
                                 y: pageControl.bottom+10,
                                 width: view.frame.size.width-20,
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
//    @IBAction func changePage(_ sender: Any) {
//        let x = CGFloat(pageControl.currentPage) * scrollView.frame.size.width
//                scrollView.setContentOffset(CGPoint(x:x, y:0), animated: true)
//    }
//    @IBAction func nextStepButton(_ sender: Any) {
//        if scrollView.contentOffset.x < self.view.bounds.width * CGFloat(coffees.count - 1) {
//                scrollView.contentOffset.x +=  self.view.bounds.width
//            }
//    }
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
}

extension MakingCoffeeViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        pageControl.currentPage = Int(scrollView.contentOffset.x / scrollView.frame.size.width)
    }
}
