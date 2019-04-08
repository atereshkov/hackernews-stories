//
//  MainRoutable.swift
//  hackernews-stories
//
//  Created by Alexander Tereshkov on 4/8/19.
//  Copyright © 2019 Alexander Tereshkov. All rights reserved.
//

import UIKit

protocol MainRoutable {
    func goToMain(window: UIWindow)
}

extension MainRoutable where Self: RouterType {
    
    func goToMain(window: UIWindow) {
        let viewModel = MainViewModel()
        guard let view = targetView else { return }
        view.viewModel = viewModel
        let router = MainRouter(view: view)
        viewModel.router = router
        
        let rootVC = UINavigationController(rootViewController: view)
        window.rootViewController = rootVC
    }
    
    private var targetView: MainView? {
        return storyboard.instantiateInitialViewController() as? MainView
    }
    
    private var storyboard: UIStoryboard {
        return UIStoryboard(name: "Main", bundle: nil)
    }
    
}
