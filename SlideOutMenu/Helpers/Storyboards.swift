//
//  Storyboards.swift
//  SlideOutMenu
//
//  Created by Karol Altamirano on 5/28/17.
//  Copyright © 2017 Karol Altamirano. All rights reserved.
//

import UIKit

enum Storyboards: String {

    case home = "Home"
    case homeDetail = "HomeDetail"
    case pageOne = "PageOne"
    case pageTwo = "PageTwo"
    case menu = "Menu"

    func instance() -> UIStoryboard {
        return UIStoryboard(name: self.rawValue, bundle: Bundle.main)
    }

    func initialViewController() -> UIViewController {
        return self.instance().instantiateInitialViewController()!
    }

    func viewController(withIdentifier identifier: String) -> UIViewController {
        return self.instance().instantiateViewController(withIdentifier: identifier)
    }
    
}
