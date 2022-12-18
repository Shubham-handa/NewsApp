//
//  File.swift
//  NewApp
//
//  Created by Shubham Handa on 17/12/22.
//

import Foundation

class Fetcher {
    static let shared = Fetcher()
    
    let mainUrl = "https://newsapi.org/v2"
    let apiKey = "3a7f84afd0f1485985860e58a4516392"
    
    private init() {}
    
    func fetchTopHeadlinesParticularCountry(_ completionHandler: @escaping ([Article]) -> Void) {
        guard let url = URL.init(string: "\(mainUrl)/top-headlines?country=in&apiKey=\(apiKey)") else {return}
        
        let urlRequest = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            
            guard let data = data else {return}
            
            do {
                let decodeData = try JSONSerialization.jsonObject(with: data) as? [AnyHashable: Any]
                
                let articles = decodeData?["articles"] as? [AnyHashable]
                
                //debugPrint(articles)
                
                if let data = articles {
                    //debugPrint(data)
                    let apiModel = ArticlesApiModel.init(data)
                    completionHandler(apiModel.articles)
                }
                
                
                
                //debugPrint(apiModel.articles)
                
                
                
                //debugPrint(articles)
            }catch let error {
                debugPrint(error)
            }
           
            
            
        }.resume()
    }
}
