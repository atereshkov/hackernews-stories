//
//  TimeAgoProviderTests.swift
//  hackernews-storiesTests
//
//  Created by Alexander Tereshkov on 4/14/19.
//  Copyright © 2019 Alexander Tereshkov. All rights reserved.
//

import XCTest
@testable import hackernews_stories

class TimeAgoProviderTests: XCTestCase {
    
    // MARK: Seconds
    
    func testSecondsNowAgoPositive() {
        let formatter = DateFormatters.with(format: "dd-MM-yyyy HH:mm")
        for index in 1..<5 {
            let dateAgo = Calendar.current.date(byAdding: .second, value: -index, to: Date())!
            let provider = TimeAgoProvider(date: dateAgo, fullTimeFormatter: formatter)
            let agoComputed = provider.timeAgo()
            let agoResult = "time.just-now".localized
            XCTAssertEqual(agoComputed, agoResult)
        }
    }
    
    func testSecondsAgoPositive() {
        let formatter = DateFormatters.with(format: "dd-MM-yyyy HH:mm")
        let dateAgo = Calendar.current.date(byAdding: .second, value: -5, to: Date())!
        let provider = TimeAgoProvider(date: dateAgo, fullTimeFormatter: formatter)
        let agoComputed = provider.timeAgo()
        let agoResult = "time.secs-ago".localized(5)
        XCTAssertEqual(agoComputed, agoResult)
    }
    
    func testMultSecondsAgoPositive() {
        let formatter = DateFormatters.with(format: "dd-MM-yyyy HH:mm")
        let dateAgo = Calendar.current.date(byAdding: .second, value: -22, to: Date())!
        let provider = TimeAgoProvider(date: dateAgo, fullTimeFormatter: formatter)
        let agoComputed = provider.timeAgo()
        let agoResult = "time.secs-ago-mult".localized(22)
        XCTAssertEqual(agoComputed, agoResult)
    }
    
    func testMinuteAgoPositive() {
        let formatter = DateFormatters.with(format: "dd-MM-yyyy HH:mm")
        let dateAgo = Calendar.current.date(byAdding: .minute, value: -1, to: Date())!
        let provider = TimeAgoProvider(date: dateAgo, fullTimeFormatter: formatter)
        let minAgoComputed = provider.timeAgo()
        let minAgoResult = "time.min-ago".localized(1)
        XCTAssertEqual(minAgoComputed, minAgoResult)
    }
    
    func testMultMinutesAgoPositive() {
        let formatter = DateFormatters.with(format: "dd-MM-yyyy HH:mm")
        let dateAgo = Calendar.current.date(byAdding: .minute, value: -3, to: Date())!
        let provider = TimeAgoProvider(date: dateAgo, fullTimeFormatter: formatter)
        let agoComputed = provider.timeAgo()
        let agoResult = "time.mins-ago-mult".localized(3)
        XCTAssertEqual(agoComputed, agoResult)
    }
    
    // MARK: Hours
    
    func testHourAgoPositive() {
        let formatter = DateFormatters.with(format: "dd-MM-yyyy HH:mm")
        let dateAgo = Calendar.current.date(byAdding: .hour, value: -1, to: Date())!
        let provider = TimeAgoProvider(date: dateAgo, fullTimeFormatter: formatter)
        let hourAgoComputed = provider.timeAgo()
        let hourAgoResult = "time.hr-ago".localized(1)
        XCTAssertEqual(hourAgoComputed, hourAgoResult)
    }
    
    func testHourAgoNegative() {
        let formatter = DateFormatters.with(format: "dd-MM-yyyy HH:mm")
        let dateAgo = Calendar.current.date(byAdding: .hour, value: -1, to: Date())!
        let provider = TimeAgoProvider(date: dateAgo, fullTimeFormatter: formatter)
        let hourAgoComputed = provider.timeAgo()
        let hourAgoResult = "time.hr-ago".localized(2) // take two hours instead of one
        XCTAssertNotEqual(hourAgoComputed, hourAgoResult)
    }
    
    func testMultHoursAgoPositive() {
        let formatter = DateFormatters.with(format: "dd-MM-yyyy HH:mm")
        let dateAgo = Calendar.current.date(byAdding: .hour, value: -3, to: Date())!
        let provider = TimeAgoProvider(date: dateAgo, fullTimeFormatter: formatter)
        let agoComputed = provider.timeAgo()
        let agoResult = "time.hrs-ago-mult".localized(3)
        XCTAssertEqual(agoComputed, agoResult)
    }
    
    // MARK: Days
    
    func testDayAgoPositive() {
        let formatter = DateFormatters.with(format: "dd-MM-yyyy HH:mm")
        let dateAgo = Calendar.current.date(byAdding: .day, value: -1, to: Date())!
        let provider = TimeAgoProvider(date: dateAgo, fullTimeFormatter: formatter)
        let dayAgoComputed = provider.timeAgo()
        let dayAgoResult = "time.day-ago".localized(1)
        XCTAssertEqual(dayAgoComputed, dayAgoResult)
    }
    
    func testDaysAgoPositive() {
        let formatter = DateFormatters.with(format: "dd-MM-yyyy HH:mm")
        let dateAgo = Calendar.current.date(byAdding: .day, value: -3, to: Date())!
        let provider = TimeAgoProvider(date: dateAgo, fullTimeFormatter: formatter)
        let dayAgoComputed = provider.timeAgo()
        let dayAgoResult = "time.days-ago".localized(3)
        XCTAssertEqual(dayAgoComputed, dayAgoResult)
    }
    
    func testDayAgoNegative() {
        let formatter = DateFormatters.with(format: "dd-MM-yyyy HH:mm")
        let dateAgo = Calendar.current.date(byAdding: .day, value: -1, to: Date())!
        let provider = TimeAgoProvider(date: dateAgo, fullTimeFormatter: formatter)
        let dayAgoComputed = provider.timeAgo()
        let dayAgoResult = "time.day-ago".localized(2) // take two days instead of one
        XCTAssertNotEqual(dayAgoComputed, dayAgoResult)
    }
    
    func testMultDaysAgoPositive() {
        let formatter = DateFormatters.with(format: "dd-MM-yyyy HH:mm")
        let dateAgo = Calendar.current.date(byAdding: .day, value: -3, to: Date())!
        let provider = TimeAgoProvider(date: dateAgo, fullTimeFormatter: formatter)
        let agoComputed = provider.timeAgo()
        let agoResult = "time.days-ago-mult".localized(3)
        XCTAssertEqual(agoComputed, agoResult)
    }
    
    // MARK: Months
    
    func testMonthAgo() {
        let formatter = DateFormatters.with(format: "dd-MM-yyyy HH:mm")
        let dateAgo = Calendar.current.date(byAdding: .month, value: -1, to: Date())!
        let provider = TimeAgoProvider(date: dateAgo, fullTimeFormatter: formatter)
        let monthAgoComputed = provider.timeAgo()
        let monthAgoResult = formatter.string(from: dateAgo)
        XCTAssertEqual(monthAgoComputed, monthAgoResult)
    }
    
}
