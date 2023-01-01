//
//  SearchingNewsTableViewCell.swift
//  NewApp
//
//  Created by Shubham Handa on 30/12/22.
//

import UIKit
import SDWebImage

class SearchingNewsTableViewCell: UITableViewCell {

    @IBOutlet weak var sourceViewLabel: UILabel!
    @IBOutlet weak var titleViewLabel: UILabel!
    @IBOutlet weak var searchedNewsImageView: UIImageView!
    var index: Int = 0
    
    static let nibName = "SearchingNewsTableViewCell"
    
    static func getNib() -> UINib {
        return UINib(nibName: nibName, bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.searchedNewsImageView.layer.cornerRadius = 20
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setUpData(_ article: Article,_ index: Int) {
        self.index = index
        if article.source?.name.count == 0 {
            sourceViewLabel.text = "Unknown"
        }else {
            sourceViewLabel.text = article.source?.name
        }
        titleViewLabel.text = article.title
        searchedNewsImageView.sd_setImage(with: URL(string: article.urlToImage), placeholderImage: UIImage(systemName: "slowmo"), options: .continueInBackground, completed: nil)
    }
    
}
