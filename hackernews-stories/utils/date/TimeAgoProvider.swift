//
//  TimeAgoProvider.swift
//  hackernews-stories
//
//  Created by Alexander Tereshkov on 4/14/19.
//  Copyright © 2019 Alexander Tereshkov. All rights reserved.
//

import Foundation

protocol TimeAgoProviderProtocol {
    func timeAgo() -> String
}

final class TimeAgoProvider: TimeAgoProviderProtocol {
    
    private var date: Date
    private var fullTimeFormatter: DateFormatter
    
    init(date: Date, fullTimeFormatter: DateFormatter) {
        self.date = date
        self.fullTimeFormatter = fullTimeFormatter
    }
    
    func timeAgo() -> String {
        var secondsAgo = Int(Date().timeIntervalSince(date))
        if secondsAgo < 0 {
            secondsAgo *= (-1)
        }
        
        let minute = 60
        let hour = 60 * minute
        let day = 24 * hour
        let week = 7 * day
        
        if secondsAgo < minute {
            if secondsAgo < 5 {
                return "time.just-now".localized
            } else {
                return "time.secs-ago".localized(secondsAgo)
            }
        } else if secondsAgo < hour {
            let min = secondsAgo / minute
            if min == 1 {
                return "time.min-ago".localized(min)
            } else {
                return "time.mins-ago".localized(min)
            }
        } else if secondsAgo < day {
            let hr = secondsAgo / hour
            if hr == 1 {
                return "time.hr-ago".localized(hr)
            } else {
                return "time.hrs-ago".localized(hr)
            }
        } else if secondsAgo < week {
            let day = secondsAgo / day
            if day == 1 {
                return "time.day-ago".localized(day)
            } else {
                return "time.days-ago".localized(day)
            }
        } else {
            let strDate: String = fullTimeFormatter.string(from: date)
            return strDate
        }
    }
    
}
