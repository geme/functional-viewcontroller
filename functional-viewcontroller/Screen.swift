//
//  Router.swift
//  functional-viewcontroller
//
//  Created by Gerrit Menzel on 09.03.16.
//  Copyright © 2016 @gerritmenzel. All rights reserved.
//

import Foundation
import UIKit

protocol Routable {
    typealias A
    var onCompletion: A -> Void { get set }
}

struct ViewControllerOutput<A> {
    let run: (A -> Void) -> UIViewController
}

extension ViewControllerOutput {
    init(viewController: UIViewController) {
        run = { c in
            return viewController
        }
    }
    
    init<T where T: Routable, T.A == A, T:UIViewController>(_ routableViewController: T) {
        run = { c in
            var vc = routableViewController
            vc.onCompletion = c
            return vc
        }
    }
}

struct Screen<A> {
    let build: (navigationController: UINavigationController, callback: A -> Void) -> UIViewController
}

extension Screen {
    init(_ output: ViewControllerOutput<A>) {
        build = { navController, callback in
            let vc = output.run(callback)
            navController.pushViewController(vc, animated:true)
            return navController
        }
    }
    
    init(viewController: UIViewController) {
        self.init(ViewControllerOutput(viewController: viewController))
    }
    
    init<T where T: Routable, T.A == A, T:UIViewController>(_ routableViewController: T) {
        self.init(ViewControllerOutput(routableViewController))
    }
    
    func run(callback: A -> Void) -> UIViewController {
        let navigationController = UINavigationController()
        return build(navigationController: navigationController, callback: callback)
    }
    
    func then<B> (f: A -> Screen<B>) -> Screen<B> {
        return Screen<B> { (navigationController, callback) in
            return self.build(navigationController: navigationController, callback: { a in
                f(a).build(navigationController: navigationController, callback: callback)
            })
        }
    }
    
    func pop<B> (type: UIViewController.Type) -> Screen<B>{
        return Screen<B> { nc, c in
            nc.popToViewControllerType(type)
            return UIViewController()
        }
    }
}

extension UINavigationController {
    func popToViewControllerType (type: UIViewController.Type) {
        if let vc = self.viewControllers.filter({ (vc: UIViewController) -> Bool in
            return vc.dynamicType === type
        }).first {
            self.popToViewController(vc, animated: true)
        }
    }
}