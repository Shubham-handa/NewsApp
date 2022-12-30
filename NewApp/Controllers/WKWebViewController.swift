//
//  RandomViewController.swift
//  NewApp
//
//  Created by Shubham Handa on 16/12/22.
//

import UIKit
import WebKit

class WKWebViewController: UIViewController {

    @IBOutlet weak var webView: WKWebView!
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let url = URL(string: "https://www.apple.com") else {
            return
        }
    
        debugPrint(url)
        webView.load(URLRequest(url: url))
       
    }

}
