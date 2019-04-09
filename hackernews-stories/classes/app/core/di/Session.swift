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
        
        container = {
            let storyService = StoryService(requestExecutor: networkRequestExecutor)
            container.addService { storyService as StoryServiceProtocol }
            return container
        }()
    }
    
    func resolve<T>() -> T {
        guard let service: T = container.getService() else {
            fatalError("Service is not registered '\(String(describing: T.self))'")
        }
        return service
    }
    
}
