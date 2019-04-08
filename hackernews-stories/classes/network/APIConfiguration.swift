//
//  APIConfiguration.swift
//  hackernews-stories
//
//  Created by Alexander Tereshkov on 4/8/19.
//  Copyright © 2019 Alexander Tereshkov. All rights reserved.
//

import Foundation

enum APIConfigurationType {
    case dev
    case staging
    case production
}

struct APIConfiguration {
    
    /// Type of the configuration
    var type: APIConfigurationType
    
    /// Base URL of the configuration
    var baseURL: String
    
    /// Common headers for all requests if any
    var headers: [String: Any] = [:]
    
    /// Cache policy that stands for the configuration
    var cachePolicy: URLRequest.CachePolicy = .reloadIgnoringLocalAndRemoteCacheData
    
    init(_ type: APIConfigurationType, baseURL: String) {
        self.type = type
        self.baseURL = baseURL
    }
}
