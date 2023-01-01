//
//  CategoryWiseTableViewCell.swift
//  NewApp
//
//  Created by Shubham Handa on 20/12/22.
//

import UIKit

class CategoryWiseTableViewCell: UITableViewCell {
    
    @IBOutlet weak var cwNewsCollectionView: UICollectionView!
    
    static let nibName = "CategoryWiseTableViewCell"
    
    private var article = [Article]()
    
    @IBOutlet weak var cardView: UIView!
    static func getNib() -> UINib {
        return UINib(nibName: nibName, bundle: nil)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        registerCells()
        cwNewsCollectionView.delegate = self
        cwNewsCollectionView.dataSource = self
        //self.cardView.layer.cornerRadius = 30
        //self.cwNewsCollectionView.layer.cornerRadius = 20

    }
    
    
    func registerCells() {
        cwNewsCollectionView.register(GenericCollectionViewCell.getUINib(), forCellWithReuseIdentifier: GenericCollectionViewCell.nibName)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func setUpData(article: [Article]) {
        self.article = article
        self.cwNewsCollectionView.reloadData()
    }
    
}

extension CategoryWiseTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.article.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = cwNewsCollectionView.dequeueReusableCell(withReuseIdentifier: GenericCollectionViewCell.nibName, for: indexPath) as? GenericCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.setUpData(article[indexPath.row])
        return cell
    }
    

    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout:
                        UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        return CGSize(width: 300, height: 350) // Collection View size right?

    }
    
}
