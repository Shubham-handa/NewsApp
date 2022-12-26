//
//  SavedNewsTableViewCell.swift
//  NewApp
//
//  Created by Shubham Handa on 22/12/22.
//

import UIKit
import SDWebImage

class SavedNewsTableViewCell: UITableViewCell {

    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var newsPublishedAtLV: UILabel!
    @IBOutlet weak var newsTitleLV: UILabel!
    @IBOutlet weak var newsIV: UIImageView!
    static let nibName = "SavedNewsTableViewCell"
    
    static func getNib() -> UINib {
        return UINib(nibName: nibName, bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.cardView.layer.cornerRadius = 30
        self.cardView.clipsToBounds = true
        newsIV.clipsToBounds = true
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setUpData(_ article: ArticleDBModel){
        newsPublishedAtLV.text = findTime(article.publishedAt)
        newsTitleLV.text = article.title
        newsIV.sd_setImage(with: URL(string: article.urlToImage), placeholderImage: UIImage(systemName: "slowmo"), options: .continueInBackground, completed: nil)
    }
    
    @IBAction func moreButton(_ sender: UIButton) {
    }
}
