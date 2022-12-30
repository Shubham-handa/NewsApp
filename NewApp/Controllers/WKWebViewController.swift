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

        // Do any additional setup after loading the view.
        guard let url = URL(string: "https://hypebeast.com/2022/12/one-piecve-odyssey-game-trailer-watch") else {return}
        webView.load(URLRequest(url: url))
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
