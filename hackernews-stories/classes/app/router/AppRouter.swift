//
//  AppRouter.swift
//  hackernews-stories
//
//  Created by Alexander Tereshkov on 4/8/19.
//  Copyright © 2019 Alexander Tereshkov. All rights reserved.
//

import UIKit

final class AppRouter: AppRouterProtocol {
    
    private(set) var window: UIWindow
    private(set) var session: SessionType
    
    var rootViewController: UIViewController? {
        return window.rootViewController
    }
    
    init(session: SessionType, window: UIWindow) {
        self.session = session
        self.window = window
    }
    
    func start(animated: Bool) {
        goToMain(animated: animated)
    }
    
    private func goToMain(animated: Bool) {
        let vc = UIViewController()
        window.rootViewController = vc
        window.makeKeyAndVisible()
        
        let router = InitialMainRouter(session: session, view: vc)
        router.goToMain(window: window)
    }
    
}
