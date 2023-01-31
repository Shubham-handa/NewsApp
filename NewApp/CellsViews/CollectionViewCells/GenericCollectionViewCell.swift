//
//  GenericCollectionViewCell.swift
//  NewApp
//
//  Created by Shubham Handa on 20/12/22.
//

import UIKit

class GenericCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var newsAuthorLabel: UILabel!
    @IBOutlet weak var newsTitleLabel: UILabel!
    @IBOutlet weak var newsImageView: UIImageView!
    @IBOutlet weak var newsPublishedAt: UILabel!
    @IBOutlet weak var cardView: UIView!
    
    static let nibName = "GenericCollectionViewCell"
    static let nib: UINib = { UINib(nibName: nibName, bundle: nil) }()

    override func awakeFromNib() {
        super.awakeFromNib()
        self.cardView.layer.cornerRadius = 20
        self.cardView.clipsToBounds = true
        newsImageView.clipsToBounds = true
        // Initialization code
    }
    
    
    func setUpData(_ article: Article) {
        //debugPrint(article)
        newsTitleLabel.text = article.title
        newsPublishedAt.text = findTime(article.publishedAt)
        newsAuthorLabel.text = article.author.isEmpty ? "Random" : article.author
        newsImageView.sd_setImage(with: URL(string: article.urlToImage),
                                  placeholderImage: UIImage(systemName: "slowmo"),
                                  options: .continueInBackground,
                                  completed: nil)
    }
    

}
