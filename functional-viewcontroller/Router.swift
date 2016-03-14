//
//  Router.swift
//  functional-viewcontroller
//
//  Created by Gerrit Menzel on 09.03.16.
//  Copyright © 2016 @gerritmenzel. All rights reserved.
//

import UIKit

protocol Output {}

class Router {
    
    func app () -> UIViewController {
        return dashboard().run(gameOver)
    }
    
    func gameOver(result: Output) {
        print("The end")
    }
}

extension Router {
    func dashboard () -> Screen<Output>{
        return Screen(DashboardViewController()).then {
            switch $0 {
            case let .red(model):
                return self.red(model)
            case .blue:
                return self.blue()
            case .green:
                return self.green()
            }
        }
    }
    
    func red (model: RedViewModel) -> Screen<Output> {
        let screen = Screen(RedViewController(model))
        
        return screen.then {
            switch $0 {
            case .gold:
                return screen.pop(DashboardViewController.self)
            case let .silver(color):
                return self.silver(color)
            }
        }
    }
    
    func blue () -> Screen<Output> {
        return Screen(viewController: BlueViewController())
    }
    
    func green () -> Screen<Output> {
        return Screen(viewController: GreenViewController())
    }
    
    func gold (c: UIColor) -> Screen<Output> {
        return Screen(viewController: GoldViewController(color: c))
    }
    
    func silver (c: UIColor) -> Screen<Output> {
        return Screen(viewController: SilverViewController(color: c))
    }
}
