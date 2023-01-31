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
    
    private var url: String?
    static let storyboardID = "CustomWebViewViewController"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let url = url else { return }
        loadWebPage(url)
    }
    
    func setURL(_ url: String?) {
        self.url = url
    }
    
    
    private func loadWebPage(_ url: String) {
        guard let url = URL(string: url) else { return }
        webView.load(URLRequest(url: url))
    }
}
