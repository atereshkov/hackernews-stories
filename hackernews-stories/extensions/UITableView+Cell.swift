//
//  UITableView+Cell.swift
//  hackernews-stories
//
//  Created by Alexander Tereshkov on 4/9/19.
//  Copyright © 2019 Alexander Tereshkov. All rights reserved.
//

import UIKit

extension UITableView {
    
    func registerNibCell<T: UITableViewCell>(_ cell: T.Type) {
        let nib = UINib(nibName: String(describing: cell), bundle: nil)
        register(nib, forCellReuseIdentifier: cell.identifier)
    }
    
    func dequeueReusableCell<T: UITableViewCell>(for index: IndexPath) -> T? {
        return dequeueReusableCell(withIdentifier: T.identifier, for: index) as? T
    }
    
}
