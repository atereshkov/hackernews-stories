//
//  RequestExecutor.swift
//  hackernews-stories
//
//  Created by Alexander Tereshkov on 4/8/19.
//  Copyright © 2019 Alexander Tereshkov. All rights reserved.
//

import Foundation

protocol RequestExecutor {
    
    /// Configure the executor with some environment
    init(configuration: APIConfiguration)
    
    /// Executes the request using RequestData and provides the completion result
    func execute(request: RequestData, completion: @escaping (RequestResponse?) -> ()) throws
    
    // TODO 4/8/19 - add cancel method
    
}
