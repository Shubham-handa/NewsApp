//
//  File.swift
//  NewApp
//
//  Created by Shubham Handa on 17/12/22.
//

import Foundation

enum APIType {
    case searchByName
    case topHeadlines
}

class Fetcher {
    static let shared = Fetcher()
    
    private let mainUrl = "https://newsapi.org/v2"
    private let apiKey = "3a7f84afd0f1485985860e58a4516392"
    
    private init() {}
    
    func fetch(_ name: String?, withAPIType: APIType, completion: @escaping ([Article]) -> Void) {
        guard let url = getURL(withAPIType, name: name) else {
            completion([])
            return
        }
        
        URLSession.shared.dataTask(with: URLRequest(url: url)) { data, response, error in
            guard let data = data,
                  let decodeData = try? JSONSerialization.jsonObject(with: data) as? [AnyHashable: Any],
                  let articles = decodeData["articles"] as? [AnyHashable]else {
                completion([])
                return
            }
            
            completion(ArticlesApiModel(articles).articles)
        }.resume()
    }
    
    private func getURL(_ apiType: APIType, name: String?) -> URL? {
        switch apiType {
        case .searchByName:
            return URL(string: "\(mainUrl)/everything?q=\(name ?? "")&apiKey=\(apiKey)")
        case .topHeadlines:
            return URL(string: "\(mainUrl)/top-headlines?country=us&apiKey=\(apiKey)")
        }
    }
}
