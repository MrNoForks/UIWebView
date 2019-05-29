//
//  SimpleProgrammaticVC.swift
//  UIWebView
//
//  Created by boppo on 4/1/19.
//  Copyright © 2019 boppo. All rights reserved.
//

import UIKit
import WebKit
class SimpleProgrammaticVC: UIViewController,WKUIDelegate {
    var webView : WKWebView!

    
    override func loadView() {
        webView = WKWebView()
        view = webView
    }
    override func viewDidLoad() {
        webView.load(URLRequest(url: URL(string: "https://www.google.com")!))
    }
    
    
}
