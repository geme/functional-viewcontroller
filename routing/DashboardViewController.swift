//
//  DashboardViewController.swift
//  routing
//
//  Created by Gerrit Menzel on 18.06.16.
//  Copyright © 2016 Gerrit Menzel. All rights reserved.
//

import UIKit

enum DashboardOutput: Output {
    case red(text: String)
    case blue(num: Int)
    case green(doub: Double)
    case yellow(float: Float)

}

class DashboardViewController: UIViewController, Completable {

    var onCompletion: (DashboardOutput) -> Void = { _ in }

    required init(coder aDecoder: NSCoder) { super.init(coder: aDecoder)! }
    override init(nibName nibNameOrNil: String!, bundle nibBundleOrNil: Bundle!) { super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil) }

    convenience init() {
        self.init(nibName: nil, bundle: nil)

        title = "Dashboard"

        let red = ButtonModel(title: "red", color: UIColor.red(), size: CGSize(width: 150, height: 50), action: #selector(redTouchUpInside(sender:)))
        let blue = ButtonModel(title: "blue", color: UIColor.blue(), size: CGSize(width: 150, height: 50), action: #selector(blueTouchUpInside(sender:)))
        let green = ButtonModel(title: "green", color: UIColor.green(), size: CGSize(width: 150, height: 50), action: #selector(greenTouchUpInside(sender:)))
        let yellow = ButtonModel(title: "yellow", color: UIColor.yellow(), size: CGSize(width: 150, height: 50), action: #selector(yellowTouchUpInside(sender:)))

        var point = CGPoint(x: 90, y: 100)
        for model in [red, blue, green, yellow] {

            addButton(model: model, offset: point)

            point.y += model.size.height + 15
        }

    }

    func redTouchUpInside(sender: UIButton) {
        onCompletion(.red(text: "red"))
    }

    func blueTouchUpInside(sender: UIButton) {
        onCompletion(.blue(num: 42))
    }

    func greenTouchUpInside(sender: UIButton) {
        onCompletion(.green(doub: 5))
    }

    func yellowTouchUpInside(sender: UIButton) {
        onCompletion(.yellow(float: 99.5))
    }

}
