//
//  AppRouter.swift
//  hackernews-storiesTests
//
//  Created by Alexander Tereshkov on 4/13/19.
//  Copyright © 2019 Alexander Tereshkov. All rights reserved.
//

import XCTest
@testable import hackernews_stories

class AppRouterTests: XCTestCase {
    
    func testRouterInitialization() {
        let window = UIWindow(frame: UIScreen.main.bounds)
        let session: SessionType = Session()
        let router: AppRouterProtocol = AppRouter(session: session, window: window)
        XCTAssertEqual(window, router.window)
    }
    
    func testRouterRootViewControllerIsSetOnStart() {
        let window = UIWindow(frame: UIScreen.main.bounds)
        let session: SessionType = Session()
        let router: AppRouterProtocol = AppRouter(session: session, window: window)
        router.start(animated: true)
        XCTAssertNotNil(router.rootViewController)
    }
    
    func testIfRouterNotStartedThenRootViewIsNil() {
        let window = UIWindow(frame: UIScreen.main.bounds)
        let session: SessionType = Session()
        let router: AppRouterProtocol = AppRouter(session: session, window: window)
        XCTAssertNil(router.rootViewController)
    }
    
    func testThatAppRouterWindowSetToMainScreenAtStartup() {
        let window = UIWindow(frame: UIScreen.main.bounds)
        let session: SessionType = Session()
        let router: AppRouterProtocol = AppRouter(session: session, window: window)
        router.start(animated: true)
        let navVC = router.rootViewController as? UINavigationController
        XCTAssert(navVC?.children.first is MainView)
    }
    
}
