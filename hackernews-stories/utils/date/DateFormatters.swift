//
//  DateFormatters.swift
//  hackernews-stories
//
//  Created by Alexander Tereshkov on 4/14/19.
//  Copyright © 2019 Alexander Tereshkov. All rights reserved.
//

import Foundation

final class DateFormatters {
    
    private static var cache: [String: DateFormatter] = [:]
    
    static func with(format: String) -> DateFormatter {
        if let formatter = cache[format] {
            return formatter
        }
        let formatter = DateFormatter()
        formatter.dateFormat = format
        formatter.timeZone = Calendar.current.timeZone
        formatter.locale = Locale.current
        cache[format] = formatter
        return formatter
    }
    
}
