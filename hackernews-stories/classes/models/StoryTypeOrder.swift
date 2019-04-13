//
//  StoryTypeOrder.swift
//  hackernews-stories
//
//  Created by Alexander Tereshkov on 4/13/19.
//  Copyright © 2019 Alexander Tereshkov. All rights reserved.
//

import Foundation

enum StoryTypeOrder {
    case score
    
    var ordering: (StoryType, StoryType) -> Bool {
        switch self {
        case .score:
            return { $0.score ?? 0 > $1.score ?? 0 }
        }
    }
}

extension Sequence where Element == StoryType {
    func sorted(by columnOrder: StoryTypeOrder) -> [Element] {
        return sorted(by: columnOrder.ordering)
    }
}
