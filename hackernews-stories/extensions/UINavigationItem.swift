//
//  UINavigationItem.swift
//  hackernews-stories
//
//  Created by Alexander Tereshkov on 4/8/19.
//  Copyright © 2019 Alexander Tereshkov. All rights reserved.
//

import UIKit

extension UINavigationItem {
    
    var backBarButtonTitle: String? {
        get {
            return nil
        }
        set {
            backBarButtonItem = UIBarButtonItem(title: newValue, style: .plain, target: nil, action: nil)
        }
    }
    
}
