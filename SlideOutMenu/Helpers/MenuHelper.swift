//
//  MenuHelper.swift
//  SlideOutMenu
//
//  Created by Karol Altamirano on 5/28/17.
//  Copyright © 2017 Karol Altamirano. All rights reserved.
//

import UIKit

enum Direction {
    case up
    case down
    case left
    case right
}

struct MenuHelper {
    static let menuWidth: CGFloat = 0.8
    static let threshold: CGFloat = 0.3
    static let snapshodTag = 100000

    static func progress(translationInView: CGPoint, viewBounds: CGRect, direction: Direction) -> CGFloat {
        let movement: CGFloat
        let length: CGFloat

        switch direction {
        case .up, .down:
            movement = translationInView.y
            length = viewBounds.height
        case .left, .right:
            movement = translationInView.x
            length = viewBounds.width
        }

        var movementPercent = movement / length

        switch direction {
        case .right, .down: // positive direction
            movementPercent = max(movementPercent, 0)
            movementPercent = min(movementPercent, 1)
            return movementPercent
        case .up, .left: // negative
            movementPercent = min(movementPercent, 0)
            movementPercent = max(movementPercent, -1)
            return -movementPercent
        }
    }

    static func map(gestureState: UIGestureRecognizerState, toInteractor interactor: Interactor?, progress: CGFloat, start: () -> ()) {
        guard let interactor = interactor else { return }

        switch gestureState {
        case .began:
            interactor.hasStarted = true
            start()
        case .changed:
            interactor.shouldFinish = progress > threshold
            interactor.update(progress)
        case .cancelled:
            interactor.hasStarted = false
            interactor.cancel()
        case .ended:
            interactor.hasStarted = false
            interactor.shouldFinish ? interactor.finish() : interactor.cancel()
        default:
            break
        }
    }
}
