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
    
    init(html: String) {
        self.html = html
    }
    
    // MARK: API
    
    /// Returns an array of `IconProtocol` that parsed from HTML String
    func parse(baseURL: URL) -> [IconProtocol] {
        var icons: [IconProtocol] = []
        let startApple = "<link rel=\"apple-touch-icon\""
        let endApple = ">"
        let applePattern = ParserPattern(start: startApple, end: endApple)
        guard let appleURL = parseIconURL(pattern: applePattern, baseURL: baseURL) else { return icons }
        let appleIcon = Icon(url: appleURL, type: .apple)
        icons.append(appleIcon)
        
        let startIcon = "<link rel=\"icon\""
        let endIcon = ">"
        let faviconPattern = ParserPattern(start: startIcon, end: endIcon)
        guard let faviconURL = parseIconURL(pattern: faviconPattern, baseURL: baseURL) else { return icons }
        let favicon = Icon(url: faviconURL, type: .favicon)
        icons.append(favicon)
        
        return icons
    }
    
    // MARK: Private
    
    private func parseIconURL(pattern: ParserPatternProtocol, baseURL: URL) -> URL? {
        guard let parsedLink = parseLink(pattern: pattern) else { return nil }
        let constructor = URLConstructor(link: parsedLink, baseURL: baseURL)
        return constructor.constructURL()
    }
    
    /// Parses link with specific pattern from HTML String
    private func parseLink(pattern: ParserPatternProtocol) -> String? {
        // Parse entire line
        let start = "<link rel=\"icon\""
        let end = ">"
        let parsed = html.substring(from: start, to: end, options: .caseInsensitive)
        
        // Parse link from line
        let from = "href=\""
        let to = "\""
        guard let link = parsed?.substring(from: from, to: to, options: .caseInsensitive) else {
            return nil
        }
        return String(link)
    }
    
}
