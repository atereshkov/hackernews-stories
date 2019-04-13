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
    
    func execute(requestData: RequestData, completion: @escaping (RequestResponse?) -> Void) throws {
        let request = try self.prepare(data: requestData)
        task = prepareTask(requestData: requestData, request: request, completion: completion)
        task?.resume()
    }
    
    func prepare(requestData: RequestData, completion: @escaping (RequestResponse?) -> Void) throws -> URLSessionTask? {
        let request = try self.prepare(data: requestData)
        task = prepareTask(requestData: requestData, request: request, completion: completion)
        return task
    }
    
    func prepare(data: RequestData) throws -> URLRequest {
        let fullUrl = "\(configuration.baseURL)/\(data.endpoint)"
        guard let url = URL(string: fullUrl) else {
            throw NetworkError.incorrectInput
        }
        
        var apiRequest = URLRequest(url: url, cachePolicy: configuration.cachePolicy)
        
        switch data.parameters {
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
        data.headers?.forEach {
            apiRequest.addValue($0.value as! String, forHTTPHeaderField: $0.key)
        }
        
        apiRequest.httpMethod = data.method.rawValue
        return apiRequest
    }
    
    private func prepareTask(requestData: RequestData, request: URLRequest, completion: @escaping (RequestResponse?) -> Void) -> URLSessionTask {
        let task = session.dataTask(with: request) { (data, response, error) in
            let httpResponse = response as? HTTPURLResponse
            let response = RequestResponse((httpResponse, data, error), for: requestData)
            completion(response)
        }
        return task
    }
    
}
