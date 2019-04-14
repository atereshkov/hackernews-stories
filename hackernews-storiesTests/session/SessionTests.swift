//
//  SessionTests.swift
//  hackernews-storiesTests
//
//  Created by Alexander Tereshkov on 4/13/19.
//  Copyright © 2019 Alexander Tereshkov. All rights reserved.
//

import XCTest
@testable import hackernews_stories

class SessionTests: XCTestCase {
    
    func testStoryServiceCanBeResolved() {
        let session: SessionType = Session()
        let _: StoryServiceProtocol = session.resolve()
    }
    
}
