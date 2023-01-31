//
//  BookMarkedNewsViewController.swift
//  NewApp
//
//  Created by Shubham Handa on 19/12/22.
//

import UIKit
import RealmSwift

class BookMarkedNewsViewController: UIViewController {
    
    @IBOutlet weak var bookMarkedNewsTV: UITableView!
    
    private var articles: [ArticleDBModel] = []
    private let articleDataManager = ArticleDataManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
}


private extension BookMarkedNewsViewController {
    
    func setup() {
        setupUI()
        addNotificationObserver()
        setArticles(articleDataManager.getAllNewsArticle())
    }
    
    func setupUI() {
        setupTableView()
    }
    
    func addNotificationObserver() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(getNewsArticles),
                                               name: Notification.Name("dataAdd"),
                                               object: nil)
    }
    
    func setArticles(_ articles: [ArticleDBModel]) {
        self.articles = articles
        reloadTableView()
    }

    @objc func getNewsArticles() {
        setArticles(articleDataManager.getAllNewsArticle())
       
    }
    
    func setupTableView() {
        bookMarkedNewsTV.delegate = self
        bookMarkedNewsTV.dataSource = self
        bookMarkedNewsTV.register(SavedNewsTableViewCell.getNib(), forCellReuseIdentifier: SavedNewsTableViewCell.nibName)
    }
    
    func reloadTableView(){
        DispatchQueue.main.async {
            self.bookMarkedNewsTV.reloadData()
        }
    }
}

extension BookMarkedNewsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        articles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = bookMarkedNewsTV.dequeueReusableCell(withIdentifier: SavedNewsTableViewCell.nibName, for: indexPath) as? SavedNewsTableViewCell else {return UITableViewCell()}
        
        cell.delegate = self
        cell.setUpData(articles[indexPath.row], index: indexPath.row)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
    }
    
}

extension BookMarkedNewsViewController: SavedNewsTableViewDelegate {
    
    
    func didTapOnDeleteButton(index: Int) {
        articleDataManager.deleteSpecificNewsArticle(articles[index])
        setArticles(articleDataManager.getAllNewsArticle())
    }
}

