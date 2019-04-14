//
//  PatternProvider.swift
//  hackernews-stories
//
//  Created by Alexander Tereshkov on 4/14/19.
//  Copyright © 2019 Alexander Tereshkov. All rights reserved.
//

import Foundation

protocol PatternProvider {
    func getPatterns() -> [ParserPatternProtocol]
}
