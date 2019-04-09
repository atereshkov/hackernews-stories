//
//  UITableViewCell+Identifier.swift
//  hackernews-stories
//
//  Created by Alexander Tereshkov on 4/9/19.
//  Copyright © 2019 Alexander Tereshkov. All rights reserved.
//

import UIKit

extension UITableViewCell {
    
    static var identifier: String {
        return String(describing: self)
    }
    
}
