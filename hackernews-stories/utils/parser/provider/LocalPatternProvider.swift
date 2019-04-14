//
//  LocalPatternProvider.swift
//  hackernews-stories
//
//  Created by Alexander Tereshkov on 4/14/19.
//  Copyright © 2019 Alexander Tereshkov. All rights reserved.
//

import Foundation

class LocalPatternProvider: PatternProvider {
    
    func getPatterns() -> [ParserPatternProtocol] {
        var patterns: [ParserPatternProtocol] = []
        
        let appleIconLineStart = "<link rel=\"apple-touch-icon\""
        let appleIconLineEnd = ">"
        let appleIconPattern = ParserPattern(start: appleIconLineStart, end: appleIconLineEnd, type: .apple)
        patterns.append(appleIconPattern)
        
        let faviconStartIcon = "<link rel=\"icon\""
        let faviconEndIcon = ">"
        let faviconPattern = ParserPattern(start: faviconStartIcon, end: faviconEndIcon, type: .favicon)
        patterns.append(faviconPattern)
        
        return patterns
    }
    
}
