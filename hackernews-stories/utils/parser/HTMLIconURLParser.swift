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
    
    func parse() -> [IconProtocol] {
//        let start = "<link rel=\"apple-touch-icon\""
//        let end = "/>"
//        let parsed = html.substring(from: start, to: end, options: .caseInsensitive)
//        Swift.print("PARSED: \(parsed)")
        
        // Parse entire line
        let start = "<link rel=\"icon\""
        let end = "/>"
        let parsed = html.substring(from: start, to: end, options: .caseInsensitive)
        Swift.print("PARSED: \(parsed)")
        
        // Parse link
        let from = "href=\""
        let to = "\""
        let link = parsed?.substring(from: from, to: to, options: .caseInsensitive)
        Swift.print("PARSED LINK: \(link)")
        return []
    }
    
    // MARK: Private
    
}
