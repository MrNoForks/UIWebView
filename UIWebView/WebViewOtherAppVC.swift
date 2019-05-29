//
//  WebViewOtherAppVC.swift
//  UIWebView
//
//  Created by boppo on 3/26/19.
//  Copyright © 2019 boppo. All rights reserved.
//

import UIKit
import WebKit
class WebViewOtherAppVC: UIViewController,WKNavigationDelegate {
    
    @IBOutlet weak var webView: WKWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        webView.navigationDelegate = self
        webView.load("https://www.google.com")
    }
    
    //MARK:- Opening WebView in another APP i.e. browser
        func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
            if let url = navigationAction.request.url{
                if url.host == "www.google.com"{
                    //used to check if there is an app to open URL
                    //print(UIApplication.shared.canOpenURL(url))
                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
                    decisionHandler(.cancel)
                    return
                }
    
            }
            decisionHandler(.allow)
        }
}
