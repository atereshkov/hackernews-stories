//
//  DummyView.swift
//  hackernews-storiesTests
//
//  Created by Alexander Tereshkov on 4/13/19.
//  Copyright © 2019 Alexander Tereshkov. All rights reserved.
//

import UIKit
@testable import hackernews_stories

class DummyView: BaseView<DummyViewModel> {
    
    private(set) var bindViewModelCalled: Bool = false
    
    override func bindViewModel() {
        super.bindViewModel()
        bindViewModelCalled = true
    }
    
}
