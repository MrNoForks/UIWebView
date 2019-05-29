//
//  WKWebViewJavaScriptVC.swift
//  UIWebView
//
//  Created by boppo on 3/26/19.
//  Copyright © 2019 boppo. All rights reserved.

// Injecting JavaScript into a page
import UIKit
import WebKit
class WKWebViewJavaScriptVC: UIViewController ,WKNavigationDelegate{
    
    @IBOutlet weak var webView : WKWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        webView.navigationDelegate = self
        
        if let url = Bundle.main.url(forResource: "index", withExtension: "html"){
            webView.loadFileURL(url, allowingReadAccessTo: url.deletingLastPathComponent())
        }

    }
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
//        let jsString = """
//document.getElementById("username").innerText
//"""
                let jsString = """
        document.getElementById("demo").innerHTML
        """

        webView.evaluateJavaScript(jsString) { (result, error) in
            if let result = result{
                print(result)
            }
            else{
                print(error)
            }
        }
    }
    
    
}
