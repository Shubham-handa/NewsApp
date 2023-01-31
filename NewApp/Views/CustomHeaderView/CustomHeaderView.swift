//
//  CustomHeaderView.swift
//  NewsApp
//
//  Created by Shubham Handa on 21/12/22.
//

import UIKit

class CustomHeaderView: UITableViewHeaderFooterView {

    @IBOutlet weak var headerLabel: UILabel!
    
    static let nibName = "CustomHeaderView"
    static let nib: UINib = { UINib(nibName: nibName, bundle: nil) }()
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
