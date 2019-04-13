//
//  RequestOperation.swift
//  hackernews-stories
//
//  Created by Alexander Tereshkov on 4/9/19.
//  Copyright © 2019 Alexander Tereshkov. All rights reserved.
//

import Foundation

enum RequestOperationError: Error {
    case responseMethodNotHandled
}

class RequestOperation<T: Decodable>: BlockRequestOperation {
    
    private weak var task: URLSessionTask?
    
    init(executor: RequestExecutor, request: RequestData, completion: @escaping (T?, Error?) -> Void) {
        super.init()
        
        let jsonDecoder = JSONDecoderService()
        
        task = try? executor.prepare(requestData: request) { [weak self] response in
            defer { self?.finish() }
            
            guard let response = response else { return }
            switch response {
            case .json(_):
                completion(nil, RequestOperationError.responseMethodNotHandled)
            case .data(let data):
                let entity = jsonDecoder.decodeJSON(type: T.self, from: data)
                completion(entity, nil)
            case .error(_, let error):
                completion(nil, error)
            }
        }
        task?.resume()
    }
    
    override func cancel() {
        task?.cancel()
        super.cancel()
    }
    
    override func main() {
        task?.resume()
    }
    
}
