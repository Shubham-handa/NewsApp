//
//  ArticleDBModel.swift
//  NewApp
//
//  Created by Shubham Handa on 22/12/22.
//

import Foundation
import RealmSwift

class ArticleDBModel: Object {
    @objc dynamic var source: SourceDBModel? = nil
    @objc dynamic var author: String = ""
    @objc dynamic var title: String = ""
    @objc dynamic var newsDescription: String = ""
    @objc dynamic var url: String = ""
    @objc dynamic var urlToImage: String = ""
    @objc dynamic var publishedAt: String = ""
    @objc dynamic var content: String = ""
}

class SourceDBModel: Object {
    @objc dynamic var id: String = ""
    @objc dynamic var name: String = ""
}
