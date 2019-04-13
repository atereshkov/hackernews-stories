//
//  LinkRouter.swift
//  hackernews-stories
//
//  Created by Alexander Tereshkov on 4/11/19.
//  Copyright © 2019 Alexander Tereshkov. All rights reserved.
//

import Foundation
import UIKit

protocol LinkRoutable {
    func open(link: String)
}

extension LinkRoutable where Self: RouterType {
    
    func open(link: String) {
        guard let url = URL(string: link), UIApplication.shared.canOpenURL(url) else { return }
        UIApplication.shared.open(url)
    }
    
}
