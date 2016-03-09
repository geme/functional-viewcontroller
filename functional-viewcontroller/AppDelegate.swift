//
//  AppDelegate.swift
//  functional-viewcontroller
//
//  Created by Gerrit Menzel on 06.03.16.
//  Copyright © 2016 Gerrit Menzel. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        window = UIWindow(frame: UIScreen.mainScreen().bounds)
        if let window = window {
            window.rootViewController = Router().app()
            window.makeKeyAndVisible()
        }
        return true
    }

}

