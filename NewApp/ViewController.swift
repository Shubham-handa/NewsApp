//
//  ViewController.swift
//  NewApp
//
//  Created by Shubham Handa on 16/12/22.
//

import UIKit

class ViewController: UIViewController {
    
    static let randomViewControllerStoryBoardId = "RandomViewController"

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //setUp()
    }
    
    func setUp(){
        fetch()
    }
    
    func fetch(){
        Fetcher.shared.fetchTopHeadlinesParticularCountry { articlesData in
            debugPrint(articlesData)
        }
    }


    @IBAction func goToSomeOtherView(_ sender: UIButton) {
        
        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: ViewController.randomViewControllerStoryBoardId ) as? RandomViewController else { return }
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

