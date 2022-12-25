//
//  BookMarkedNewsViewController.swift
//  NewApp
//
//  Created by Shubham Handa on 19/12/22.
//

import UIKit
import RealmSwift

class BookMarkedNewsViewController: UIViewController {
    
    let realm = try! Realm()
    var articles: [ArticleDBModel] = []
    @IBOutlet weak var bookMarkedNewsTV: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCells()
        // Do any additional setup after loading the view.
    }
    
    func registerCells(){
        bookMarkedNewsTV.delegate = self
        bookMarkedNewsTV.dataSource = self
        bookMarkedNewsTV.register(SavedNewsTableViewCell.getNib(), forCellReuseIdentifier: SavedNewsTableViewCell.nibName)
    }
    
    
    func delete(_ deleteArticle: ArticleDBModel) {
        realm.beginWrite()
        realm.delete(deleteArticle)
        do{
            try realm.commitWrite()
        }catch let error {
            debugPrint(error)
        }
    }
    
    func render() {
        let dbArticles = realm.objects(ArticleDBModel.self)
        //self.articles = dbArticles
        
        for article in dbArticles {
            self.articles.append(article)
        }
        
//        for article in dbArticles {
//            debugPrint(article)
//
////            var source = Source()
////            if let id = article.source?.id, let name = article.source?.name {
////                source.id = id
////                source.name = name
////            }
////            var bookMarkedarticle = Article()
////            bookMarkedarticle.source = source
////            bookMarkedarticle.author = article.author
////            bookMarkedarticle.title = article.title
////            bookMarkedarticle.description = article.newsDescription
////            bookMarkedarticle.url = article.url
////            bookMarkedarticle.urlToImage = article.urlToImage
////            bookMarkedarticle.publishedAt = article.publishedAt
////            bookMarkedarticle.content = article.content
//
////            self.articles.append(bookMarkedarticle)
//
//        }
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


extension BookMarkedNewsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = bookMarkedNewsTV.dequeueReusableCell(withIdentifier: SavedNewsTableViewCell.nibName, for: indexPath) as? SavedNewsTableViewCell else {return UITableViewCell()}
        return cell
    }
    
    
}
