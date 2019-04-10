//
//  NetworkRequestExecutor.swift
//  hackernews-stories
//
//  Created by Alexander Tereshkov on 4/8/19.
//  Copyright © 2019 Alexander Tereshkov. All rights reserved.
//

import Foundation

class NetworkRequestExecutor: RequestExecutor {
    
    private let session: URLSession
    private let configuration: APIConfiguration
    
    private weak var task: URLSessionTask?
    
    required init(configuration: APIConfiguration) {
        self.session = URLSession(configuration: .default)
        self.configuration = configuration
    }
    
    func execute(request: RequestData, completion: @escaping (RequestResponse?) -> ()) throws -> URLSessionTask? {
        let taskRequest = try self.prepare(request: request)
        task = session.dataTask(with: taskRequest) { (data, response, error) in
            let httpResponse = response as? HTTPURLResponse
            let response = RequestResponse((httpResponse, data, error), for: request)
            completion(response)
        }
        task?.resume()
        return task
    }
    
    func prepare(request: RequestData) throws -> URLRequest {
        let fullUrl = "\(configuration.baseURL)/\(request.endpoint)"
        guard let url = URL(string: fullUrl) else {
            throw NetworkError.incorrectInput
        }
        
        var apiRequest = URLRequest(url: url, cachePolicy: configuration.cachePolicy)
        
        switch request.parameters {
        case .body(let params):
            if let params = params as? [String : String] {
                let body = try? JSONEncoder().encode(params)
                apiRequest.httpBody = body
            } else {
                throw NetworkError.incorrectInput
            }
            
        case .url(let params):
            if let params = params as? [String : String] {
                let queryParams = params.map { pair  in
                    return URLQueryItem(name: pair.key, value: pair.value)
                }
                guard var components = URLComponents(string: fullUrl) else {
                    throw NetworkError.incorrectInput
                }
                components.queryItems = queryParams
                apiRequest.url = components.url
            } else {
                throw NetworkError.incorrectInput
            }
        }
        
        configuration.headers.forEach {
            apiRequest.addValue($0.value as! String, forHTTPHeaderField: $0.key)
        }
        request.headers?.forEach {
            apiRequest.addValue($0.value as! String, forHTTPHeaderField: $0.key)
        }
        
        apiRequest.httpMethod = request.method.rawValue
        return apiRequest
    }
    
}
