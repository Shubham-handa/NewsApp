//
//  ArticleDataRepository.swift
//  NewApp
//
//  Created by Shubham Handa on 26/12/22.
//

import Foundation
import RealmSwift

protocol ArticleRepository {
    func save(article: Article)
    func get() -> [ArticleDBModel]
    func delete(deleteArticle: ArticleDBModel)
}

class ArticleDataRepository: ArticleRepository {

    let realm = try! Realm()
    
    func save(article: Article) {
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
    
    func get() -> [ArticleDBModel] {
        var articles: [ArticleDBModel] = []
        let dbArticles = realm.objects(ArticleDBModel.self)
        for article in dbArticles {
            articles.append(article)
        }
        return articles
    }
    
    func delete(deleteArticle: ArticleDBModel) {
        realm.beginWrite()
        realm.delete(deleteArticle)
        do{
            try realm.commitWrite()
        }catch let error {
            debugPrint(error)
        }
    }    
}
