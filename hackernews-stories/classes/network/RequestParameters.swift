//
//  RequestParameters.swift
//  hackernews-stories
//
//  Created by Alexander Tereshkov on 4/8/19.
//  Copyright © 2019 Alexander Tereshkov. All rights reserved.
//

import Foundation

enum RequestParameters {
    case body(_ : [String: Any]?)
    case url(_ : [String: Any]?)
}
