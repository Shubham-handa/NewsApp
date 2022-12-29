//
//  SearchNewsViewController.swift
//  NewApp
//
//  Created by Shubham Handa on 19/12/22.
//

import UIKit

class SearchNewsViewController: UIViewController {
    
    @IBOutlet weak var newsSearchBar: UISearchBar!
    @IBOutlet weak var searchingNewsTableView: UITableView!
    @IBOutlet weak var dataNotGetMessageLabel: UILabel!
    var articles: [Article] = []
    var searchValue = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        hideTableView()
        //dataNotGetMessageLabel.isHidden = true
        registerCells()
    }
    
    func registerCells() {
        searchingNewsTableView.delegate = self
        searchingNewsTableView.dataSource = self
        searchingNewsTableView.register(SearchingNewsTableViewCell.getNib(), forCellReuseIdentifier: SearchingNewsTableViewCell.nibName)
    }
    
    func hideTableView() {
        DispatchQueue.main.async {
            self.searchingNewsTableView.isHidden = true
        }
    }
    
    func showTableView() {
        DispatchQueue.main.async {
            self.searchingNewsTableView.isHidden = false
        }
    }
    
    func reloadTableViewData() {
        DispatchQueue.main.async {
            self.searchingNewsTableView.reloadData()
        }
    }
    
    func hideWarningRelatedToNoData() {
        DispatchQueue.main.async {
            self.dataNotGetMessageLabel.isHidden = true
        }
        
    }
    
    func showWarningRelatedToNoData() {
        DispatchQueue.main.async {
            self.dataNotGetMessageLabel.isHidden = false
        }
        
    }
}

extension SearchNewsViewController: UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let searchedNewsCell = searchingNewsTableView.dequeueReusableCell(withIdentifier: SearchingNewsTableViewCell.nibName, for: indexPath) as? SearchingNewsTableViewCell else {return UITableViewCell()}
        
        if !articles.isEmpty {
            searchedNewsCell.setUpData(articles[indexPath.row], indexPath.row)
        }
        
        return searchedNewsCell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return searchValue
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
}

extension SearchNewsViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let value = searchBar.text {
            fetchNewsForSpecific(value)
        }
    }
    
    
    func fetchNewsForSpecific(_ nameOfTheTopic: String) {
        searchValue = "News Regarding \(nameOfTheTopic)"
        Fetcher.shared.fetchBySpecificThing(nameOfTheTopic){ articlesData in
            
            if !articlesData.isEmpty {
                debugPrint(articlesData)
                self.hideWarningRelatedToNoData()
                self.articles = articlesData
                self.showTableView()
                self.reloadTableViewData()
            }
//            }else {
//                debugPrint(articlesData)
//                self.hideTableView()
//                self.showWarningRelatedToNoData()
//            }
        }
    }
}
