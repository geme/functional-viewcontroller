//
//  AppDelegate.swift
//  functional-viewcontroller
//
//  Created by Gerrit Menzel on 06.03.16.
//  Copyright © 2016 Gerrit Menzel. All rights reserved.
//

import UIKit

protocol Result {}
protocol Routable {
    typealias T
    var onCompletion: T -> Void { get set }
}

struct Screen<A> {
    let run: (A -> Void) -> UIViewController
}

struct Router<A> {
    let build: (navigationController: UINavigationController, callback: A -> Void) -> UIViewController
}

extension Router {
    init(_ screen: Screen<A>) {
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
    
    func then<B> (f: A -> Router<B>) -> Router<B> {
        return Router<B>(build: { (navigationController, callback) -> UIViewController in
            self.build(navigationController: navigationController, callback: { a in
                f(a).build(navigationController: navigationController, callback: callback)
            })
        })
    }
}

func red (text: String) -> Screen<RedResult> {
    return Screen {
        let vc = RedViewController()
        vc.title = text
        vc.onCompletion = $0
        return vc
    }
}

func route(result: DashboardResult) -> Router<Result> {
    switch result {
    case let .red(text):
        return Router(red(text)).then(route)
    case .blue:
        return Router(BlueViewController())
    case .green:
        return Router(GreenViewController())
    }
}

func route(route: RedResult) -> Router<Result> {
    switch route {
    case let .gold(color):
        return Router(GoldViewController(color: color))
    case let .silver(color):
        return Router(SilverViewController(color: color))
    }
}

func app () -> UIViewController {
    return Router(DashboardViewController.screen()).then(route).run(gameOver)
}

func gameOver(result: Result) {
    print("The end")
}

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        window = UIWindow(frame: UIScreen.mainScreen().bounds)
        if let window = window {
            window.rootViewController = app()
            window.makeKeyAndVisible()
        }
        return true
    }

}

