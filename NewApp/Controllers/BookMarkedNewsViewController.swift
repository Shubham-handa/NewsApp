//
//  BookMarkedNewsViewController.swift
//  NewApp
//
//  Created by Shubham Handa on 19/12/22.
//

import UIKit
import RealmSwift

class BookMarkedNewsViewController: UIViewController {
    var articles: [ArticleDBModel] = []
    @IBOutlet weak var bookMarkedNewsTV: UITableView!
    private let articleDataManager: ArticleDataManager = ArticleDataManager()
    var didTapOnSave = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getData()
        NotificationCenter.default.addObserver(self, selector: #selector(getNewsArticles), name: Notification.Name("dataAdd"), object: nil)
        registerCells()
    }
    
    @objc func getNewsArticles() {
        getData()
    }
    
    func getData() {
        articles = articleDataManager.getAllNewsArticle()
        bookMarkedNewsTV.reloadData()
    }
    
    func registerCells(){
        bookMarkedNewsTV.delegate = self
        bookMarkedNewsTV.dataSource = self
        bookMarkedNewsTV.register(SavedNewsTableViewCell.getNib(), forCellReuseIdentifier: SavedNewsTableViewCell.nibName)
    }
}

extension BookMarkedNewsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = bookMarkedNewsTV.dequeueReusableCell(withIdentifier: SavedNewsTableViewCell.nibName, for: indexPath) as? SavedNewsTableViewCell else {return UITableViewCell()}
        if articles.count != 0{
            cell.setUpData(articles[indexPath.row])
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
    }
}

