//
//  DummyViewModel.swift
//  hackernews-storiesTests
//
//  Created by Alexander Tereshkov on 4/13/19.
//  Copyright © 2019 Alexander Tereshkov. All rights reserved.
//

import Foundation
@testable import hackernews_stories

class DummyViewModel: BaseViewModel<DummyRouter> {
    
    private(set) var onViewDidLoadCalled: Bool = false
    
    override func onViewDidLoad() {
        super.onViewDidLoad()
        onViewDidLoadCalled = true
    }
    
}
