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

struct Screen<A> {
    let run: (A -> Void) -> UIViewController
}

struct NavigationController<A> {
    let build: (navigationController: UINavigationController, callback: A -> Void) -> UIViewController
}

extension NavigationController {
    init(_ screen: Screen<A>) {
        build = { navController, callback in
            let vc = screen.run(callback)
            navController.pushViewController(vc, animated:true)
            return navController
        }
    }
    
    init(_ screen: Screen<A>, _ route: NavigationController<Output>) {
        build = { navController, callback in
            let vc = screen.run(callback)
            navController.pushViewController(vc, animated:true)
            return navController
        }
    }
    
    //    init<T: UIViewController where T: Routable>(_ viewController: T) {
    //        self.init(Screen { c in
    //            var vc = viewController
    //            vc.onCompletion = c
    //            return vc
    //        })
    //    }
    
    init(_ viewController: UIViewController) {
        self.init(Screen { _ in
            return viewController
            })
    }
    
    func run(callback: A -> Void) -> UIViewController {
        let nc = UINavigationController()
        return build(navigationController: nc, callback: callback)
    }
    
    func then<B> (f: A -> NavigationController<B>) -> NavigationController<B> {
        return NavigationController<B> { (navigationController, callback) in
            self.build(navigationController: navigationController, callback: { a in
                f(a).build(navigationController: navigationController, callback: callback)
            })
        }
    }
}