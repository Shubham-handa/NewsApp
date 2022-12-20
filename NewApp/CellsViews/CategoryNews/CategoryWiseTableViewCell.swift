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
    
    static func getNib() -> UINib {
        return UINib(nibName: nibName, bundle: nil)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        registerCells()
        cwNewsCollectionView.delegate = self
        cwNewsCollectionView.dataSource = self
        
    }
    
    
    func registerCells() {
        cwNewsCollectionView.register(GenericCollectionViewCell.getUINib(), forCellWithReuseIdentifier: GenericCollectionViewCell.nibName)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}

extension CategoryWiseTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = cwNewsCollectionView.dequeueReusableCell(withReuseIdentifier: GenericCollectionViewCell.nibName, for: indexPath) as? GenericCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout:
                        UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: 400, height: 400) // Collection View size right?
        
    }
    
}
