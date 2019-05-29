//
//  WebViewWithWebsitreRestrictionVC.swift
//  UIWebView
//
//  Created by boppo on 3/26/19.
//  Copyright © 2019 boppo. All rights reserved.
//

import UIKit
import WebKit

class WebViewWithWebsitreRestrictionVC: UIViewController,WKNavigationDelegate {
    
    
    @IBOutlet weak var webView: WKWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        webView.navigationDelegate = self
        webView.load("https://www.google.com")
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        if let host = navigationAction.request.url?.host{
            if host == "www.google.com"{
                decisionHandler(.allow)
                return
            }
        }
        decisionHandler(.cancel)
    }
    
}
