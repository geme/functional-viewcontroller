//
//  BlueViewController.swift
//  routing
//
//  Created by Gerrit Menzel on 18.06.16.
//  Copyright © 2016 Gerrit Menzel. All rights reserved.
//

import UIKit

enum BlueOutput: Output {
    case gold(text: String)
    case silver(num: Int)
    case crystal(doub: Double)

}

class BlueViewController: UIViewController, Completable {

    var onCompletion: (BlueOutput) -> Void = { _ in }

    required init(coder aDecoder: NSCoder) { super.init(coder: aDecoder)! }
    override init(nibName nibNameOrNil: String!, bundle nibBundleOrNil: Bundle!) { super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil) }

    convenience init() {
        self.init(nibName: nil, bundle: nil)

        title = "Blue"
        view.backgroundColor = UIColor.blue()

        let gold = ButtonModel(title: "gold", color: #colorLiteral(red: 0.9346159697, green: 0.6284804344, blue: 0.1077284366, alpha: 1), size: CGSize(width: 150, height: 50), action: #selector(goldTouchUpInside(sender:)))
        let silver = ButtonModel(title: "silver", color: #colorLiteral(red: 0.7602152824, green: 0.7601925135, blue: 0.7602053881, alpha: 1), size: CGSize(width: 150, height: 50), action: #selector(silverTouchUpInside(sender:)))
        let crystal = ButtonModel(title: "crystal", color: #colorLiteral(red: 0.8779790998, green: 0.3812967837, blue: 0.5770481825, alpha: 1), size: CGSize(width: 150, height: 50), action: #selector(crystalTouchUpInside(sender:)))

        var point = CGPoint(x: 90, y: 100)
        for model in [gold, silver, crystal] {

            addButton(model: model, offset: point)

            point.y += model.size.height + 15
        }

    }

    func goldTouchUpInside(sender: UIButton) {
        onCompletion(.gold(text: "gold"))
    }

    func silverTouchUpInside(sender: UIButton) {
        onCompletion(.silver(num: 42))
    }

    func crystalTouchUpInside(sender: UIButton) {
        onCompletion(.crystal(doub: 5))
    }
    
}
