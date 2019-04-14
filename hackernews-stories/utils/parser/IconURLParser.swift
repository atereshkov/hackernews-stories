//
//  IconParser.swift
//  hackernews-stories
//
//  Created by Alexander Tereshkov on 4/14/19.
//  Copyright © 2019 Alexander Tereshkov. All rights reserved.
//

import Foundation

protocol IconURLParser {
    func parse(baseURL: URL) -> [IconProtocol]
}
