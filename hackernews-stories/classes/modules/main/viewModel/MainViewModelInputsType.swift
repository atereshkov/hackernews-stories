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
    func pullToRefreshAction()
    
    func itemSelected(at index: Int)
    func willDisplayCell(at index: Int)
    func cellForRowCalled(at indexPath: IndexPath)
    func didEndDisplayingCell(at indexPath: IndexPath)
}

