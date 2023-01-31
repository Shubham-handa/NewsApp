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
    
    private var articles: [Article] = []
    private var searchValue = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

}


private extension SearchNewsViewController {
    
    func setup() {
        showTableView(false)
        registerCells()
    }
    
    func registerCells() {
        searchingNewsTableView.delegate = self
        searchingNewsTableView.dataSource = self
        searchingNewsTableView.register(SearchingNewsTableViewCell.getNib(), forCellReuseIdentifier: SearchingNewsTableViewCell.nibName)
    }
    
    func showTableView(_ show: Bool) {
        DispatchQueue.main.async {
            self.searchingNewsTableView.isHidden = !show
        }
    }
    
    func showNoDataWarning(_ show: Bool) {
        DispatchQueue.main.async {
            self.dataNotGetMessageLabel.isHidden = !show
        }
    }
    
    func reloadTableView() {
        DispatchQueue.main.async {
            self.searchingNewsTableView.reloadData()
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
        guard let text = searchBar.text else { return }
        fetchNewsForSpecific(text)
    }
    
    func fetchNewsForSpecific(_ topic: String) {
        searchValue = "News Regarding \(topic)"
        
        Fetcher.shared.fetch(topic, withAPIType: .searchByName) { [weak self] articlesData in
            guard let self = self, !articlesData.isEmpty else { return }
                self.articles = articlesData
                self.showNoDataWarning(false)
                self.showTableView(true)
                self.reloadTableView()
        }
    }
}
