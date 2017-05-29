//
//  HomeViewController.swift
//  SlideOutMenu
//
//  Created by Karol Altamirano on 5/28/17.
//  Copyright © 2017 Karol Altamirano. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func showDetail(_ sender: UIButton) {
        let homeDetailVC = Storyboards.homeDetail.initialViewController() as! HomeDetailViewController
        navigationController?.pushViewController(homeDetailVC, animated: true)
    }

}
