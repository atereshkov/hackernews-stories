//
//  RequestExecutorFactory.swift
//  hackernews-stories
//
//  Created by Alexander Tereshkov on 4/8/19.
//  Copyright © 2019 Alexander Tereshkov. All rights reserved.
//

import Foundation

class RequestExecutorFactory {
    
    private var configuration: APIConfiguration
    
    required init(configuration: APIConfiguration) {
        self.configuration = configuration
    }
    
    func makeNetworkExecutor() -> RequestExecutor {
        return NetworkRequestExecutor(configuration: configuration)
    }
    
}
