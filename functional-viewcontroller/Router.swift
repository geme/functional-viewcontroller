//
//  Router.swift
//  functional-viewcontroller
//
//  Created by Gerrit Menzel on 09.03.16.
//  Copyright © 2016 @gerritmenzel. All rights reserved.
//

import UIKit

class Router {
    
    func app () -> UIViewController {
        return foo(DashboardViewController.screen(), route).run(gameOver)
    }
    
    func gameOver(result: Output) {
        print("The end")
    }
    
    func foo<A,B>(screen: Screen<A>, _ route: A -> NavigationController<B>) -> NavigationController<B> {
        return NavigationController(screen).then(route)
    }
    
    func foo<A>(screen: Screen<A>) -> NavigationController<A> {
        return NavigationController(screen)
    }
    
    func foo<A>(vc: UIViewController) -> NavigationController<A> {
        return foo(Screen<A> { _ in
            return vc
        })
    }
}

extension Router {
    func route(result: DashboardOutput) -> NavigationController<Output> {
        switch result {
        case let .red(text):
            return foo(RedViewController.screen(text), route)
        case .blue:
            return foo(BlueViewController())
        case .green:
            return foo(GreenViewController())
        }
    }
    
    func route(route: RedOutput) -> NavigationController<Output> {
        switch route {
        case let .gold(color):
            return foo(GoldViewController(color: color))
        case let .silver(color):
            return foo(SilverViewController(color: color))
        }
    }
}