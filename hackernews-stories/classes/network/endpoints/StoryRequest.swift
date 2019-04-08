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
}

extension StoryRequest: RequestData {
    
    var endpoint: String {
        switch self {
        case .getStory(let id):
            return "item/\(id).json"
        }
    }
    
    var parameters: RequestParameters {
        switch self {
        case .getStory(_):
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
        }
    }
    
    var dataType: ResponseDataType {
        switch self {
        case .getStory(_):
            return .data
        }
    }
}
