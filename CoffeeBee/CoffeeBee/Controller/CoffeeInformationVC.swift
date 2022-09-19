//
//  CoffeeInformationVC.swift
//  CoffeeBee
//
//  Created by Agata Menes on 14/09/2022.
//
import UIKit
import WebKit

class CoffeeInformationVC: UIViewController, WKNavigationDelegate, WKUIDelegate {
    var webView: WKWebView!
    var progressView: UIProgressView!
    var websiteToLoad: String?
    
    override func loadView() {
          let webConfiguration = WKWebViewConfiguration()
          webView = WKWebView(frame: .zero, configuration: webConfiguration)
          webView.uiDelegate = self
          view = webView
      }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        navigationController?.isToolbarHidden = true
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        progressView = UIProgressView(progressViewStyle: .default)
        progressView.sizeToFit()
        let progressButton = UIBarButtonItem(customView: progressView)
        
        let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let refresh = UIBarButtonItem(barButtonSystemItem: .refresh, target: webView, action: #selector(webView.reload))
        let goBack = UIBarButtonItem(title: "Back", style: .plain, target: nil, action: #selector(webView.goBack))
        let goForward = UIBarButtonItem(title: "Forward", style: .plain, target: nil, action: #selector(webView.goForward))
         toolbarItems = [progressButton, spacer, goBack, goForward, refresh]
        navigationController?.isToolbarHidden = false
                                     
        guard let websiteToLoad = websiteToLoad else {
            return
        }
        if let url = URL(string: "https://" + websiteToLoad) {
            let request = URLRequest(url: url)
            webView.load(request)
        }
        webView.isOpaque = false
        webView.backgroundColor = UIColor(named: "BackgroundColor")
        webView.allowsBackForwardNavigationGestures = true
        webView.addObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress), options: .new, context: nil)
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        title = webView.title
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "estimatedProgress" {
            progressView.progress = Float(webView.estimatedProgress)
        }
    }
    
}

