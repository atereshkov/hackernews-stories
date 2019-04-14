//
//  String.swift
//  hackernews-stories
//
//  Created by Alexander Tereshkov on 4/14/19.
//  Copyright © 2019 Alexander Tereshkov. All rights reserved.
//

import Foundation

extension StringProtocol where Index == String.Index {
    func substring(from start: String, to end: String? = nil, options: String.CompareOptions = []) -> SubSequence? {
        guard let lower = range(of: start, options: options)?.upperBound else { return nil }
        guard let end = end else { return self[lower...] }
        guard let upper = self[lower...].range(of: end, options: options)?.lowerBound else { return nil }
        return self[lower..<upper]
    }
}
