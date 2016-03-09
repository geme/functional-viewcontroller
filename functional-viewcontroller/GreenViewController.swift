//
//  GreenViewController.swift
//  functional-viewcontroller
//
//  Created by Gerrit Menzel on 08.03.16.
//  Copyright © 2016 @gerritmenzel. All rights reserved.
//

import UIKit

class GreenViewController: UIViewController {
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    override init(nibName nibNameOrNil: String!, bundle nibBundleOrNil: NSBundle!) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    convenience init() {
        self.init(nibName: nil, bundle: nil)
        self.view.backgroundColor = UIColor.greenColor()
    }
}