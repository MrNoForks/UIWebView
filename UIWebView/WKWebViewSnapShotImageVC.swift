//
//  WKWebViewSnapShotImageVC.swift
//  UIWebView
//
//  Created by boppo on 3/27/19.
//  Copyright © 2019 boppo. All rights reserved.
//
//Snapshot part of the page

//Although you can use the regular drawHierarchy() method for converting a view to an image, WebKit comes with its own takeSnapshot() method that lets you crop and size the image as needed.

//For example, this will produce a 150x50 image from the top-left of the web view:
//If you don’t want a cropped image - i.e. you want the whole thing – just use nil instead of config.


import UIKit
import WebKit
class WKWebViewSnapShotImageVC: UIViewController {

    @IBOutlet weak var webView : WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let config = WKSnapshotConfiguration()
        config.rect = CGRect(x: 0, y: 0, width: 150, height: 50)
        
        webView.takeSnapshot(with: config) { (image, error) in
            if let image = image{
                print(image.size)
            }
        }
        
        if let url = Bundle.main.url(forResource: "indexAlert", withExtension: "html"){
            webView.loadFileURL(url, allowingReadAccessTo: url.deletingLastPathComponent())
        }
    }
    


}
