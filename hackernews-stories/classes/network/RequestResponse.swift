//
//  RequestResponse.swift
//  hackernews-stories
//
//  Created by Alexander Tereshkov on 4/8/19.
//  Copyright © 2019 Alexander Tereshkov. All rights reserved.
//

import Foundation

typealias ResponseOutput = (response: HTTPURLResponse?, data: Data?, error: Error?)

enum RequestResponse {
    case json(_: Any)
    case data(_: Data)
    case error(_: Int?, _: Error?)
    
    init(_ response: ResponseOutput, for request: RequestData) {
        let acceptableStatusCodes: [Int] = [200, 201]
        
        let statusCode = response.response?.statusCode ?? 0
        guard acceptableStatusCodes.contains(statusCode), response.error == nil else {
            self = .error(response.response?.statusCode, response.error)
            return
        }
        
        guard let data = response.data else {
            self = .error(response.response?.statusCode, NetworkError.noData)
            return
        }
        
        switch request.dataType {
        case .data:
            self = .data(data)
        case .json:
            self = .json(data)
        }
    }
}
