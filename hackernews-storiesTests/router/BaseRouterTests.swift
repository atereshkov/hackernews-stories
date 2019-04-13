//
//  BaseRouterTests.swift
//  hackernews-storiesTests
//
//  Created by Alexander Tereshkov on 4/13/19.
//  Copyright © 2019 Alexander Tereshkov. All rights reserved.
//

import XCTest
@testable import hackernews_stories

class BaseRouterTests: XCTestCase {
    
    func testRouterInititalization() {
        let session: SessionType = Session()
        let view: UIViewController = UIViewController()
        let router = StubRouter(session: session, view: view)
        XCTAssertEqual(view, router.view)
    }
    
}
