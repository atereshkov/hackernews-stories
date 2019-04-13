//
//  RequestOperation.swift
//  hackernews-stories
//
//  Created by Alexander Tereshkov on 4/9/19.
//  Copyright © 2019 Alexander Tereshkov. All rights reserved.
//

import Foundation

class RequestOperation: BlockRequestOperation {
    
    private weak var task: URLSessionTask?
    
    init(executor: RequestExecutor, request: RequestData, completion: @escaping (Story?) -> Void) {
        super.init()
        
        let jsonDecoder = JSONDecoderService()
        
        task = try? executor.prepare(requestData: request) { [weak self] response in
            defer { self?.finish() }
            
            guard let response = response else { return }
            switch response {
            case .json(_):
                ConsoleLog.d("JSON parsing is not handled")
                break
            case .data(let data):
                let entity = jsonDecoder.decodeJSON(type: Story.self, from: data)
                completion(entity)
            case .error(_, let error):
                ConsoleLog.e("Error occured: \(String(describing: error))")
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
