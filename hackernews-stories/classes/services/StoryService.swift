//
//  StoryService.swift
//  hackernews-stories
//
//  Created by Alexander Tereshkov on 4/8/19.
//  Copyright © 2019 Alexander Tereshkov. All rights reserved.
//

import Foundation

protocol StoryServiceProtocol {
    func getItem(id: Int, completion: @escaping (StoryType?, Error?) -> Void)
    func getItems(ids: [Int], completion: @escaping ([StoryType], Error?) -> Void)
    func getBestStoriesIds(completion: @escaping ([Int]?, Error?) -> Void)
}

final class StoryService: StoryServiceProtocol {
    
    private let requestExecutor: RequestExecutor
    private let jsonDecoder: JSONDecoderProtocol
    
    init(requestExecutor: RequestExecutor, jsonDecoder: JSONDecoderProtocol) {
        self.requestExecutor = requestExecutor
        self.jsonDecoder = jsonDecoder
    }
    
    func getItem(id: Int, completion: @escaping (StoryType?, Error?) -> Void) {
        let requestData: RequestData = StoryRequest.getStory(id: id)
        
        do {
            _ = try requestExecutor.execute(requestData: requestData) { [weak self] response in
                guard let response = response else {
                    DispatchQueue.main.async {
                        completion(nil, NetworkError.noData)
                    }
                    return
                }
                switch response {
                case .json(_):
                    DispatchQueue.main.async {
                        completion(nil, nil)
                    }
                    ConsoleLog.d("JSON parsing is not handled")
                    break
                case .data(let data):
                    let entity = self?.jsonDecoder.decodeJSON(type: Story.self, from: data)
                    DispatchQueue.main.async {
                        completion(entity, nil)
                    }
                case .error(_, let error):
                    ConsoleLog.e("Error occured: \(String(describing: error))")
                    DispatchQueue.main.async {
                        completion(nil, error)
                    }
                }
            }
        } catch(let error) {
            ConsoleLog.e(error)
            DispatchQueue.main.async {
                completion(nil, error)
            }
        }
    }
    
    func getItems(ids: [Int], completion: @escaping ([StoryType], Error?) -> Void) {
        var items: [StoryType] = []
        
        let completionBlock = BlockOperation { [weak self] in
            DispatchQueue.main.async {
                completion(items, nil)
            }
        }
        
        for id in ids {
            let request = StoryRequest.getStory(id: id)
            let operation = RequestOperation(executor: requestExecutor, request: request) { [weak self] story in
                guard let story = story else { return }
                items.append(story)
            }
            completionBlock.addDependency(operation)
        }
        
        OperationQueue.main.addOperation(completionBlock)
    }
    
    func getBestStoriesIds(completion: @escaping ([Int]?, Error?) -> Void) {
        let requestData: RequestData = StoryRequest.getBeststories
        
        do {
            _ = try requestExecutor.execute(requestData: requestData) { [weak self] response in
                guard let response = response else {
                    DispatchQueue.main.async {
                        completion([], NetworkError.noData)
                    }
                    return
                }
                switch response {
                case .json(_):
                    DispatchQueue.main.async {
                        completion([], nil)
                    }
                    ConsoleLog.d("JSON parsing is not handled")
                    break
                case .data(let data):
                    let array = self?.jsonDecoder.decodeJSON(type: [Int].self, from: data)
                    DispatchQueue.main.async {
                        completion(array, nil)
                    }
                case .error(_, let error):
                    ConsoleLog.e("Error occured: \(String(describing: error))")
                    DispatchQueue.main.async {
                        completion([], error)
                    }
                }
            }
        } catch(let error) {
            ConsoleLog.e(error)
            DispatchQueue.main.async {
                completion([], error)
            }
        }
    }
    
}
