//
//  WKWebViewCustomAlertsVC.swift
//  UIWebView
//
//  Created by boppo on 3/27/19.
//  Copyright © 2019 boppo. All rights reserved.
//

//WKWebView is a bit like having one lone tab in the iOS Safari app, which means the user can’t open and close new windows to browse multiple pages, and it won’t even show alerts or confirmation requests triggered by JavaScript.
//
//Fortunately, you can change that using the WKUIDelegate protocol: set an object to be the UI delegate of your web view and you can show custom alerts, manage your own tabs, and more.
//
//First, make some object such as your view controller conform to it:



import UIKit
import WebKit

class WKWebViewCustomAlertsVC: UIViewController,WKUIDelegate {

    @IBOutlet weak var webView : WKWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        webView.uiDelegate = self
        
        if let url = Bundle.main.url(forResource: "indexAlert", withExtension: "html"){
            webView.loadFileURL(url, allowingReadAccessTo: url.deletingLastPathComponent())
        }
    }
    
    //Finally, implement as many of the optional methods of WKUIDelegate as you want. For example, you can make WKWebView show a custom alert controller when any web page uses the alert() JavaScript function:

    
    func webView(_ webView: WKWebView, runJavaScriptAlertPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping () -> Void) {
        let ac = UIAlertController(title: "Hey , Listen", message: message, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        ac.addAction(UIAlertAction(title: "PrintOnConsole", style: .default, handler: { (_) in
            print("I am printed on console")
        }))
        ac.addAction(UIAlertAction(title: "Back", style: .default, handler: { (_) in
            self.navigationController?.popViewController(animated: true)
           // self.navigationController?.popToViewController((self.navigationController?.viewControllers[0])!, animated: true)
        }))
        present(ac, animated: true, completion: nil)
        completionHandler()
    }
    
    

}



//There’s also runJavaScriptConfirmPanelWithMessage for showing confirm and deny UI, runJavaScriptTextInputPanelWithPrompt for requesting user text input, and so on.

//Note: You must call the completion handler when you’re finished. JavaScript’s alerts are blocking, which means JavaScript execution will not continue until the alert finishes. As a result, WebKit will complain if you don’t let it know when you’re done.
