//
//  TopHeadlinesTableViewCell.swift
//  NewApp
//
//  Created by Shubham Handa on 17/12/22.
//

import UIKit
import SDWebImage

class TopHeadlinesTableViewCell: UITableViewCell {
    
    @IBOutlet weak var newsImageView: UIImageView!
    @IBOutlet weak var sourceLabel: UILabel!
    @IBOutlet weak var newsTitleLabel: UILabel!
    @IBOutlet weak var cardView: UIView!
    
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

        // Configure the view for the selected state
    }
    
    func setUpData(_ article: Article) {
        //debugPrint(article)
        sourceLabel.text = article.source?.name
        newsTitleLabel.text = article.title
        newsImageView.sd_setImage(with: URL(string: article.urlToImage), placeholderImage: UIImage(systemName: "slowmo"), options: .continueInBackground, completed: nil)
    }
    
}
