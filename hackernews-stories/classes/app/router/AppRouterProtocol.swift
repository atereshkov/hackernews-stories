//
//  AppRouterProtocol.swift
//  hackernews-stories
//
//  Created by Alexander Tereshkov on 4/8/19.
//  Copyright © 2019 Alexander Tereshkov. All rights reserved.
//

import UIKit

protocol AppRouterProtocol {
    func start(animated: Bool)
    
    var window: UIWindow { get }
    var session: SessionType { get }
    
    var rootViewController: UIViewController? { get }
}
