//
//  ViewController.swift
//  NewApp
//
//  Created by Shubham Handa on 16/12/22.
//

import UIKit
import RealmSwift

class ViewController: UIViewController{
    @IBOutlet weak var newsDisplayTableView: UITableView!
    
    private var articles = [[Article]]()
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
}

private extension ViewController {
    
    func setup() {
        setupUI()
        fetchData()
    }
    
    func setupUI() {
        setupTableView()
        navigationItem.titleView = getImageView("newsIcon2")
    }
    
    func setupTableView() {
        newsDisplayTableView.delegate = self
        newsDisplayTableView.dataSource = self
        newsDisplayTableView.register(TopHeadlinesTableViewCell.nib,
                                      forCellReuseIdentifier: TopHeadlinesTableViewCell.nibName)
        newsDisplayTableView.register(CategoryWiseTableViewCell.nib,
                                      forCellReuseIdentifier: CategoryWiseTableViewCell.nibName)
        newsDisplayTableView.register(CustomHeaderView.nib,
                                      forHeaderFooterViewReuseIdentifier: CustomHeaderView.nibName)
    }
    
    func fetchData() {
        let dispatchGroup = DispatchGroup()
        let fetchTopHeadlinesBlockOperation = BlockOperation()
        let fetchNewsByKeywordBlockOperation = BlockOperation()
        
        fetchNewsByKeywordBlockOperation.addExecutionBlock {
            dispatchGroup.enter()
            
            Fetcher.shared.fetch("bitcoin", withAPIType: .searchByName) { [weak self] articles in
                self?.articles.append(articles)
                dispatchGroup.leave()
            }
            
            dispatchGroup.wait()
        }
        
        fetchTopHeadlinesBlockOperation.addExecutionBlock {
            dispatchGroup.enter()
            
            Fetcher.shared.fetch(nil, withAPIType: .topHeadlines) { [weak self] articles in
                self?.articles.append(articles)
                self?.reloadTableView()
                dispatchGroup.leave()
            }
            
            dispatchGroup.wait()
        }
        
        fetchTopHeadlinesBlockOperation.addDependency(fetchNewsByKeywordBlockOperation)
        
        let operationQueue = OperationQueue()
        operationQueue.addOperation(fetchTopHeadlinesBlockOperation)
        operationQueue.addOperation(fetchNewsByKeywordBlockOperation)
    }
    
    func getImageView(_ named: String) -> UIImageView {
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 30, height: 40))
        imageView.image = UIImage(named: named)
        imageView.contentMode = .scaleAspectFit
        return imageView
    }
    
    func reloadTableView() {
        DispatchQueue.main.async {
            self.newsDisplayTableView.reloadData()
        }
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        articles.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        section == 0 ? 1 : articles[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
            
        case 0:
            guard let bitcoinCell = newsDisplayTableView.dequeueReusableCell(withIdentifier: CategoryWiseTableViewCell.nibName, for: indexPath) as? CategoryWiseTableViewCell else { return UITableViewCell() }
            bitcoinCell.delegate = self
            bitcoinCell.setUpData(article: articles[indexPath.section], indexPath)
            return bitcoinCell
            
        case 1:
            guard let topHeadlineCell = newsDisplayTableView.dequeueReusableCell(withIdentifier: TopHeadlinesTableViewCell.nibName, for: indexPath) as? TopHeadlinesTableViewCell else {return UITableViewCell()}
            topHeadlineCell.delegate = self
            topHeadlineCell.setUpData(articles[indexPath.section][indexPath.row], indexPath)
            return topHeadlineCell
            
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let webViewController = storyboard?.instantiateViewController(withIdentifier: WKWebViewController.storyboardID) as? WKWebViewController else { return }
        webViewController.setURL(articles[indexPath.section][indexPath.row].url)
        navigationController?.pushViewController(webViewController, animated: true)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let header = newsDisplayTableView.dequeueReusableHeaderFooterView(withIdentifier: CustomHeaderView.nibName) as? CustomHeaderView else { return nil }
        header.headerLabel.text = section == 0 ? "Bitcoint" : section == 1 ? "Top Headlines" : "Everything"
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        50
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        indexPath.section == 0 ? 350 : tableView.estimatedRowHeight
    }
}

// MARK: Delegate Protocol
extension ViewController: TopHeadlinesTVDelegate {
    
    func sendIndexPathOfTappedNews(_ type: ActionType, indexPath: IndexPath) {
        var article = articles[indexPath.section][indexPath.row]
        
        switch type {
        case .save:
            articles[indexPath.section][indexPath.row].isBookmarked = !article.isBookmarked
            article.isBookmarked = !article.isBookmarked
            ArticleDataManager().saveNewsArticle(article)
            NotificationCenter.default.post(name: Notification.Name("dataAdd"),
                                            object: nil)
            reloadTableView()
        case .show:
            guard let webViewController = storyboard?.instantiateViewController(withIdentifier: WKWebViewController.storyboardID) as? WKWebViewController else { return }
            webViewController.setURL(article.url)
            navigationController?.pushViewController(webViewController,
                                                     animated: true)
        }
    }
}

extension ViewController: CategoryWiseTableViewCellDelegate {
    
    func didTapItemAt(_ indexPath: IndexPath?) {
        guard let indexPath = indexPath,
              let webViewController = storyboard?.instantiateViewController(withIdentifier: WKWebViewController.storyboardID) as? WKWebViewController else { return }
        //debugPrint(articles[indexPath.section][indexPath.row].url)
        webViewController.setURL(articles[indexPath.section][indexPath.row].url)
        navigationController?.pushViewController(webViewController, animated: true)
    }
}

