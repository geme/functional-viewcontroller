//
//  Completable.swift
//  routing
//
//  Created by Gerrit Menzel on 14.06.16.
//  Copyright © 2016 Gerrit Menzel. All rights reserved.
//

protocol Completable {
    
    associatedtype A
    var onCompletion: (A) -> Void { get set }
    
}
