//
//  WebViewVC.swift
//  UIWebView
//
//  Created by boppo on 3/26/19.
//  Copyright © 2019 boppo. All rights reserved.
//

//https://www.hackingwithswift.com/articles/112/the-ultimate-guide-to-wkwebview


import UIKit
import WebKit
class WebViewVC: UIViewController,WKNavigationDelegate,UIScrollViewDelegate {
    
    
    
    
    @IBOutlet weak var webView : WKWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        webView.scrollView.delegate = self
        webView.navigationDelegate = self
        loadHtmlWithForcefulUnwrapping()
        
        // MARK:- Custom User agent lets your web servers identify the type of web browser that is accessing a page.
        //Note: There's nothing stopping you from changing the user agent when accessing other resources, but keep in mind that some sites might read the user agent string and get confused if it doesn't match what they expect.
      //  webView.customUserAgent = "My App"
        
    }
    func scrollViewWillBeginZooming(_ scrollView: UIScrollView, with view: UIView?) {
        scrollView.pinchGestureRecognizer?.isEnabled = false
        scrollView.panGestureRecognizer.isEnabled = false
    }
    
    
    // MARK:- Restricting webPage to certain URL only
    //    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
    //        if let host = navigationAction.request.url?.host{
    //            print(host)
    //            if host == "www.google.com"{
    //                decisionHandler(.allow)
    //                return
    //            }
    //        }
    //        decisionHandler(.cancel)
    //    }
    
    
    //MARK:- Opening WebView in another APP i.e. browser
    //    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
    //        if let url = navigationAction.request.url{
    //            if url.host == "www.google.com"{
    //                //used to check if there is an app to open URL
    //                //print(UIApplication.shared.canOpenURL(url))
    //                UIApplication.shared.open(url, options: [:], completionHandler: nil)
    //                decisionHandler(.cancel)
    //                return
    //            }
    //
    //        }
    //        decisionHandler(.allow)
    //    }
    
    func loadHtmlWithForcefulUnwrapping(){
        //MARK:- Loading url without if let
       // let myURL = URL(string: "https://www.google.com")
        let myURL = URL(string: "http://stage.cubmcpaws.com/quiz?code=9087")
        
        let myRequest = URLRequest(url: myURL!)
        
        webView.load(myRequest)
    }
    
    func loadWithSafelyUnwraping(){
        //MARK:- Loading url using If let
        if let url = URL(string: "https://www.apple.com") {
            let request = URLRequest(url: url)
            webView.load(request)
        }
    }
    
    
    
    func loadViaExtension(){
        // MARK:- Loading url using Extension
        webView.load("https://www.apple.com")
    }
    
    
    func loadLocalFile(){
        // MARK:- Loading local File
        if let url = Bundle.main.url(forResource: "index", withExtension: "html"){
            webView.loadFileURL(url, allowingReadAccessTo: url.deletingLastPathComponent())
        }
        //That url.deletingLastPathComponent() part tells WebKit it can read from the directory that contains help.html – that’s a good place to put any assets such as images or CSS.
    }
    
    func loadHtmlFromString(){
        //MARK:- Loading html by string
        let html = """
                            <html>
                            <body>
                            <h1>hello world</h1>
                            </body>
                            </html>
                            """
        webView.loadHTMLString(html, baseURL: nil)
        //Note the baseURL parameter to loadHTMLString(). If you are referencing assets in your bundle such as images or CSS, you should specify Bundle.main.resourceURL there so they can be loaded. For example:
        
        //webView.loadHTMLString(html, baseURL: Bundle.main.resourceURL)
        
    }
    
}

extension WKWebView
{
    func load(_ urlString : String){
        if let url = URL(string: urlString){
            let request = URLRequest(url : url)
            load(request)
        }
    }
  
    
}
