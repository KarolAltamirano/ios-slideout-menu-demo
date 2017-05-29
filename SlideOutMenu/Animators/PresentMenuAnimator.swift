//
//  PresentMenuAnimator.swift
//  SlideOutMenu
//
//  Created by Karol Altamirano on 5/28/17.
//  Copyright © 2017 Karol Altamirano. All rights reserved.
//

import UIKit

class PresentMenuAnimator: NSObject {

}

extension PresentMenuAnimator: UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.4
    }

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard
            let fromVC = transitionContext.viewController(forKey: .from),
            let toVC = transitionContext.viewController(forKey: .to)
        else { return }

        let containerView = transitionContext.containerView

        containerView.insertSubview(toVC.view, belowSubview: fromVC.view)

        let snapshot = fromVC.view.snapshotView(afterScreenUpdates: false)!
        snapshot.tag = MenuHelper.snapshodTag
        snapshot.isUserInteractionEnabled = false

        containerView.insertSubview(snapshot, aboveSubview: toVC.view)

        fromVC.view.isHidden = true

        UIView.animate(
            withDuration: transitionDuration(using: transitionContext),
            animations: {
                snapshot.center.x += UIScreen.main.bounds.width * MenuHelper.menuWidth
            },
            completion: { _ in
                fromVC.view.isHidden = false
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
            }
        )
    }
}
