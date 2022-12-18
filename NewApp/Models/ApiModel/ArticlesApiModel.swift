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
    
    init(_ articles: Any?) {
        
        guard let data = articles as? [AnyHashable] else {return}
        
        for article in data {
            
            guard let article = article as? [AnyHashable: Any] else {
                continue
            }
            
            let source = article["source"] as? [AnyHashable: Any]
            
            self.sourceData(source)
            
            
            
            //debugPrint(NewAPIKeys.title.rawValue)
            
            guard let title = article[NewAPIKeys.title.rawValue] as? String else {continue}
            guard let author = article[NewAPIKeys.author.rawValue] as? String else {continue}
            guard let description = article[NewAPIKeys.description.rawValue] as? String else {continue}
            guard let url = article[NewAPIKeys.url.rawValue] as? String else {continue}
            guard let urlToImage = article[NewAPIKeys.urlToImage.rawValue] as? String else {continue}
            guard let publishedAt = article[NewAPIKeys.publishedAt.rawValue] as? String else {continue}
            guard let content = article[NewAPIKeys.content.rawValue] as? String else {continue}

            //debugPrint(self.source)
            
            if let sourceOfArticle = sourceFromArticle {
                let newArticle = Article(source: sourceOfArticle, author: author, title: title, description: description, url: url, urlToImage: urlToImage, publishedAt: publishedAt, content: content)
                
                //debugPrint(newArticle)
                
                self.articles.append(newArticle)
            }
        
        }
    }

    
    
}


extension ArticlesApiModel {
    func sourceData(_ source: Any?) {
        
        guard let data = source as? [AnyHashable: Any] else {return}
        
//        guard let articleSource = data as? AnyHashable: Any else {
//            return
//        }
        guard let id = data[NewAPIKeys.id.rawValue] as? String else {return}
        guard let name = data[NewAPIKeys.name.rawValue] as? String else {return}
        
        let newSourceObject = Source(id: id, name: name)
        
        //debugPrint(newSourceObject)
        
        self.sourceFromArticle = newSourceObject
//        debugPrint("Id \(id) and Name \(name)")
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

struct Article {
    let source: Source
    let author: String
    let title: String
    let description: String
    let url: String
    let urlToImage: String
    let publishedAt: String
    let content: String
}

struct Source {
    let id: String
    let name: String
}
