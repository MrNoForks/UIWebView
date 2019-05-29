//
//  WKWebViewObserverVC.swift
//  UIWebView
//
//  Created by boppo on 3/26/19.
//  Copyright © 2019 boppo. All rights reserved.

// must read
// https://medium.com/@ericamillado/playing-with-key-value-observing-kvo-swift3-146da9c070a6
import UIKit
import WebKit
class WKWebViewObserverVC: UIViewController {
    
    @IBOutlet weak var webView : WKWebView!
    
    // #keyPath(WKWebView.estimatedProgress) or "estimatedProgress"
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //MARK:- Setting observer for estimated Progress
        webView.addObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress), options: .new, context: nil)
        
        //MARK:- Setting observer for title
        webView.addObserver(self, forKeyPath: #keyPath(WKWebView.title), options: .new, context: nil)
        
        
        webView.load("https://www.google.com")

    }
    

    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "estimatedProgress"{
            print("Loaded \(self.webView.estimatedProgress*100)%")
        }
        if keyPath == #keyPath(WKWebView.title){
            if let title = webView.title{
            print("title is \(title)")
            }
        }
       // listOfSitesVisitedByUsers()
    }
    
    // MARK:- to get list of sites visited by user
    func listOfSitesVisitedByUsers(){
        for page in webView.backForwardList.backList{
            print("User visited \(page.url.absoluteString)")
        }
    }
    
    
    
    // I need to remove this observer since the web view is fully loaded and I no longer need to observe its estimated progress. Each observer needs to be individually removed and if not removed, it could lead to a memory leaks!
    

    deinit {
        self.webView.removeObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress), context: nil)
        self.webView.removeObserver(self, forKeyPath: #keyPath(WKWebView.title), context: nil)
    }
}
