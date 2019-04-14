//
//  UIViewController+Alert.swift
//  hackernews-stories
//
//  Created by Alexander Tereshkov on 4/14/19.
//  Copyright © 2019 Alexander Tereshkov. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    
    func showNoInternetConnectionAlert(callback: (() -> Void)? = nil) {
        let title = "alert.no-internet-connection.title".localized
        let message = "alert.no-internet-connection.message".localized
        let buttonTitle = "alert.no-internet-connection.action.ok".localized
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: buttonTitle, style: .default, handler: { _ in
            callback?()
        }))
        
        present(alert, animated: true, completion: nil)
    }
    
}
