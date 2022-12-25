//
//  ViewController.swift
//  NewApp
//
//  Created by Shubham Handa on 16/12/22.
//

import UIKit
import WebKit
import RealmSwift

class ViewController: UIViewController {
    
    @IBOutlet weak var newsDisplayTableView: UITableView!
    let realm = try! Realm()
    let webView = WKWebView()
    var articlesData: [Article] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
        registerCells()
        //
        registerWebViewDelegate()
        
        
        self.navigationItem.titleView = imageViewTitle()
    }
    
    
    func imageViewTitle() -> UIImageView {
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 50, height: 40))
        imageView.contentMode = .scaleAspectFill
        let image = UIImage(named: "bbcNewsIcon1")
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
       return count
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        var height: CGFloat = 370
        if indexPath.section == 0{
            height = 400
        }
        return height
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            guard let bitcoinCell = newsDisplayTableView.dequeueReusableCell(withIdentifier: CategoryWiseTableViewCell.nibName, for: indexPath) as? CategoryWiseTableViewCell else {return UITableViewCell()}
            return bitcoinCell
        case 1:
            guard let topHeadlineCell = newsDisplayTableView.dequeueReusableCell(withIdentifier: TopHeadlinesTableViewCell.nibName, for: indexPath) as? TopHeadlinesTableViewCell else {return UITableViewCell()}
            topHeadlineCell.setUpData(articlesData[indexPath.row])
            return topHeadlineCell
        default:
            return UITableViewCell()
        }
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
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        //openFullDetailOfNews(articlesData[indexPath.row].url)
    }
    
}

// MARK: RealmSwift functions
extension ViewController {
    func saveNews(_ article: Article) {
        //Source Object
        let newSource = SourceDBModel()
        if let id = article.source?.id, let name = article.source?.name {
            newSource.id = id
            newSource.name = name
        }

        //Article Object
        let newArticle = ArticleDBModel()
        newArticle.author = article.author
        newArticle.source = newSource
        newArticle.title = article.title
        newArticle.newsDescription = article.description
        newArticle.url = article.url
        newArticle.urlToImage = article.urlToImage
        newArticle.publishedAt = article.publishedAt
        newArticle.content = article.content
        
        //Saving operation
        realm.beginWrite()
        realm.add(newArticle)
        do{
            try realm.commitWrite()
        }catch let error {
            debugPrint(error)
        }
        
    }
    
    
}

// MARK: WebView

extension ViewController: WKNavigationDelegate {
    
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

