//
//  GoldViewController.swift
//  functional-viewcontroller
//
//  Created by Gerrit Menzel on 08.03.16.
//  Copyright © 2016 @gerritmenzel. All rights reserved.
//

import UIKit

class GoldViewController: UIViewController {
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    override init(nibName nibNameOrNil: String!, bundle nibBundleOrNil: NSBundle!) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    convenience init(color: UIColor) {
        self.init(nibName: nil, bundle: nil)
        self.view.backgroundColor = color
    }
}