//
//  SavedNewsTableViewCell.swift
//  NewApp
//
//  Created by Shubham Handa on 22/12/22.
//

import UIKit

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
    
    @IBAction func moreButton(_ sender: UIButton) {
    }
}
