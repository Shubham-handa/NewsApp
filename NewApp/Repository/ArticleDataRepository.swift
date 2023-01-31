//
//  ArticleDataRepository.swift
//  NewApp
//
//  Created by Shubham Handa on 26/12/22.
//

import Foundation
import RealmSwift


protocol ArticleRepository: AnyObject {
    func save(article: Article)
    func get() -> [ArticleDBModel]
    func delete(deleteArticle: ArticleDBModel)
}

class ArticleDataRepository: ArticleRepository {
    private let realm = try? Realm()
    
    func save(article: Article) {
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
        newArticle.isBookmarked = article.isBookmarked

        //Saving operation
        realm?.beginWrite()
        realm?.add(newArticle)
        try? realm?.commitWrite()
    }
    
    func get() -> [ArticleDBModel] {
        guard let realm = realm else { return [] }
        return Array(realm.objects(ArticleDBModel.self))
    }
    
    func delete(deleteArticle: ArticleDBModel) {
        realm?.beginWrite()
        realm?.delete(deleteArticle)
        try? realm?.commitWrite()
    }
}
