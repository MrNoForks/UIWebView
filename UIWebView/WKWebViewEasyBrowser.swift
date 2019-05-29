//
//  WKWebViewEasyBrowser.swift
//  UIWebView
//
//  Created by boppo on 3/29/19.
//  Copyright © 2019 boppo. All rights reserved.
//

import UIKit
import WebKit

class WKWebViewEasyBrowser: UIViewController,WKNavigationDelegate {
    var webView : WKWebView!
    
    var progressView : UIProgressView!
    
    var websites = ["google.com","apple.com"]
    
    override func loadView() {
        webView = WKWebView()
        webView.navigationDelegate = self
        view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Custom Navigation Button
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Open", style: .plain, target: self, action: #selector(openTapped))
        
        //Bottom UI Bar button //A button specialized for placement on a toolbar or tab bar.
        let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        
        let refresh = UIBarButtonItem(barButtonSystemItem: .refresh, target: webView, action: #selector(webView.reload))
        
        
        progressView = UIProgressView(progressViewStyle: .default)
        progressView.sizeToFit()
      //  progressView.progressImage = #imageLiteral(resourceName: "earth.jpg")
        
        
        // wrapping a UIView in UIBarButton
        let progressButton = UIBarButtonItem(customView: progressView)
        
        //webView.goBack
        let back = UIBarButtonItem(image: #imageLiteral(resourceName: "back").withRenderingMode(.alwaysOriginal), style: .plain, target: webView, action: #selector(webView.goBack))
        
        //webView.goForward
         let forward = UIBarButtonItem(image: #imageLiteral(resourceName: "forward").withRenderingMode(.alwaysOriginal), style: .plain, target: webView, action: #selector(webView.goForward))
        
        
    
        //The toolbar items associated with the view controller.
        toolbarItems = [progressButton,spacer,back,forward,refresh]
        
        //navigationController?.toolbar.barStyle = .blackTranslucent
        
        //navigationController?.isNavigationBarHidden = true
        
        // to make toolbar visible
        navigationController?.isToolbarHidden = false
        
        // navigationbar transparent
//        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
//        navigationController?.navigationBar.shadowImage = UIImage()
//        navigationController?.navigationBar.isTranslucent = true
        
        
        //toolbar transparent
//        navigationController?.toolbar.setBackgroundImage(UIImage(), forToolbarPosition: .any, barMetrics: .default)
//        navigationController?.toolbar.setShadowImage(UIImage(), forToolbarPosition: .any)
//        navigationController?.toolbar.isTranslucent = true
        
        
        //KVO to observe the change in value
        webView.addObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress), options: .new, context: nil)
        
        let url = URL(string: "https://www.\(websites[0])")!
        webView.load(URLRequest(url: url))
        webView.allowsBackForwardNavigationGestures = true
    }
    
    
    
    @objc func openTapped(){
        let ac = UIAlertController(title: "Open Page", message: nil, preferredStyle: .actionSheet)
        
        for website in websites{
            ac.addAction(UIAlertAction(title: website, style: .default, handler: openPage))
        }
        ac.addAction(UIAlertAction(title: "cancel", style: .cancel))
        ac.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(ac,animated: true)
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "estimatedProgress"{
            progressView.progress = Float(webView.estimatedProgress)
        }
    }
    
    
    func openPage(action : UIAlertAction)
    {
        guard let actionTitle = action.title else {return}
        guard let url = URL(string: "https://" + actionTitle) else { return }
        webView.load(URLRequest(url: url))
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        title = webView.title
    }
    
    // to restrict sites to sites specified according to decision
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        let url = navigationAction.request.url
        
        if let host = url?.host{
            for website in websites{
                if host.contains(website){
                    decisionHandler(.allow)
                    return
                }
            }
        }
        let alert = UIAlertController(title: "Blocked", message: "Website is Restricted", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(alert,animated: true)
        decisionHandler(.cancel)
    }
    

}
