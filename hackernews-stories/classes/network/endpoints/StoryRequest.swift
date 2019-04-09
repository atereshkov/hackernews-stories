//
//  StoryRequest.swift
//  hackernews-stories
//
//  Created by Alexander Tereshkov on 4/8/19.
//  Copyright © 2019 Alexander Tereshkov. All rights reserved.
//

import Foundation

enum StoryRequest {
    case getStory(id: Int)
    case getBeststories
}

extension StoryRequest: RequestData {
    
    var endpoint: String {
        switch self {
        case .getStory(let id):
            return "item/\(id).json"
        case .getBeststories:
            return "beststories.json"
        }
    }
    
    var parameters: RequestParameters {
        switch self {
        case .getStory(_):
            return .url([:])
        case .getBeststories:
            return .url([:])
        }
    }
    
    var headers: [String : Any]? {
        return [:]
    }
    
    var method: RequestHTTPMethod {
        switch self {
        case .getStory(_):
            return .get
        case .getBeststories:
            return .get
        }
    }
    
    var dataType: ResponseDataType {
        switch self {
        case .getStory(_):
            return .data
        case .getBeststories:
            return .data
        }
    }
}
