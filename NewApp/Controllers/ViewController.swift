//
//  ViewController.swift
//  NewApp
//
//  Created by Shubham Handa on 16/12/22.
//

import UIKit
import WebKit

class ViewController: UIViewController {
    
    @IBOutlet weak var newsDisplayTableView: UITableView!
    let webView = WKWebView()
    var articlesData: [Article] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
        registerCells()
        //
        registerWebViewDelegate()
    }
    
    func registerCells() {
        newsDisplayTableView.delegate = self
        newsDisplayTableView.dataSource = self
        newsDisplayTableView.register(TopHeadlinesTableViewCell.getNib(), forCellReuseIdentifier: TopHeadlinesTableViewCell.nibName)
        newsDisplayTableView.register(CategoryWiseTableViewCell.getNib(), forCellReuseIdentifier: CategoryWiseTableViewCell.nibName)
    }
    
    func setUp(){
        fetch()
    }
    
    func fetch(){
        Fetcher.shared.fetchTopHeadlinesParticularCountry { articlesData in
            self.articlesData = articlesData
            self.reloadTableViewData()
        }
    }
    
    func reloadTableViewData() {
        DispatchQueue.main.async {
            self.newsDisplayTableView.reloadData()
        }
        
    }
    
    


//    @IBAction func goToSomeOtherView(_ sender: UIButton) {
//
//        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: ViewController.randomViewControllerStoryBoardId ) as? RandomViewController else { return }
//
//        self.navigationController?.pushViewController(vc, animated: true)
//    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        var count = 0
        switch section {
        case 0: count = 1
        case 1: count = self.articlesData.count
        default:
            count = 0
        }
        //debugPrint(count)
       return count
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        var height: CGFloat = 400
        if indexPath.section == 0{
            height = 400
        }
        return height

    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //debugPrint(indexPath.section)
        switch indexPath.section {
        case 0:
            guard let bitcoinCell = newsDisplayTableView.dequeueReusableCell(withIdentifier: CategoryWiseTableViewCell.nibName, for: indexPath) as? CategoryWiseTableViewCell else {return UITableViewCell()}
            
            //BitcoinCell.setUpData(articlesData[indexPath.row])
            
            return bitcoinCell
        case 1:
            guard let topHeadlineCell = newsDisplayTableView.dequeueReusableCell(withIdentifier: TopHeadlinesTableViewCell.nibName, for: indexPath) as? TopHeadlinesTableViewCell else {return UITableViewCell()}
            
            topHeadlineCell.setUpData(articlesData[indexPath.row])
            
            return topHeadlineCell
        default:
            return UITableViewCell()
        }
        
       
    }

    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        var title = ""
        switch section {
        case 0: title = "Top Headlines"
        case 1: title = "Bitcoin"
        default:
            title = "Everything"
        }
       return title
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    
}


extension ViewController: WKNavigationDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        //openFullDetailOfNews(articlesData[indexPath.row].url)
    }
    
   
    
    func registerWebViewDelegate() {
        webView.allowsBackForwardNavigationGestures = true
        webView.navigationDelegate = self
    }
    
    func openFullDetailOfNews(_ url: String) {
        guard let url = URL(string: url) else {return}
        webView.load(URLRequest(url: url))
//        DispatchQueue.main.sync {
//            self.webView.load(URLRequest(url: url))
//        }
        
    }
    

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        webView.frame = view.bounds
    }
    
    
    
}

