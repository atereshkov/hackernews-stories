//
//  MainViewModelInputsType.swift
//  hackernews-stories
//
//  Created by Alexander Tereshkov on 4/8/19.
//  Copyright © 2019 Alexander Tereshkov. All rights reserved.
//

import Foundation

protocol MainViewModelInputsType {
    func start()
    
    func itemSelected(at index: Int)
}

