//
//  JSONDecoderService.swift
//  hackernews-stories
//
//  Created by Alexander Tereshkov on 4/9/19.
//  Copyright © 2019 Alexander Tereshkov. All rights reserved.
//

import Foundation

class JSONDecoderService: JSONDecoderProtocol {
    
    func decodeJSON<T: Decodable>(type: T.Type, from data: Data) -> T? {
        do {
            let decodedObject = try JSONDecoder().decode(type.self, from: data)
            return decodedObject
        } catch(let error) {
            Swift.print("JSONDecoder error: \(error)")
            return nil
        }
    }
    
}
