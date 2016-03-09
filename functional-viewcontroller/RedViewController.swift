//
//  RedViewController.swift
//  functional-viewcontroller
//
//  Created by Gerrit Menzel on 08.03.16.
//  Copyright © 2016 @gerritmenzel. All rights reserved.
//

import UIKit

enum RedResult: Result {
    case gold(color: UIColor)
    case silver(color: UIColor)
}

class RedViewController: UIViewController, Routable {
    
    var onCompletion: RedResult -> Void = { _ in () }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    override init(nibName nibNameOrNil: String!, bundle nibBundleOrNil: NSBundle!) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    convenience init() {
        self.init(nibName: nil, bundle: nil)
        self.view.backgroundColor = UIColor.redColor()
        
        let gold = UIButton(frame: CGRectMake(50,100,100,50))
        gold.backgroundColor = UIColor(red: 151/255, green: 135/255, blue: 84/255, alpha: 1)
        gold.setTitle("gold", forState: .Normal)
        gold.addTarget(self, action: "gold:", forControlEvents: .TouchUpInside)
        
        self.view.addSubview(gold)
        
        let silver = UIButton(frame: CGRectMake(50,200,100,50))
        silver.backgroundColor = UIColor(red: 200/255, green: 205/255, blue: 211/255, alpha: 1)
        silver.setTitle("silver", forState: .Normal)
        silver.addTarget(self, action: "silver:", forControlEvents: .TouchUpInside)
        
        self.view.addSubview(silver)
    }
    
    func gold(sender: UIButton) {
        onCompletion(.gold(color: sender.backgroundColor!))
    }
    
    func silver(sender: UIButton) {
        onCompletion(.silver(color: sender.backgroundColor!))
    }
    
}
