//
//  Menus.swift
//  SlideOutMenu
//
//  Created by Karol Altamirano on 5/29/17.
//  Copyright © 2017 Karol Altamirano. All rights reserved.
//

import UIKit

enum Menus: String {

    case home = "Home"
    case pageOne = "Page One"
    case pageTwo = "Page Two"

    func title() -> String {
        return self.rawValue
    }

    func navigate(presenter: UINavigationController) {
        var vc: UIViewController

        switch self {
        case .home:
            vc = Storyboards.home.initialViewController() as! HomeViewController
        case .pageOne:
            vc = Storyboards.pageOne.initialViewController() as! PageOneViewController
        case .pageTwo:
            vc = Storyboards.pageTwo.initialViewController() as! PageTwoViewController
        }

        presenter.setViewControllers([vc], animated: false)
        presenter.dismiss(animated: true)
    }

}
