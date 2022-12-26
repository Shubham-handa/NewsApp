//
//  ArticleDataManager.swift
//  NewApp
//
//  Created by Shubham Handa on 26/12/22.
//

import Foundation

struct ArticleDataManager {
    private let articleDataRepository = ArticleDataRepository()
    
    func saveNewsArticle(_ article: Article) {
        articleDataRepository.save(article: article)
    }
    
    func getAllNewsArticle() -> [ArticleDBModel] {
        return articleDataRepository.get()
    }
    
    func deleteSpecificNewsArticle(_ deleteArticle: ArticleDBModel) {
        articleDataRepository.delete(deleteArticle: deleteArticle)
    }
}
