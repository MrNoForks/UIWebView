//
//  WKWebViewDetectingDataVC.swift
//  UIWebView
//
//  Created by boppo on 3/27/19.
//  Copyright © 2019 boppo. All rights reserved.
//
//Detecting data

import UIKit
import WebKit
class WKWebViewDetectingDataVC: UIViewController {

//
//    Web views have built-in data detector support, which means they can make things like phone numbers, calendar events, and flight numbers into tappable links.
//
//    These are all disabled so the default behavior is to render web pages as they were designed, but it’s trivial to override – just create your web view using a custom WKWebViewConfiguration object.
//
//    For example, this instructs the web view to detect all possible types of data:
    
    
    @IBOutlet weak var webView : WKWebView!
    let htmlString = """
<!DOCTYPE html>
<html>
<body>
<p id="demo">9989907745</p>
</body>
</html>
"""
    override func viewDidLoad() {
        super.viewDidLoad()
        

        webView.configuration.dataDetectorTypes = [.all]
        webView.loadHTMLString(htmlString, baseURL: nil)
        
        
        
    }
    
    
    
    
    
}
