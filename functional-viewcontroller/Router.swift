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
        return Screen(DashboardViewController()).then(routeDashboard).run(gameOver)
    }
    
    func gameOver(result: Output) {
        print("The end")
    }
}

extension Router {
    func routeDashboard(result: DashboardOutput) -> Screen<Output> {
        switch result {
        case let .red(model):
            return Screen(RedViewController(model)).then(routeRed)
        case .blue:
            return Screen(viewController: BlueViewController())
        case .green:
            return Screen(viewController: GreenViewController())
        }
    }
    
    func routeRed(result: RedOutput) -> Screen<Output> {
        switch result {
        case let .gold(color):
            return Screen(viewController: GoldViewController(color: color))
        case let .silver(color):
            return Screen(viewController: SilverViewController(color: color))
        }
    }
}