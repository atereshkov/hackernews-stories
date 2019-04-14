//
//  Session.swift
//  hackernews-stories
//
//  Created by Alexander Tereshkov on 4/8/19.
//  Copyright © 2019 Alexander Tereshkov. All rights reserved.
//

import Foundation

final class Session: SessionType {
    
    private var container = Container()
    
    init() {
        let configuration = APIConfiguration(.dev, baseURL: "https://hacker-news.firebaseio.com/v0/")
        let executorFactory = RequestExecutorFactory(configuration: configuration)
        let networkRequestExecutor = executorFactory.makeNetworkExecutor()
        let jsonDecoder = JSONDecoderService()
        
        container = {
            let storyService = StoryService(requestExecutor: networkRequestExecutor, jsonDecoder: jsonDecoder)
            container.addService { storyService as StoryServiceProtocol }
            return container
        }()
    }
    
    /// Returns an service from container if it can be resolved, otherwise will produce fatalError, so be sure that service is registered and that is tested before resolving
    func resolve<T>() -> T {
        guard let service: T = container.getService() else {
            fatalError("Service is not registered '\(String(describing: T.self))'")
        }
        return service
    }
    
}
