//
//  RootFaviconRequest.swift
//  hackernews-stories
//
//  Created by Alexander Tereshkov on 4/13/19.
//  Copyright © 2019 Alexander Tereshkov. All rights reserved.
//

import Foundation

enum RootIconRequest {
    case checkFavicon(url: String)
    case checkAppleTouchIcon(url: String)
}

extension RootIconRequest: RequestData {
    
    var endpoint: String {
        switch self {
        case .checkFavicon(let url):
            return url
        case .checkAppleTouchIcon(let url):
            return url
        }
    }
    
    var parameters: RequestParameters {
        switch self {
        case .checkFavicon(_):
            return .url([:])
        case .checkAppleTouchIcon(_):
            return .url([:])
        }
    }
    
    var headers: [String : Any]? {
        return [:]
    }
    
    var method: RequestHTTPMethod {
        switch self {
        case .checkFavicon(_):
            return .head
        case .checkAppleTouchIcon(_):
            return .head
        }
    }
    
    var dataType: ResponseDataType {
        switch self {
        case .checkFavicon(_):
            return .data
        case .checkAppleTouchIcon(_):
            return .data
        }
    }
}
