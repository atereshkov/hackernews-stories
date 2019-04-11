//
//  Icon.swift
//  hackernews-stories
//
//  Created by Alexander Tereshkov on 4/11/19.
//  Copyright © 2019 Alexander Tereshkov. All rights reserved.
//

import Foundation

protocol IconProtocol {
    var url: URL { get }
    var type: IconType { get }
}

struct Icon: IconProtocol {
    let url: URL
    let type: IconType
}
