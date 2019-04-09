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
    var session: SessionType { get }
}

class BaseRouter: RouterType {
    
    let session: SessionType
    private(set) weak var view: UIViewController?
    
    init(session: SessionType, view: UIViewController) {
        self.session = session
        self.view = view
    }
    
}
