//
//  ViewController.swift
//  NewApp
//
//  Created by Shubham Handa on 16/12/22.
//

import UIKit
import WebKit
import RealmSwift

class ViewController: UIViewController{
    
    
    
    @IBOutlet weak var newsDisplayTableView: UITableView!
    let realm = try! Realm()
//    let webView = WKWebView()
    var articlesData: [Article] = []
    var articles = [[Article]]()

    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
        registerCells()
        //
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
        fetchBySpecific("bitcoin")
        fetch()
    }
    
    func fetchBySpecific(_ nameOfThing: String) {
        Fetcher.shared.fetchBySpecificThing(nameOfThing){ articlesData in
            self.articles.append(articlesData)
            debugPrint(self.articles[0].count)
            //debugPrint(self.articles[0][0].title)
            self.reloadTableViewData()
        }
    }
    
    func fetch(){
        Fetcher.shared.fetchTopHeadlinesParticularCountry { articlesData in
            self.articlesData = articlesData
            self.articles.append(self.articlesData)
            self.reloadTableViewData()
        }
    }
    
    func reloadTableViewData() {
        DispatchQueue.main.async {
            self.newsDisplayTableView.reloadData()
        }
        
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
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
        return articles.count
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let urlString = self.articlesData[indexPath.row].url
        let url = URL(string: urlString)
        
        if let url = url {
            let webViewVC = WebViewController(url: url)
            self.navigationController?.pushViewController(webViewVC, animated: true)
        }
        
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

// MARK: Delegate Protocol


extension ViewController: TopHeadlinesTVDelegate {
    func sendIndexPathOfTappedNews(_ section: Int, _ row: Int) {
        debugPrint("Section \(section) row \(row)")
    }
}

