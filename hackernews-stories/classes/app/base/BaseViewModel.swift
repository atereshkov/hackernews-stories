//
//  BaseViewModel.swift
//  hackernews-stories
//
//  Created by Alexander Tereshkov on 4/8/19.
//  Copyright © 2019 Alexander Tereshkov. All rights reserved.
//

protocol ViewModelType: class {
    func onViewDidLoad()
}

class BaseViewModel<Router: RouterType>: ViewModelType {
    
    var router: Router?
    
    func onViewDidLoad() {
        
    }
    
}
