//
//  MenuViewController.swift
//  SlideOutMenu
//
//  Created by Karol Altamirano on 5/28/17.
//  Copyright © 2017 Karol Altamirano. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {

    fileprivate let menuItems = [
        Menus.home,
        Menus.pageOne,
        Menus.pageTwo
    ]

    var presenter: MainViewController?

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    @IBAction func closeMenu(_ sender: Any) {
        dismiss(animated: true)
    }

    @IBAction func panGesture(_ sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: view)

        let progress = MenuHelper.progress(
            translationInView: translation,
            viewBounds: view.bounds,
            direction: .left
        )

        MenuHelper.map(
            gestureState: sender.state,
            toInteractor: presenter?.interactor,
            progress: progress,
            start: {
                self.dismiss(animated: true)
            }
        )
    }
    
}

extension MenuViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        menuItems[indexPath.row].navigate(presenter: presenter!)
    }

}

extension MenuViewController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        tableView.backgroundColor = UIColor.clear
        tableView.separatorStyle = .none
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuItems.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "menuTableCell")!

        cell.textLabel?.text = menuItems[indexPath.row].title()
        cell.textLabel?.textColor = UIColor.white
        cell.backgroundColor = UIColor.clear
        cell.selectionStyle = .blue

        return cell
    }

}
