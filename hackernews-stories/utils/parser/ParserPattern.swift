//
//  ParserPattern.swift
//  hackernews-stories
//
//  Created by Alexander Tereshkov on 4/14/19.
//  Copyright © 2019 Alexander Tereshkov. All rights reserved.
//

import Foundation

struct ParserPattern: ParserPatternProtocol {
    let start: String
    let end: String
    let type: IconType
}
