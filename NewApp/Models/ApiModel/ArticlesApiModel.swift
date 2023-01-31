//
//  ArticlesApiModel.swift
//  NewApp
//
//  Created by Shubham Handa on 17/12/22.
//

import Foundation

class ArticlesApiModel {
    var articles: [Article] = []
    
    init(_ articles: [AnyHashable]) {
        
        for article in articles {
            guard let article = article as? [AnyHashable: Any],
                  let source = article[NewAPIKeys.source.rawValue] as? [String: String] else { continue }
            
            let newArticle = getArticleObject(article, source: getSource(source))
            self.articles.append(newArticle)
        }
    }
}

private extension ArticlesApiModel {
    
    func getSource(_ source: [String: String]) -> Source {
        var sourceId = ""
        var sourceName = ""
        
        if let id = source[NewAPIKeys.id.rawValue], !id.isEmpty {
            sourceId = id
        }
        
        if let name = source[NewAPIKeys.name.rawValue], !name.isEmpty {
            sourceName = name
        }
        
        return Source(id: sourceId, name: sourceName)
    }
    
    func getArticleObject(_ article: [AnyHashable: Any], source: Source) -> Article {
        return Article(source: source,
                       author: getValue(NewAPIKeys.author.rawValue, article),
                       title: getValue(NewAPIKeys.title.rawValue, article),
                       description: getValue(NewAPIKeys.description.rawValue, article),
                       url: getValue(NewAPIKeys.url.rawValue, article),
                       urlToImage: getValue(NewAPIKeys.urlToImage.rawValue, article),
                       publishedAt:  getValue(NewAPIKeys.publishedAt.rawValue, article),
                       content: getValue(NewAPIKeys.content.rawValue, article))
    }
    
    func getValue(_ key: String, _ article: [AnyHashable: Any]) -> String {
        return article[key] as? String ?? ""
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
    var source: Source? = nil
    var author: String = ""
    var title: String = ""
    var description: String = ""
    var url: String = ""
    var urlToImage: String = ""
    var publishedAt: String = ""
    var content: String = ""
    var isBookmarked: Bool = false
}

struct Source {
    var id: String
    var name: String
}
