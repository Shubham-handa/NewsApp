//
//  WKWebViewController.swift
//  NewApp
//
//  Created by Shubham Handa on 30/12/22.
//

import UIKit
import WebKit

class WKWebViewController: UIViewController {

    @IBOutlet weak var webView: WKWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Boring News"
        self.tabBarController?.tabBar.isHidden = true
        // Do any additional setup after loading the view.
        guard let url = URL(string: "https://hypebeast.com/2022/12/one-piecve-odyssey-game-trailer-watch") else {return}
        webView.load(URLRequest(url: url))
    }
}
