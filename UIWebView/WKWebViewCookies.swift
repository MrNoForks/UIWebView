//
//  WKWebViewCookies.swift
//  UIWebView
//
//  Created by boppo on 3/26/19.
//  Copyright © 2019 boppo. All rights reserved.
//


//couldnt check if its working
import UIKit
import WebKit

class WKWebViewCookies: UIViewController,WKNavigationDelegate {

    @IBOutlet weak var webView : WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        webView.load("https://www.google.com")
        
    }

    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        webView.configuration.websiteDataStore.httpCookieStore.getAllCookies { (cookies) in
            for cookie in cookies{
                if cookie.name == "authenication"{
                    webView.configuration.websiteDataStore.httpCookieStore.delete(cookie, completionHandler: nil)
                    
                }
                else{
                    print("\(cookie.name) is set to \(cookie.value)")
                }
            }
            print("I am in")
        }
    }
}
