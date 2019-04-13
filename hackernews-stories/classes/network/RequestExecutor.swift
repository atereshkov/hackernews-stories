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
    func execute(requestData: RequestData, completion: @escaping (RequestResponse?) -> Void) throws
    
    /// Returns URLSessionTask with completion handler
    func prepare(requestData: RequestData, completion: @escaping (RequestResponse?) -> Void) throws -> URLSessionTask?
    
}
