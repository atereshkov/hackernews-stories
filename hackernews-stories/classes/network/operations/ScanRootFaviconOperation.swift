//
//  ScanRootFaviconOperation.swift
//  hackernews-stories
//
//  Created by Alexander Tereshkov on 4/13/19.
//  Copyright © 2019 Alexander Tereshkov. All rights reserved.
//

import Foundation

class ScanRootFaviconOperation: AsyncOperation {
    
    private weak var task: URLSessionTask?
    
    init(data: RequestData, completion: @escaping (IconProtocol?) -> Void) {
        super.init()
        
        guard let request = prepareRequest(for: data) else { return }
        guard let url = request.url else { return }
        task = URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
            defer { self?.finish() }
            guard error == nil else {
                completion(nil)
                return
            }
            
            guard let response = response else {
                completion(nil)
                return
            }
            
            if let httpResponse = response as? HTTPURLResponse {
                if httpResponse.statusCode == 404 {
                    completion(nil)
                    return
                }
                
                if httpResponse.statusCode < 200 || httpResponse.statusCode > 299 {
                    completion(nil)
                    return
                }
                
                let icon = Icon(url: url, type: .favicon)
                completion(icon)
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
    
    // MARK: Private
    
    private func prepareRequest(for data: RequestData) -> URLRequest? {
        guard let url = URL(string: data.endpoint) else { return nil }
        var apiRequest = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalAndRemoteCacheData)
        apiRequest.httpMethod = data.method.rawValue
        return apiRequest
    }
    
}
