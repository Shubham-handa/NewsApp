//
//  ArticlesApiModel.swift
//  NewApp
//
//  Created by Shubham Handa on 17/12/22.
//

import Foundation

class ArticlesApiModel {
     var articles: [Article] = []
    
    var sourceFromArticle: Source? = nil
    
    init(_ articles: [AnyHashable]) {
        
//        guard let data = articles as? [AnyHashable] else {return}
        
        for article in articles {
            
            guard let article = article as? [AnyHashable: Any] else {
                continue
            }
            //debugPrint(article)
            if let source = article["source"] as? [String: String] {
                //debugPrint(source)
                sourceData(source)
            }
     
           //debugPrint(article)
            
            let newArticle = getArticleObject(article)
            //debugPrint(newArticle)
            self.articles.append(newArticle)
            
//            guard let title = article[NewAPIKeys.title.rawValue] as? String else {return}
//            guard let author = article[NewAPIKeys.author.rawValue] as? String else {return ""}
//            guard let description = article[NewAPIKeys.description.rawValue] as? String else {return ""}
//            guard let url = article[NewAPIKeys.url.rawValue] as? String else {return ""}
//            guard let urlToImage = article[NewAPIKeys.urlToImage.rawValue] as? String else {return ""}
//            guard let publishedAt = article[NewAPIKeys.publishedAt.rawValue] as? String else {return ""}
//            guard let content = article[NewAPIKeys.content.rawValue] as? String else {return ""}

            //debugPrint(title)
            
            
//            if let sourceOfArticle = sourceFromArticle {
//                let newArticle = Article(source: sourceOfArticle, author: author, title: title, description: description, url: url, urlToImage: urlToImage, publishedAt: publishedAt, content: content)
//
//                debugPrint(newArticle)
//                self.articles.append(newArticle)
//            }
        
        }
    }

    
    
}


extension ArticlesApiModel {
    func sourceData(_ source: [String: String]) {
        
        var sourceId = ""
        var sourceName = ""

        guard let id = source[NewAPIKeys.id.rawValue] else {return}
        guard let name = source[NewAPIKeys.name.rawValue] else {return}
        
        if !id.isEmpty {
            sourceId = id
        }
        
        if !name.isEmpty {
            sourceName = name
        }
        
        let newSourceObject = Source(id: sourceId, name: sourceName)
        self.sourceFromArticle = newSourceObject
    }
    
    func getArticleObject(_ article: [AnyHashable: Any]) -> Article {
        
        var newArticle = Article()
        
        let title = returnValueUsingKeyFromDict(NewAPIKeys.title.rawValue, article)
        let author = returnValueUsingKeyFromDict(NewAPIKeys.author.rawValue, article)
        let description = returnValueUsingKeyFromDict(NewAPIKeys.description.rawValue, article)
        let url = returnValueUsingKeyFromDict(NewAPIKeys.url.rawValue, article)
        let urlToImage = returnValueUsingKeyFromDict(NewAPIKeys.urlToImage.rawValue, article)
        let publishedAt = returnValueUsingKeyFromDict(NewAPIKeys.publishedAt.rawValue, article)
        let content = returnValueUsingKeyFromDict(NewAPIKeys.content.rawValue, article)
        
        
        
        if let sourceOfArticle = sourceFromArticle {
            //newArticle
            newArticle.source = sourceOfArticle
            newArticle.author = author
            newArticle.title = title
            newArticle.description = description
            newArticle.url = url
            newArticle.urlToImage = urlToImage
            newArticle.publishedAt = publishedAt
            newArticle.content = content
           
        }
        
        return newArticle
        
    }
    
    func returnValueUsingKeyFromDict(_ key: String, _ article: [AnyHashable: Any]) -> String {
        
        guard let value = article[key] as? String else {return ""}
        
        if value.isEmpty {
            return ""
        }
        return value
    }
}

enum NewAPIKeys: String {
    case source
    case author
    case title
    case description
    case url
    case urlToImage
    case publishedAt
    case content
    case id
    case name
}

class Article {
    var source: Source? = nil
    var author: String = ""
    var title: String = ""
    var description: String = ""
    var url: String = ""
    var urlToImage: String = ""
    var publishedAt: String = ""
    var content: String = ""
    
    init () {
    }
}

struct Source {
    var id: String = ""
    var name: String = ""
}
