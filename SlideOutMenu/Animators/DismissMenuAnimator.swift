//
//  DismissMenuAnimator.swift
//  SlideOutMenu
//
//  Created by Karol Altamirano on 5/29/17.
//  Copyright © 2017 Karol Altamirano. All rights reserved.
//

import UIKit

class DismissMenuAnimator: NSObject {

}

extension DismissMenuAnimator: UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.4
    }

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard
            let fromVC = transitionContext.viewController(forKey: .from),
            let toVC = transitionContext.viewController(forKey: .to)
        else { return }

        let containerView = transitionContext.containerView

        let snapshot = containerView.viewWithTag(MenuHelper.snapshodTag)!

        toVC.view.frame = snapshot.frame

        containerView.insertSubview(toVC.view, aboveSubview: fromVC.view)
        snapshot.removeFromSuperview()

        UIView.animate(
            withDuration: transitionDuration(using: transitionContext),
            animations: {
                toVC.view.frame = CGRect(origin: CGPoint.zero, size: UIScreen.main.bounds.size)
            },
            completion: { _ in
                if transitionContext.transitionWasCancelled {
                    toVC.view.removeFromSuperview()
                    containerView.insertSubview(snapshot, aboveSubview: fromVC.view)
                }

                transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
            }
        )
    }
}
