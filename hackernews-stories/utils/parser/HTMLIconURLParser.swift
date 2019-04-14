//
//  HTMLIconURLParser.swift
//  hackernews-stories
//
//  Created by Alexander Tereshkov on 4/14/19.
//  Copyright © 2019 Alexander Tereshkov. All rights reserved.
//

import Foundation

class HTMLIconURLParser: IconURLParser {
    
    private let html: String
    private let patternProvider: PatternProvider
    
    init(html: String, patternProvider: PatternProvider) {
        self.html = html
        self.patternProvider = patternProvider
    }
    
    // MARK: API
    
    /// Returns an array of `IconProtocol` that parsed from HTML String
    func parse(baseURL: URL) -> [IconProtocol] {
        var icons: [IconProtocol] = []
        
        let patterns = patternProvider.getPatterns()
        
        for pattern in patterns {
            let icon = parseIcon(pattern: pattern, baseURL: baseURL)
            guard let parsedIcon = icon else { continue }
            icons.append(parsedIcon)
        }
        
        return icons
    }
    
    // MARK: Private
    
    private func parseIcon(pattern: ParserPatternProtocol, baseURL: URL) -> Icon? {
        guard let parsedLink = parseLink(pattern: pattern) else { return nil }
        let constructor = URLConstructor(link: parsedLink, baseURL: baseURL)
        guard let url = constructor.constructURL() else { return nil }
        let icon = Icon(url: url, type: pattern.type)
        return icon
    }
    
    /// Parses link with specific pattern from HTML String
    private func parseLink(pattern: ParserPatternProtocol) -> String? {
        // Parse entire line
        let parsed = html.substring(from: pattern.start, to: pattern.end, options: .caseInsensitive)
        
        // Parse link from line
        let from = "href=\""
        let to = "\""
        guard let link = parsed?.substring(from: from, to: to, options: .caseInsensitive) else {
            return nil
        }
        return String(link)
    }
    
}
