//
//  Router.swift
//  functional-viewcontroller
//
//  Created by Gerrit Menzel on 09.03.16.
//  Copyright © 2016 @gerritmenzel. All rights reserved.
//

import Foundation
import UIKit

protocol Output {}
protocol Routable {
    typealias T
    var onCompletion: T -> Void { get set }
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
    
    init<T where T: Routable, T.T == A, T:UIViewController>(_ routableViewController: T) {
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
    
    init<T where T: Routable, T.T == A, T:UIViewController>(_ routableViewController: T) {
        self.init(ViewControllerOutput(routableViewController))
    }
    
//    init<B,T where T: Routable, T.T == A, T:UIViewController>(routableViewController: T, route: A -> Screen<B>) {
//        self.init(ViewControllerOutput(routableViewController))
//    }
    
    func run(callback: A -> Void) -> UIViewController {
        let nc = UINavigationController()
        return build(navigationController: nc, callback: callback)
    }
    
    func then<B> (f: A -> Screen<B>) -> Screen<B> {
        return Screen<B> { (navigationController, callback) in
            self.build(navigationController: navigationController, callback: { a in
                f(a).build(navigationController: navigationController, callback: callback)
            })
        }
    }
}