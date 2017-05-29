//
//  MenuButtonView.swift
//  SlideOutMenu
//
//  Created by Karol Altamirano on 5/29/17.
//  Copyright © 2017 Karol Altamirano. All rights reserved.
//

import UIKit

class MenuButtonView: UIView {
    let normalColor = UIColor(red: 0, green: 0, blue: 1, alpha: 1)
    let activeColor = UIColor(red: 0, green: 0, blue: 1, alpha: 0.3)
    var lineColor: UIColor

    override init(frame: CGRect) {
        // set line color
        lineColor = normalColor

        super.init(frame: frame)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    convenience init(frame: CGRect, target: Any?, action: Selector?) {
        self.init(frame: frame)

        initView(target: target, action: action)
    }

    override func draw(_ rect: CGRect) {
        lineColor.setFill()
        UIBezierPath(rect: CGRect(x: 0, y: 0, width: bounds.width, height: 2)).fill()
        UIBezierPath(rect: CGRect(x: 0, y: round(bounds.height / 2) - 1, width: bounds.width, height: 2)).fill()
        UIBezierPath(rect: CGRect(x: 0, y: bounds.height - 2, width: bounds.width, height: 2)).fill()
    }

    func initView(target: Any?, action: Selector?) {
        // set background color
        backgroundColor = .clear
        clipsToBounds = true

        // add tap gesture
        let tapGesture = UITapGestureRecognizer(target: target, action: action)
        addGestureRecognizer(tapGesture)
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        lineColor = activeColor
        setNeedsDisplay()
    }

    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        lineColor = normalColor
        setNeedsDisplay()
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        lineColor = normalColor
        setNeedsDisplay()
    }

}
