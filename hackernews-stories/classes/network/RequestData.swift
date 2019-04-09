//
//  RequestData.swift
//  hackernews-stories
//
//  Created by Alexander Tereshkov on 4/8/19.
//  Copyright © 2019 Alexander Tereshkov. All rights reserved.
//

import Foundation

protocol RequestData {
    var method: RequestHTTPMethod { get }
    var endpoint: String { get }
    var parameters: RequestParameters { get }
    var headers: [String: Any]? { get }
    var dataType: ResponseDataType { get }
}
