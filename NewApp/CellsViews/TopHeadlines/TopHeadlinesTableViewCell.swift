//
//  TopHeadlinesTableViewCell.swift
//  NewApp
//
//  Created by Shubham Handa on 17/12/22.
//

import UIKit
import SDWebImage

enum ActionType {
    case save
    case show
}

protocol TopHeadlinesTVDelegate:AnyObject {
    func sendIndexPathOfTappedNews(_ type: ActionType, indexPath: IndexPath)
}

class TopHeadlinesTableViewCell: UITableViewCell {
    
    @IBOutlet weak var newsImageView: UIImageView!
    @IBOutlet weak var sourceLabel: UILabel!
    @IBOutlet weak var newsTitleLabel: UILabel!
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var newsPublishedTime: UILabel!
    @IBOutlet weak var bookmarkedBtnOutlet: UIButton!
    
    weak var delegate: TopHeadlinesTVDelegate?
    var indexPath: IndexPath = []
    static let nibName = "TopHeadlinesTableViewCell"
    
    static let nib: UINib = { UINib(nibName: nibName, bundle: nil) }()

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupUI()
        self.selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
//        delegate?.sendIndexPathOfTappedNews(.show, indexPath: indexPath)
    }
    
    @IBAction func savedNewsButton(_ sender: UIButton) {
        delegate?.sendIndexPathOfTappedNews(.save, indexPath: indexPath)
    }
    
    @IBAction func showFullNewsDetailsButton(_ sender: UIButton) {
        delegate?.sendIndexPathOfTappedNews(.show, indexPath: indexPath)
    }
    
    private func setupUI() {
        self.selectionStyle = .none
        cardView.clipsToBounds = true
        cardView.layer.cornerRadius = 30
        newsImageView.clipsToBounds = true
    }
    
    func setUpData(_ article: Article,_ indexPath: IndexPath) {
        self.indexPath = indexPath
        newsTitleLabel.text = article.title
        sourceLabel.text = article.source?.name
        bookmarkedBtnOutlet.setImage(UIImage(systemName: article.isBookmarked ? "bookmark.fill" : "bookmark"),
                                   for: .normal)
        newsPublishedTime.text = findTime(article.publishedAt)
       // debugPrint("News Published Time \(newsPublishedTime.text)")
        newsImageView.sd_setImage(with: URL(string: article.urlToImage),
                                  placeholderImage: UIImage(systemName: "slowmo"),
                                  options: .continueInBackground,
                                  completed: nil)
    }
}
