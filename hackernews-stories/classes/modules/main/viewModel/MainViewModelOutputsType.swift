//
//  MainViewModelOutputsType.swift
//  hackernews-stories
//
//  Created by Alexander Tereshkov on 4/8/19.
//  Copyright © 2019 Alexander Tereshkov. All rights reserved.
//

import Foundation

protocol MainViewModelIOutputsType {
    var reloadItems: (() -> Void)? { get set }
    var showLoading: ((_ show: Bool) -> Void)? { get set }
    
    var itemsCount: Int { get }
    func item(for index: Int) -> StoryType?
}
