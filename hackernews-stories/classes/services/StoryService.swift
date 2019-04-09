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
    
    private let requestExecutor: RequestExecutor
    private let jsonDecoder: JSONDecoderProtocol
    
    init(requestExecutor: RequestExecutor, jsonDecoder: JSONDecoderProtocol) {
        self.requestExecutor = requestExecutor
        self.jsonDecoder = jsonDecoder
    }
    
    func getItem(id: Int, completion: @escaping (Story?, Error?) -> Void) {
        let requestData: RequestData = StoryRequest.getStory(id: id)
        
        do {
            try requestExecutor.execute(request: requestData) { [weak self] response in
                guard let response = response else {
                    completion(nil, NetworkError.noData)
                    return
                }
                switch response {
                case .json(_):
                    completion(nil, nil)
                    ConsoleLog.d("JSON parsing is not handled")
                    break
                case .data(let data):
                    let entity = self?.jsonDecoder.decodeJSON(type: Story.self, from: data)
                    completion(entity, nil)
                case .error(_, let error):
                    completion(nil, error)
                }
            }
        } catch(let error) {
            ConsoleLog.e(error)
            completion(nil, error)
        }
    }
    
}
