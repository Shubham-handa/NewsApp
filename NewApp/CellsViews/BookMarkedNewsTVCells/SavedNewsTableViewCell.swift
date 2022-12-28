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
    weak var delegate:SavedNewsTableViewDelegate?
    var indexPath: IndexPath = []
    static let nibName = "SavedNewsTableViewCell"
    var index:Int = 0
    
    static func getNib() -> UINib {
        return UINib(nibName: nibName, bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.cardView.layer.cornerRadius = 30
        self.cardView.clipsToBounds = true
        newsIV.clipsToBounds = true
        
        
        //Option Button setup
        let menuClosure = {(action: UIAction) in
            self.update(option: action.title)
        }
        optionButton.menu = UIMenu(title: "", children: [
            UIAction(title: "Delete",image: UIImage(systemName: "delete.left.fill")?.withTintColor(.red, renderingMode: .alwaysOriginal), handler: menuClosure)
        ])
        optionButton.showsMenuAsPrimaryAction = true
        
    }
    
    func update(option:String) {
        //debugPrint(index)
        self.delegate?.didTapOnDeleteButton(index: self.index)
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setUpData(_ article: ArticleDBModel, index: Int){
        self.index = index
        newsPublishedAtLV.text = findTime(article.publishedAt)
        newsTitleLV.text = article.title
        newsIV.sd_setImage(with: URL(string: article.urlToImage), placeholderImage: UIImage(systemName: "slowmo"), options: .continueInBackground, completed: nil)
    }
    
    @IBAction func moreButton(_ sender: UIButton) {
        
    }
}
