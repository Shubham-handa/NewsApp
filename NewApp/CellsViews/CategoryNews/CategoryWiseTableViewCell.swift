//
//  CategoryWiseTableViewCell.swift
//  NewApp
//
//  Created by Shubham Handa on 20/12/22.
//

import UIKit

protocol CategoryWiseTableViewCellDelegate: AnyObject {
    func didTapItemAt(_ indexPath: IndexPath?)
}

class CategoryWiseTableViewCell: UITableViewCell {
    
    @IBOutlet weak var cwNewsCollectionView: UICollectionView!
    @IBOutlet weak var cardView: UIView!
    
    weak var delegate: CategoryWiseTableViewCellDelegate?
    private var article = [Article]()
    private var indexPathOfData: IndexPath = []
   
    static let nibName = "CategoryWiseTableViewCell"
    static let nib: UINib = { UINib(nibName: nibName, bundle: nil) }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupCollectionView()

    }
    
    func setupCollectionView() {
        cwNewsCollectionView.delegate = self
        cwNewsCollectionView.dataSource = self
        cwNewsCollectionView.register(GenericCollectionViewCell.nib, forCellWithReuseIdentifier: GenericCollectionViewCell.nibName)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func setUpData(article: [Article], _ indexPath: IndexPath) {
        self.indexPathOfData = indexPath
        self.article = article
        self.cwNewsCollectionView.reloadData()
    }
}

extension CategoryWiseTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        article.count
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
        CGSize(width: 300, height: 350)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.didTapItemAt(indexPath)
    }
    
}
