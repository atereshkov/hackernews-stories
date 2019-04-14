//
//  BaseViewTests.swift
//  hackernews-storiesTests
//
//  Created by Alexander Tereshkov on 4/13/19.
//  Copyright © 2019 Alexander Tereshkov. All rights reserved.
//

import XCTest
@testable import hackernews_stories

class BaseViewTests: XCTestCase {
    
    func testWhenInitializingWithoutViewModelThenBindViewModelNotCalled() {
        let view = DummyView()
        XCTAssertEqual(view.bindViewModelCalled, false)
    }
    
    func testWhenInitializeWithViewModelThenBindViewModelCalled() {
        let session: SessionType = Session()
        let view = DummyView()
        view.viewModel = DummyViewModel(session: session)
        view.viewDidLoad()
        XCTAssertEqual(view.bindViewModelCalled, true)
    }
    
}
