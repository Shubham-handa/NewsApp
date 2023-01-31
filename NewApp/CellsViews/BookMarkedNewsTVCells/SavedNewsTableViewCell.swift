//
//  SavedNewsTableViewCell.swift
//  NewApp
//
//  Created by Shubham Handa on 22/12/22.
//

import UIKit
import SDWebImage

protocol SavedNewsTableViewDelegate: AnyObject {
    func didTapOnDeleteButton(index: Int)
}

class SavedNewsTableViewCell: UITableViewCell {

    @IBOutlet weak var optionButton: UIButton!
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var newsPublishedAtLV: UILabel!
    @IBOutlet weak var newsTitleLV: UILabel!
    @IBOutlet weak var newsIV: UIImageView!
    
    static let nibName = "SavedNewsTableViewCell"

    weak var delegate: SavedNewsTableViewDelegate?

    private var indexPath: IndexPath = []
    private var index = 0
    
    static func getNib() -> UINib {
        return UINib(nibName: nibName, bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setup()
    }
    
    func update(option:String) {
        //debugPrint(index)
        self.delegate?.didTapOnDeleteButton(index: self.index)
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    private func setup() {
        cardView.layer.cornerRadius = 24
        
        newsIV.clipsToBounds = true
        cardView.clipsToBounds = true
        
        let menuClosure = {(action: UIAction) in
            self.update(option: action.title)
        }
        
        optionButton.menu = UIMenu(title: "",
                                   children: [
                                    UIAction(title: "Delete",
                                             image: UIImage(systemName: "delete.left.fill")?.withTintColor(.red, renderingMode: .alwaysOriginal),
                                             handler: menuClosure)
                                   ])
        optionButton.showsMenuAsPrimaryAction = true
    }
    
    func setUpData(_ article: ArticleDBModel, index: Int){
        self.index = index

        newsTitleLV.text = article.title
        newsPublishedAtLV.text = findTime(article.publishedAt)
        
        newsIV.sd_setImage(with: URL(string: article.urlToImage),
                           placeholderImage: UIImage(systemName: "slowmo"),
                           options: .continueInBackground,
                           completed: nil)
    }
    
    
}
