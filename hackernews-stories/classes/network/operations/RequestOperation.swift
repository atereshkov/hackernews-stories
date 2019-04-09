//
//  RequestOperation.swift
//  hackernews-stories
//
//  Created by Alexander Tereshkov on 4/9/19.
//  Copyright © 2019 Alexander Tereshkov. All rights reserved.
//

import Foundation

class RequestOperation: AsynchronousOperation {
    
    private weak var task: URLSessionTask?
    let session: URLSession = URLSession(configuration: .default)
    
    init(executor: RequestExecutor, request: RequestData) {
        super.init()
        
        let jsonDecoder = JSONDecoderService()
        
        task = try? executor.execute(request: request) { [weak self] response in
            defer { self?.finish() }
            
            guard let response = response else { return }
            switch response {
            case .json(_):
                ConsoleLog.d("JSON parsing is not handled")
                break
            case .data(let data):
                let entity = jsonDecoder.decodeJSON(type: Story.self, from: data)
                Swift.print(entity)
            case .error(_, let error):
                ConsoleLog.e("Error occured: \(String(describing: error))")
            }
        }
    }
    
    override func cancel() {
        task?.cancel()
        super.cancel()
    }
    
    override func main() {
        task?.resume()
    }
    
}
