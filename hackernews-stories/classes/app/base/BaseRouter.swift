//
//  BaseRouter.swift
//  hackernews-stories
//
//  Created by Alexander Tereshkov on 4/8/19.
//  Copyright © 2019 Alexander Tereshkov. All rights reserved.
//

import UIKit

protocol RouterType: class {
    var view: UIViewController? { get }
}

class BaseRouter: RouterType {
    
    private(set) weak var view: UIViewController?
    
    init(view: UIViewController) {
        self.view = view
    }
    
}
