//
//  ViewController.swift
//  routing
//
//  Created by Gerrit Menzel on 14.06.16.
//  Copyright © 2016 Gerrit Menzel. All rights reserved.
//

import UIKit

enum ViewControllerOutput {
    case Text(text: String)
}

struct ViewControllerViewModel {
    var title: String
    var backgroundColor: UIColor
    var buttons: [ButtonModel]
}

struct ButtonModel {
    let title: String
    let color: UIColor
    let size: CGSize
    let action: Selector
}

class ViewController: UIViewController, Completable {

    var outputs: [UIButton: String] = [UIButton: String]()
    var onCompletion: (ViewControllerOutput) -> Void = { _ in }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    override init(nibName nibNameOrNil: String!, bundle nibBundleOrNil: Bundle!) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    convenience init() {
        self.init(nibName: nil, bundle: nil)
    }
    
    convenience init(viewModel: ViewControllerViewModel) {
        self.init()
        bindViewModel(viewModel: viewModel)
    }
    
    func bindViewModel(viewModel: ViewControllerViewModel) {
        self.view.backgroundColor = viewModel.backgroundColor
        self.title = viewModel.title

        addButtonsToView(view: self.view, buttons: viewModel.buttons, offset: CGPoint(x:90, y:100))
    }
    
    func touch(sender: UIButton) {
        onCompletion(.Text(text: "blue out"))
    }

    func addButtonsToView(view: UIView, buttons: [ButtonModel], offset: CGPoint) {

        var point = offset

        for button in buttons {
            addButton(model: button, offset: point)
            point.y += button.size.height + 15
        }
    }

    func buttonTouchUpInside(sender: UIButton) {
        onCompletion(.Text(text: outputs[sender]!))
    }
    
}

extension UIViewController {

    func addButton(model: ButtonModel, offset: CGPoint) {

        let b = UIButton(frame: CGRect(x: offset.x, y: offset.y, width: model.size.width, height: model.size.height))
        b.backgroundColor = model.color
        b.setTitle(model.title, for: [])
        b.addTarget(self, action: model.action, for: .touchUpInside)

        view.addSubview(b)
    }
}
