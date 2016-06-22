//
//  AppDelegate.swift
//  routing
//
//  Created by Gerrit Menzel on 14.06.16.
//  Copyright © 2016 Gerrit Menzel. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main().bounds)
        
        if let window = self.window {
            window.rootViewController = Router.app()
            window.makeKeyAndVisible()
        }
        
        return true
    }
}
