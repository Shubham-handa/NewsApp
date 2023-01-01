//
//  ViewController.swift
//  NewApp
//
//  Created by Shubham Handa on 16/12/22.
//

import UIKit
import RealmSwift

class ViewController: UIViewController{
    @IBOutlet weak var newsDisplayTableView: UITableView!

    private let articleDataManager: ArticleDataManager = ArticleDataManager()
    var articlesData: [Article] = []
    var articles = [[Article]]()
    var addBitcoinData = false

    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
        registerCells()
        //
        self.navigationItem.titleView = imageViewTitle()
        
    }
    
    func imageViewTitle() -> UIImageView {
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 30, height: 40))
        imageView.contentMode = .scaleAspectFit
        let image = UIImage(named: "newsIcon2")
        imageView.image = image
        navigationItem.titleView = imageView
        return imageView
    }
    
    func registerCells() {
        newsDisplayTableView.delegate = self
        newsDisplayTableView.dataSource = self
        newsDisplayTableView.register(TopHeadlinesTableViewCell.getNib(), forCellReuseIdentifier: TopHeadlinesTableViewCell.nibName)
        newsDisplayTableView.register(CategoryWiseTableViewCell.getNib(), forCellReuseIdentifier: CategoryWiseTableViewCell.nibName)
        newsDisplayTableView.register(CustomHeaderView.getNib(), forHeaderFooterViewReuseIdentifier: CustomHeaderView.nibName)
        
    }
    
    func setUp(){
        
        let dispatchGroup = DispatchGroup()
        
        let fetchNewsBySpecificThingBO = BlockOperation()
        fetchNewsBySpecificThingBO.addExecutionBlock {
            dispatchGroup.enter()
            Fetcher.shared.fetchBySpecificThing("bitcoin"){ articlesData in
                self.articles.append(articlesData)
                dispatchGroup.leave()
            }
            dispatchGroup.wait()
        }
        
        let fetchTopHeadlinesBO = BlockOperation()
        fetchTopHeadlinesBO.addExecutionBlock {
            Fetcher.shared.fetchTopHeadlinesParticularCountry { articlesData in
                        self.articles.append(articlesData)
                self.reloadTableViewData()
            }
        }
        
        fetchTopHeadlinesBO.addDependency(fetchNewsBySpecificThingBO)
        
        let operationQueue = OperationQueue()
        operationQueue.addOperation(fetchTopHeadlinesBO)
        operationQueue.addOperation(fetchNewsBySpecificThingBO)
        
    }
    
    func reloadTableViewData() {
        DispatchQueue.main.async {
            self.newsDisplayTableView.reloadData()
        }
        
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return articles.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var count = 0
        switch section {
        case 0: count = 1
        case 1: count = self.articles[section].count
        default:
            count = 0
        }
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            guard let bitcoinCell = newsDisplayTableView.dequeueReusableCell(withIdentifier: CategoryWiseTableViewCell.nibName, for: indexPath) as? CategoryWiseTableViewCell else {return UITableViewCell()}
            
            bitcoinCell.setUpData(article: articles[indexPath.section])
            return bitcoinCell
        case 1:
            guard let topHeadlineCell = newsDisplayTableView.dequeueReusableCell(withIdentifier: TopHeadlinesTableViewCell.nibName, for: indexPath) as? TopHeadlinesTableViewCell else {return UITableViewCell()}
            topHeadlineCell.delegate = self
            topHeadlineCell.setUpData(articles[indexPath.section][indexPath.row], indexPath)
            return topHeadlineCell
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        tableView.deselectRow(at: indexPath, animated: true)
//        let urlString = self.articlesData[indexPath.row].url
//        let url = URL(string: urlString)
        
        //guard let randomVC = RandomViewController els
        let urlToLoadInWebView = articles[indexPath.section][indexPath.row].url
        
        if !urlToLoadInWebView.isEmpty {
            guard let webViewController = storyboard?.instantiateViewController(withIdentifier: "WKWebViewController") as? WKWebViewController else {return}
            webViewController.url = urlToLoadInWebView
            self.navigationController?.pushViewController(webViewController, animated: true)
        }
       
        
        
        
        
//        if let url = url {
//            //let webViewVC = WebViewController(url: url)
//            guard let Ran
//            self.navigationController?.pushViewController(webViewVC, animated: true)
//        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let header = newsDisplayTableView.dequeueReusableHeaderFooterView(withIdentifier: CustomHeaderView.nibName) as? CustomHeaderView else {return UIView()}
        switch section {
        case 0: header.headerLabel.text = "Bitcoin"
        case 1: header.headerLabel.text = "Top Headlines"
        default:
            header.headerLabel.text = "Everything"
        }
        return header
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        var height: CGFloat = 370
        if indexPath.section == 0{
            height = 350
        }
        return height
    }
}

// MARK: Delegate Protocol
extension ViewController: TopHeadlinesTVDelegate {
    
    func sendIndexPathOfTappedNewsForSave(_ section: Int, _ row: Int) {
        debugPrint("Section \(section) row \(row)")
        let article = self.articles[section][row]
        articleDataManager.saveNewsArticle(article)
        NotificationCenter.default.post(name: Notification.Name("dataAdd"), object: nil)
    }
}

