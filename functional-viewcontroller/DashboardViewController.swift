//
//  ViewController.swift
//  functional-viewcontroller
//
//  Created by Gerrit Menzel on 06.03.16.
//  Copyright © 2016 Gerrit Menzel. All rights reserved.
//

import UIKit

enum DashboardOutput: Output {
    case red(redViewModel: RedViewModel)
    case blue(i: Int)
    case green(color: UIColor)
}

class DashboardViewController: UIViewController, Routable {
    
    var onCompletion: DashboardOutput -> Void = { _ in () }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    override init(nibName nibNameOrNil: String!, bundle nibBundleOrNil: NSBundle!) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    convenience init() {
        self.init(nibName: nil, bundle: nil)
        
        let red = UIButton(frame: CGRectMake(50,100,100,50))
        red.backgroundColor = UIColor.redColor()
        red.setTitle("red", forState: .Normal)
        red.addTarget(self, action: "red:", forControlEvents: .TouchUpInside)
        
        self.view.addSubview(red)
        
        let blue = UIButton(frame: CGRectMake(50,200,100,50))
        blue.backgroundColor = UIColor.blueColor()
        blue.setTitle("blue", forState: .Normal)
        blue.addTarget(self, action: "blue:", forControlEvents: .TouchUpInside)
        
        self.view.addSubview(blue)
        
        let green = UIButton(frame: CGRectMake(50,300,100,50))
        green.backgroundColor = UIColor.greenColor()
        green.setTitle("green", forState: .Normal)
        green.addTarget(self, action: "green:", forControlEvents: .TouchUpInside)
        
        self.view.addSubview(green)
    }
    
    func red(sender: UIButton) {
        onCompletion(.red(redViewModel: RedViewModel(text: "foobar")))
    }
    
    func blue(sender: UIButton) {
        onCompletion(.blue(i: 12345))
    }
    
    func green(sender: UIButton) {
        onCompletion(.green(color: UIColor.greenColor()))
    }

}

