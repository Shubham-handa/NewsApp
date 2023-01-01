//
//  TopHeadlinesTableViewCell.swift
//  NewApp
//
//  Created by Shubham Handa on 17/12/22.
//

import UIKit
import SDWebImage

protocol TopHeadlinesTVDelegate:AnyObject {
    func sendIndexPathOfTappedNewsForSave(_ section: Int,_ row: Int)
    
}

class TopHeadlinesTableViewCell: UITableViewCell {
    
    @IBOutlet weak var newsImageView: UIImageView!
    @IBOutlet weak var sourceLabel: UILabel!
    @IBOutlet weak var newsTitleLabel: UILabel!
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var newsPublishedTime: UILabel!
    weak var delegate: TopHeadlinesTVDelegate?
    var indexPath: IndexPath = []
    static let nibName = "TopHeadlinesTableViewCell"
    
    static func getNib() -> UINib {
        return UINib(nibName: nibName, bundle: nil)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.cardView.layer.cornerRadius = 30
        self.cardView.clipsToBounds = true
        newsImageView.clipsToBounds = true
        self.selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @IBAction func savedNewsButton(_ sender: UIButton) {
        self.delegate?.sendIndexPathOfTappedNewsForSave(indexPath.section, indexPath.row)
        debugPrint(indexPath)
    }
    
    func setUpData(_ article: Article,_ indexPath: IndexPath) {
        //debugPrint(article)
        self.indexPath = indexPath
        newsPublishedTime.text = findTime(article.publishedAt)
        sourceLabel.text = article.source?.name
        newsTitleLabel.text = article.title
        newsImageView.sd_setImage(with: URL(string: article.urlToImage), placeholderImage: UIImage(systemName: "slowmo"), options: .continueInBackground, completed: nil)
    }
}
