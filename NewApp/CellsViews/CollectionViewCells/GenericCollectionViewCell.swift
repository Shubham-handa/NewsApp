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
    
    @IBOutlet weak var cardView: UIView!
    static let nibName = "GenericCollectionViewCell"
    
    static func getUINib() -> UINib {
        return UINib(nibName: nibName, bundle: nil)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
//        self.cardView.layer.cornerRadius = 50
//        self.cardView.clipsToBounds = true
//        newsImageView.clipsToBounds = true
        // Initialization code
    }
    

}
