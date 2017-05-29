//
//  MainViewController.swift
//  SlideOutMenu
//
//  Created by Karol Altamirano on 5/28/17.
//  Copyright © 2017 Karol Altamirano. All rights reserved.
//

import UIKit

class MainViewController: UINavigationController {

    let interactor = Interactor()

    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
    }

}

extension MainViewController: UINavigationControllerDelegate {

    func showMenu() {
        let menuVC = Storyboards.menu.initialViewController() as! MenuViewController
        menuVC.presenter = self
        menuVC.transitioningDelegate = self

        present(menuVC, animated: true)
    }

    private func createMenuButton() -> UIBarButtonItem {
        let menu = UIBarButtonItem(
            customView: MenuButtonView(
                frame: CGRect(x: 0, y: 0, width: 30, height: 16),
                target: self,
                action: #selector(showMenu)
            )
        )

        return menu
    }

    func edgePanGesture(_ sender: UIScreenEdgePanGestureRecognizer) {
        let translation = sender.translation(in: view)

        let progress = MenuHelper.progress(
            translationInView: translation,
            viewBounds: view.bounds,
            direction: .right
        )

        MenuHelper.map(
            gestureState: sender.state,
            toInteractor: interactor,
            progress: progress,
            start: {
                self.showMenu()
            }
        )
    }

    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        // menu button
        if viewControllers.count < 2 {
            viewController.navigationItem.setLeftBarButton(createMenuButton(), animated: false)
        }

        // viewController.navigationItem.leftItemsSupplementBackButton = true
        // viewController.navigationItem.setLeftBarButton(createMenuButton(), animated: true)

        // add pan gesture
        if viewControllers.count < 2 {
            let panGesture = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(edgePanGesture(_:)))
            panGesture.edges = .left
            viewController.view.addGestureRecognizer(panGesture)
        }
    }

}

extension MainViewController: UIViewControllerTransitioningDelegate {

    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return PresentMenuAnimator()
    }

    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return DismissMenuAnimator()
    }

    func interactionControllerForDismissal(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return interactor.hasStarted ? interactor : nil
    }

    func interactionControllerForPresentation(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return interactor.hasStarted ? interactor : nil
    }
    
}
