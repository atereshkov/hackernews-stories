//
//  StoryService.swift
//  hackernews-stories
//
//  Created by Alexander Tereshkov on 4/8/19.
//  Copyright © 2019 Alexander Tereshkov. All rights reserved.
//

import Foundation

protocol StoryServiceProtocol {
    func getItem(id: Int, completion: @escaping (Story?, Error?) -> Void)
}

final class StoryService: StoryServiceProtocol {
    
    private var requestExecutor: RequestExecutor?
    
    init(requestExecutor: RequestExecutor) {
        self.requestExecutor = requestExecutor
    }
    
    func getItem(id: Int, completion: @escaping (Story?, Error?) -> Void) {
        let requestData: RequestData = StoryRequest.getStory(id: id)
        
        do {
            try requestExecutor?.execute(request: requestData) { response in
                guard let response = response else {
                    completion(nil, NetworkError.noData)
                    return
                }
                switch response {
                case .json(_):
                    completion(nil, nil)
                    break
                case .data(let data):
                    let entity = self.decodeJSON(type: Story.self, from: data)
                    completion(entity, nil)
                case .error(_, let error):
                    completion(nil, error)
                }
            }
        } catch(let error) {
            Swift.print(error)
            completion(nil, error)
        }
    }
    
    private func decodeJSON<T: Decodable>(type: T.Type, from: Data?) -> T? {
        let decoder = JSONDecoder()
        guard let data = from, let response = try? decoder.decode(type.self, from: data) else { return nil }
        return response
    }
    
}
