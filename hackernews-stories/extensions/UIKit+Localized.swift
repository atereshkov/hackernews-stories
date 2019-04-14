//
//  UIKit+Localized.swift
//  hackernews-stories
//
//  Created by Alexander Tereshkov on 4/14/19.
//  Copyright © 2019 Alexander Tereshkov. All rights reserved.
//

import Foundation
import UIKit

extension UIButton {
    
    @IBInspectable var localizedTitle: String? {
        set {
            setTitle(newValue?.localized, for: .normal)
        }
        get {
            return currentTitle
        }
    }
    
}

extension UILabel {
    
    @IBInspectable var localizedTitle: String? {
        set {
            text = newValue?.localized
        }
        get {
            return text
        }
    }
    
}
